/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.file.Paths;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DAOCategories;
import model.DAOFeedBack;
import model.DAOLog;
import model.DAOProduct;
import model.DAOProductImage;
import model.DAOUser;
import view.Categories;
import view.Log;
import view.Product;
import view.ProductImage;
import view.User;

/**
 *
 * @author HP
 */
@WebServlet(name = "ControllerEditProductmkt", urlPatterns = {"/EditProductmktURL"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class ControllerEditProductmkt extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            // Create a DAOProduct instance
            HttpSession session = request.getSession();
            User oldUser = (User) session.getAttribute("account");
            if (oldUser == null) {
                response.sendRedirect("HomePageURL");
            }else {
                
            DAOProduct dao = new DAOProduct();
            DAOLog daoLog = new DAOLog();
            DAOProductImage daoPI = new DAOProductImage();
            DAOCategories daoCategories = new DAOCategories();
            DAOUser daoU = new DAOUser();
            String service = request.getParameter("service");
            String message = request.getParameter("message");
            int updateBy = oldUser.getUserID(); // nhan vien
            if (service == null || service.isEmpty()) {
                service = "";
            }
            if (service.equals("update")) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                String productName = request.getParameter("productName");
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                String productDescription = request.getParameter("productDescription");
                int unitInStock = Integer.parseInt(request.getParameter("unitInStock"));
                double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
                int unitDiscount = Integer.parseInt(request.getParameter("unitDiscount"));
                String createDate = request.getParameter("createDate");
                int totalStock = Integer.parseInt(request.getParameter("totalStock"));
                int productStatusValue = Integer.parseInt(request.getParameter("productStatus"));
                boolean productStatus = (productStatusValue == 0);
                String purpose;
                int n = 0;
                Product product = new Product(productId, productName, categoryId, productDescription, 
                        unitInStock, unitPrice, unitDiscount, createDate, totalStock, totalStock, productStatus);
                n = dao.updateProduct(product);
                if (productStatus == true) {
                    productStatusValue = 0;
                    dao.updateStatus(productId, 0);
                    purpose = "đã kích hoạt sản phẩm "+ productName;
                    System.out.println("updateed status from off to on");
                } else {
                    dao.updateStatus(productId, 1);
                    productStatusValue = 1;
                    purpose = "đã vô hiệu hóa sản phẩm "+ productName;
                    System.out.println("updateed status from on to off");
                }
                Log log = new Log(updateBy, updateBy, purpose);
                daoLog.insertLog(log);
                int countImg = Integer.parseInt(request.getParameter("countImg"));
                String convertCategory = convertCate(categoryId);
                String fileName;
                String radio = request.getParameter("default");
                int radioChoice = 0;
                if (radio == null) {
                    ResultSet rsRadio = daoPI.getData("select * from ProductImage where ProductID =" + productId);
                    try {
                        if (rsRadio.next()) {
                            System.out.println("àter fix: " + rsRadio.getString("ProductURLShow").replaceAll("[a-zA-Z]+", ""));
                            radioChoice = Integer.parseInt(rsRadio.getString("ProductURLShow").replaceAll("[a-zA-Z]+", ""));
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(ControllerEditProductmkt.class.getName()).log(Level.SEVERE, null, ex);
                    }
                } else {
                    radioChoice = Integer.parseInt(radio);
                }
                System.out.println("radio = " + radioChoice);
                for (int i = 1; i <= countImg; i++) {
                    String productImageURL = "images/product/" + convertCategory + "/";
                    String oldImageUrl = request.getParameter("oldImageUrl" + i);
                    Part imgURL = request.getPart("productImageUrl" + i);
                    String realImgURL = imgURL.getSubmittedFileName();
                    if (realImgURL.equals("") || realImgURL == null) {
                        productImageURL = oldImageUrl;
                        System.out.println("realImg" + i + "=null => ProductImageURL = " + productImageURL);
                    } else {
                        realImgURL = imgURL.getSubmittedFileName();
                        if (!("images/product/" + convertCategory + "/" + realImgURL).equals(oldImageUrl)) {
                            System.out.println("realImg = " + realImgURL + " != olfImageURL = " + oldImageUrl);
                            int index = realImgURL.lastIndexOf(".");
                            String tailType = realImgURL.substring(index);
                            productImageURL += realImgURL.substring(0, index) + "_" + i + tailType;
                            ProductImage pi = new ProductImage(productId, productImageURL, productImageURL);
                            daoPI.updateImage(productImageURL, productId, oldImageUrl);
                            System.out.println("realImg" + i + "!=null => ProductImageURL = " + productImageURL);
                            imgURL.write("D:\\project_github\\Online_Shop_System_Smartket\\web\\" + productImageURL);
                            imgURL.write("D:\\project_github\\Online_Shop_System_Smartket\\build\\web\\" + productImageURL);
                        } else {
                            System.out.println("realImg = " + realImgURL + " == oldImageURL = " + oldImageUrl);
                            System.out.println("and PRoductimageURL = " + productImageURL);
                        }
                    }

                    if (radioChoice == i) {
                        System.out.println("radio = i");
                        n = daoPI.updateProductImage(productId, productImageURL);
                    } else {
                        n = daoPI.updateImage(productImageURL, productId, oldImageUrl);
                    }

                }
                request.setAttribute("radioChoice", radioChoice);
                String st = (n > 0) ? "Cập nhật sản phẩm thành công" : "Cập nhật sản phẩm thất bại";
                response.sendRedirect("mktProductListURL?message=" + URLEncoder.encode(st, "UTF-8"));
            }
            if (service.isEmpty()) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                String radio = request.getParameter("default");
                int radioChoice = 0;
                if (radio == null) {
                    ResultSet rsRadio = daoPI.getData("select * from ProductImage where ProductID =" + productId);
                    try {
                        if (rsRadio.next()) {
                            radioChoice = Integer.parseInt(rsRadio.getString("ProductURLShow").replaceAll(".*_(\\d+)\\..*", "$1"));
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(ControllerEditProductmkt.class.getName()).log(Level.SEVERE, null, ex);
                    }
                } else {
                    radioChoice = Integer.parseInt(radio);
                }
                Product product = dao.getProductById(productId);
                if (product != null) {
                    request.setAttribute("product", product);
                    request.setAttribute("productStatus", product.isProductStatus() ? 0 : 1);
                    ResultSet logger = daoU.getData("SELECT * FROM loghistory as log join `user` as u on log.UserId = u.UserID where u.UserId = " + updateBy + " and purpose like '%sản phẩm%' order by updateAt desc");
                    request.setAttribute("log", logger);
                } else {
                    System.out.println("Product not found");
                }
                Vector<Categories> categories = daoCategories.getCategories("SELECT * FROM categories");
                request.setAttribute("categories", categories);
                request.setAttribute("radioChoice", radioChoice);
                request.getRequestDispatcher("updateProductmkt.jsp").forward(request, response);
            }
            }

        }
    }
