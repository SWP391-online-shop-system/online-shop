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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Locale.Category;
import java.util.Vector;
import model.DAOCategories;
import model.DAOProduct;
import view.Categories;
import view.Product;

/**
 *
 * @author HP
 */
@WebServlet(name = "ControllerSaleProductList", urlPatterns = {"/mktProductListURL"})
public class ControllerMarketingProductList extends HttpServlet {

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOProduct dao = new DAOProduct();
        DAOCategories daoCate = new DAOCategories();
        String indexPage = request.getParameter("index");
        String categoryId = request.getParameter("categoryId");
        String status = request.getParameter("status"); // Get the status parameter
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);
        int itemsPerPage = 10;
        ResultSet rs;
        String sql = "SELECT p.*, c.*, MIN(pi.ProductURL) AS ProductURL\n"
                + "FROM Product AS p\n"
                + "JOIN Categories AS c ON p.CategoryID = c.CategoryID\n"
                + "LEFT JOIN ProductImage AS pi ON p.ProductID = pi.ProductID\n";
        if (categoryId != null && !categoryId.isEmpty()) {
            sql += "WHERE p.CategoryID = " + categoryId + "\n";
        }
        if (status != null && !status.isEmpty()) {
            if (sql.contains("WHERE")) {
                sql += "AND ";
            } else {
                sql += "WHERE ";
            }
            if (status.equals("Còn hàng")) {
                sql += "p.UnitInStock > 0\n"; // Filter products in stock
            } else if (status.equals("Hết hàng")) {
                sql += "p.UnitInStock = 0\n"; // Filter out-of-stock products
            }
        }
        sql += "GROUP BY p.ProductID\n";

        rs = dao.getData(sql);

        int count = dao.getTotalProduct();
        int endPage = (int) Math.ceil((double) count / itemsPerPage);
        Vector<Categories> categories = daoCate.getCategories("SELECT * FROM categories");
        request.setAttribute("categories", categories);
        request.setAttribute("data", rs);
        request.setAttribute("currentPage", index);
        request.setAttribute("endPage", endPage);
        request.getRequestDispatcher("productListmkt1.jsp").forward(request, response);
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
