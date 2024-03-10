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
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.List;
import java.util.Vector;
import model.DAOCategories;
import model.DAOOrder;
import model.DAOProduct;
import model.DAOUser;
import view.Categories;
import view.Status;
import view.User;

/**
 *
 * @author HP
 */
@WebServlet(name = "ControllerOrderList", urlPatterns = {"/saleManagerOrderListURL"})
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
            HttpSession session = request.getSession();
            User u = (User) session.getAttribute("account");
            String message = "";
            if (u == null) {
                message = "Bạn cần đăng nhập";
                request.setAttribute("message", message);
                request.getRequestDispatcher("loginURL").forward(request, response);
            }
            DAOOrder dao = new DAOOrder();
            DAOUser daoU = new DAOUser();
            String fromDate = request.getParameter("fromDate");
            String toDate = request.getParameter("toDate");
            String statusName = request.getParameter("statusName");
            // Check if fromDate and toDate are empty, then set them to null
            if (fromDate != null && fromDate.isEmpty()) {
                fromDate = null;
            }
            if (toDate != null && toDate.isEmpty()) {
                toDate = null;
            }
            String sqlQuery = "SELECT o.OrderID,CONCAT(u.FirstName, ' ', u.LastName) AS FullName, o.SaleID,\n"
                    + "(SELECT p.ProductName \n"
                    + "     FROM product p \n"
                    + "     WHERE p.ProductID = (SELECT ProductID FROM orderdetail WHERE OrderID = o.OrderID LIMIT 1)\n"
                    + "     LIMIT 1) AS ProductName,COUNT(od.OrderID) AS Quantity,o.TotalPrice,o.OrderDate,CONCAT(u_sale.FirstName, ' ', u_sale.LastName) AS SaleName,StatusName\n"
                    + "FROM `Order` AS o \n"
                    + "JOIN user AS u ON o.UserID = u.UserID\n"
                    + "JOIN user AS u_sale ON o.saleID = u_sale.userID\n"
                    + "JOIN status s ON s.StatusID = o.StatusID\n"
                    + "JOIN orderDetail od on o.OrderID = od.OrderID";

            if (fromDate != null && toDate != null) {
                sqlQuery += " WHERE o.OrderDate BETWEEN '" + fromDate + "' AND '" + toDate + "'";
            }
            String selectedSaleUserID = request.getParameter("saleName");
            if (selectedSaleUserID != null && !selectedSaleUserID.isEmpty() && !selectedSaleUserID.equals("Tất cả")) {
                sqlQuery += " AND o.SaleID = '" + selectedSaleUserID + "'";
            }
            if (statusName != null && !statusName.isEmpty()) {
                sqlQuery += " AND s.StatusName = '" + statusName + "'";
            }
            sqlQuery += " GROUP BY o.OrderID, u.FirstName, u.LastName, u_sale.FirstName, u_sale.LastName, s.StatusName";
            ResultSet rs = dao.getData(sqlQuery);
            Vector<User> user = daoU.getUser("select * from User where roleID = 3");
            Vector<Status> status = dao.getStatus("select * from status");
            ResultSet rs1 = dao.getData("select UserID,CONCAT(FirstName, ' ', LastName) AS FullName  from User where roleID = 3");
            request.setAttribute("user", user);
            request.setAttribute("status", status);
            request.setAttribute("data1", rs1);
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
        int sID = Integer.parseInt(request.getParameter("saleID"));
        int orderID = Integer.parseInt(request.getParameter("orderID"));
        DAOOrder dao = new DAOOrder();
        int n = dao.UpdateSaleID(sID, orderID);
        String st = (n > 0) ? "Cập nhật nhân viên thành công" : "Cập nhật nhân viên thất bại";
        response.sendRedirect("saleManagerOrderListURL?message=" + URLEncoder.encode(st, "UTF-8"));
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