// Phương thức để lấy tên của file từ một Part

    private String getFileName(Part part) {
        String contentDispositionHeader = part.getHeader("content-disposition");
        String[] elements = contentDispositionHeader.split(";");
        for (String element : elements) {
            if (element.trim().startsWith("filename")) {
                return element.substring(element.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void moveImage(HttpServletRequest request, HttpServletResponse response, String ProductURL, Part filePart) throws ServletException, IOException {
//        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
//        Part filePart = request.getPart("productImageUrl");
//        
//        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
//        String cateID = convertCate(categoryId);
//
//        // Extracting the name and tail from the file name
//        int index = fileName.lastIndexOf(".");
//        String name = fileName.substring(0, index);
//        String tail = fileName.substring(index);

        // Specify the destination directory
        String destinationDirectory = "D:\\Workspace\\SPRING2024\\online_shop_system\\Online_Shop_System_Smartket\\web\\" + ProductURL;

        // Write the uploaded file to the destination directory
        try ( InputStream fileContent = filePart.getInputStream();  OutputStream outputStream = new FileOutputStream(destinationDirectory)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileContent.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
            System.out.println("File moved successfully to: " + destinationDirectory);
        } catch (IOException e) {
            System.err.println("Error moving file: " + e.getMessage());
        }
    }

    protected String convertCate(int cateID) {
        String result = "";
        switch (cateID) {
            case 1:
                result = "diengiadung";
                break;
            case 2:
                result = "vatdunggiadinh";
                break;
            case 3:
                result = "thucphamchebien";
                break;
            case 4:
                result = "doanvat";
                break;
            case 5:
                result = "dodunghoctap";
                break;
            case 6:
                result = "dodungyte";
                break;
            case 7:
                result = "douong";
                break;
            case 8:
                result = "dungcunhabep";
                break;
            case 9:
                result = "noithat";
                break;
            case 10:
                result = "traicay";
                break;
        }
        return result;
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
