/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DAOProduct;
import view.Product;

/**
 *
 * @author HP
 */
@WebServlet(name = "ControllerEditProductmkt", urlPatterns = {"/EditProductmktURL"})
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
            /* TODO output your page here. You may use following sample code. */
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
        // Create a DAOProduct instance
        DAOProduct dao = new DAOProduct();
        String service = request.getParameter("service");
        if(service == null || service.equals("")) {
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
            int totalRate = Integer.parseInt(request.getParameter("totalRate"));
            int totalStock = Integer.parseInt(request.getParameter("totalStock"));
            Product product = new Product(productId, productName, categoryId, productDescription,
                    unitInStock, unitPrice, unitDiscount, createDate, totalRate, totalStock);
            dao.updateProduct(product);
            request.getRequestDispatcher("mktProductListURL").forward(request, response);
        }
        if(service.equals("")) {
        int productId = Integer.parseInt(request.getParameter("productId"));
        Product product = dao.getProductById(productId);
        if (product != null) {
            request.setAttribute("product", product);
        } else {
            System.out.println("Product not found");
        }
            request.getRequestDispatcher("updateProductmkt.jsp").forward(request, response);
        }
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
