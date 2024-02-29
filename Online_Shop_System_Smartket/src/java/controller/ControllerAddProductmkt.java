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
import jakarta.servlet.http.Part;
import model.DAOProduct;
import model.DAOProductImage;
import view.Product;
import view.ProductImage;
import java.io.*;
import java.net.URLEncoder;
import java.nio.file.Paths;
import java.util.Vector;
import model.DAOCategories;
import view.Categories;

/**
 *
 * @author HP
 */
@WebServlet(name = "ControllerAddProductmkt", urlPatterns = {"/AddProductmktURL"})
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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ControllerAddProductmkt</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControllerAddProductmkt at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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

    protected void moveImage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        Part filePart = request.getPart("productImageUrl");

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String cateID = convertCate(categoryId);

        // Extracting the name and tail from the file name
        int index = fileName.lastIndexOf(".");
        String name = fileName.substring(0, index);
        String tail = fileName.substring(index);

        // Specify the destination directory
        String destinationDirectory = "D:\\Workspace\\SPRING2024\\online_shop_system\\Online_Shop_System_Smartket\\web\\images\\product\\" + cateID + "\\" + name + "_1" + tail;

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOCategories daoCategories = new DAOCategories();
        int productID = Integer.parseInt(request.getParameter("productID"));
        String productName = request.getParameter("productName");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String productDescription = request.getParameter("productDescription");
        int unitInStock = Integer.parseInt(request.getParameter("unitInStock"));
        double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
        int unitDiscount = Integer.parseInt(request.getParameter("unitDiscount"));
        int totalStock = Integer.parseInt(request.getParameter("totalStock"));
        String convert = convertCate(categoryId);
        Part productImageUrl_raw = request.getPart("productImageUrl");
        String fileName = productImageUrl_raw.getSubmittedFileName();
        int index = fileName.lastIndexOf(".");
        String name = fileName.substring(0, index);
        String tail = fileName.substring(index);
        String productImageURL = "images/product/" + convert + "/" + name + "_1" + tail;
        String productImageUrlShow = productImageURL;
        Product newProduct = new Product(productName, categoryId, productDescription, unitInStock, unitPrice, unitDiscount, totalStock);
        DAOProduct daoProduct = new DAOProduct();
        int n = daoProduct.insertProduct(newProduct);
        DAOProductImage dao = new DAOProductImage();
        dao.insertImage(new ProductImage(productID, productImageURL, productImageUrlShow));
        moveImage(request, response);
        String st = (n > 0) ? "Thêm sản phẩm thành công" : "Thêm sản phẩm thất bại";
        Vector<Categories> categories = daoCategories.getCategories("SELECT * FROM categories");
        request.setAttribute("categories", categories);
        response.sendRedirect("mktProductListURL?message=" + URLEncoder.encode(st, "UTF-8"));
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
