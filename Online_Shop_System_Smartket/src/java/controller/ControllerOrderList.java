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
import java.time.LocalDate;
import java.util.Vector;
import model.DAOCategories;
import model.DAOOrder;
import model.DAOProduct;
import view.Categories;

/**
 *
 * @author HP
 */
@WebServlet(name = "ControllerOrderList", urlPatterns = {"/OrderListURL"})
public class ControllerOrderList extends HttpServlet {

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
            DAOOrder dao = new DAOOrder();
            String fromDate = request.getParameter("fromDate");
            String toDate = request.getParameter("toDate");

            // Check if fromDate and toDate are empty, then set them to null
            if (fromDate != null && fromDate.isEmpty()) {
                fromDate = null;
            }
            if (toDate != null && toDate.isEmpty()) {
                toDate = null;
            }

            // Construct SQL query with optional date range
            String sqlQuery = "SELECT o.OrderID, CONCAT(u.FirstName, ' ', u.LastName) AS FullName, "
                    + "(SELECT p.ProductName FROM product p "
                    + "WHERE p.ProductID = (SELECT ProductID FROM orderdetail WHERE OrderID = o.OrderID LIMIT 1) LIMIT 1) AS ProductName, "
                    + "o.Quantity, o.TotalPrice, o.OrderDate, s.StatusName "
                    + "FROM `Order` AS o "
                    + "JOIN user AS u ON o.UserID = u.UserID "
                    + "JOIN status s ON s.StatusID = o.StatusID ";

            // Append date range condition if fromDate and toDate are not null
            if (fromDate != null && toDate != null) {
                sqlQuery += "WHERE o.OrderDate BETWEEN '" + fromDate + "' AND '" + toDate + "'";
            }

            ResultSet rs = dao.getData(sqlQuery);
            request.setAttribute("data", rs);
            request.getRequestDispatcher("OrderListSale.jsp").forward(request, response);
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
