/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.DAOProduct;
import model.DAOProductImage;
import view.Product;
import view.ProductImage;
import java.io.*;
import java.net.URLEncoder;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Vector;
import model.DAOCategories;
import model.DAOLog;
import view.Categories;
import view.Log;
import view.User;

/**
 *
 * @author HP
 */
@WebServlet(name = "ControllerAddProductmkt", urlPatterns = {"/marketingAddProductmktURL"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class ControllerAddProductmkt extends HttpServlet {

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
            request.getRequestDispatcher("addProductmkt.jsp").forward(request, response);
        }
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

    protected String moveAndRenameImage(Part filePart, int categoryId, int imageIndex) throws ServletException, IOException {
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String cateID = convertCate(categoryId);
        String newFileName = fileName.substring(0, fileName.lastIndexOf('.')) + "_" + imageIndex + fileName.substring(fileName.lastIndexOf('.'));
        String destinationDirectory = "D:/fpt/Semeter_5/SWP391/Project_GitHub/Online_Shop_System_Smartket/web/images/product" + cateID;
        File directory = new File(destinationDirectory);
        if (!directory.exists()) {
            directory.mkdirs();
        }
        String destinationFilePath = destinationDirectory + "/" + newFileName;
        try ( InputStream fileContent = filePart.getInputStream();  OutputStream outputStream = new FileOutputStream(destinationFilePath)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileContent.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
            String relativeUrl = "images/product/" + cateID + "/" + newFileName;
            return relativeUrl;
        } catch (IOException e) {
            return null;
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOCategories daoCategories = new DAOCategories();
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("account");
        if (u == null) {
            String message = "Bạn cần đăng nhập";
            request.getRequestDispatcher("LoginURL").forward(request, response);
        }
        int productID = Integer.parseInt(request.getParameter("productID"));
        String productName = request.getParameter("productName");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String productDescription = request.getParameter("productDescription");
        int unitInStock = Integer.parseInt(request.getParameter("unitInStock"));
        double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
        int unitDiscount = Integer.parseInt(request.getParameter("unitDiscount"));
        int totalStock = unitInStock;
        String convert = convertCate(categoryId);
        Part productImageUrl_raw = request.getPart("productImageUrl");
        Product newProduct = new Product(productName, categoryId, productDescription, unitInStock, unitPrice, unitDiscount, totalStock);
        Collection<Part> parts = request.getParts();
        int imageIndex = 1; // Initialize the index for the first image
        String firstImageUrl = null;
        List<String> imageUrls = new ArrayList<>(); // List to store image URLs
        boolean hasInvalidImage = false; // Flag to track if there is any invalid image
        for (Part part : parts) {
            if ("productImageUrl".equals(part.getName())) {
                if (part.getContentType() != null && part.getContentType().startsWith("image/")) {
                    String imageUrl = moveAndRenameImage(part, categoryId, imageIndex);
                    imageUrls.add(imageUrl); // Add the new image URL to the list
                    if (firstImageUrl == null) {
                        firstImageUrl = imageUrl; // Store the URL of the first image added
                    }
                    imageIndex++; // Increment the index for the next image
                } else {
                    // Set flag indicating there is an invalid image
                    hasInvalidImage = true;
                    // Set error message for invalid image file
                    request.setAttribute("errorMessage", "File ảnh không hợp lệ: " + part.getSubmittedFileName());
                    // Redirect back to the form page with error message
                    request.getRequestDispatcher("addProductmkt.jsp").forward(request, response);
                    return; // Stop further processing
                }
            }
        }

        // Check if there is any invalid image before inserting into the database
        if (!hasInvalidImage) {
            // Perform database insertion after moving all images
            DAOProduct daoProduct = new DAOProduct();
            int n = daoProduct.insertProduct(newProduct);

            DAOLog daoLog = new DAOLog();
            Log log = new Log(productID, 1, "Thêm", u.getUserID(), "Đã thêm 1 sản phẩm");
            daoLog.insertLog(log);
            DAOProductImage dao = new DAOProductImage();
            for (String imageUrl : imageUrls) {
                // Extract relative path
                String relativeImageUrl = imageUrl.substring(imageUrl.indexOf("images"));
                dao.insertImage(new ProductImage(productID, relativeImageUrl, firstImageUrl)); // Assuming imageUrlShow is the same as imageUrl
            }
            String st = (n > 0) ? "Thêm sản phẩm thành công" : "Thêm sản phẩm thất bại";
            Vector<Categories> categories = daoCategories.getCategories("SELECT * FROM categories");
            request.setAttribute("categories", categories);
            response.sendRedirect("marketingProductListURL?message=" + URLEncoder.encode(st, "UTF-8"));
        }
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
