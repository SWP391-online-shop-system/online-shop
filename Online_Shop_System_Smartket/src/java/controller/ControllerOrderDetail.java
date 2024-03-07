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
import model.DAOOrder;

/**
 *
 * @author HP
 */
@WebServlet(name = "ControllerOrderDetail", urlPatterns = {"/OrderDetailURL"})
public class ControllerOrderDetail extends HttpServlet {

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
            String oID = request.getParameter("oID");
            int id = Integer.parseInt(oID);
            String OrderID = request.getParameter("OrderID");
            String sql = "select o.OrderID,CONCAT(u.FirstName, ' ', u.LastName) AS FullName,u.Email,u.PhoneNumber,\n"
                    + "o.OrderDate,o.TotalPrice,CONCAT(u_sale.FirstName, ' ', u_sale.LastName) AS SaleName, s.StatusName\n"
                    + "from `order` as o\n"
                    + "Join User as u on u.UserID = o.UserID\n"
                    + "JOIN user AS u_sale ON o.saleID = u_sale.userID\n"
                    + "Join status as s on s.StatusID = o.StatusID Where o.OrderID = " + id;
            ResultSet rs = dao.getData(sql);
            String sql1 = "select * from receiver where OrderID = " + id;
            ResultSet rs1 = dao.getData(sql1);
            String sql2 = "select distinct pi.ProductURLShow, p.ProductName, c.CategoryName, od.UnitPrice, od.QuantityPerUnit, od.UnitPrice * od.QuantityPerUnit as TotalPricePerUnit, o.TotalPrice\n"
                    + "from orderDetail as od\n"
                    + "Join productImage pi on pi.ProductID = od.ProductID\n"
                    + "Join product p on p.ProductID = od.ProductID\n"
                    + "Join categories c on c.CategoryID = p.CategoryID\n"
                    + "Join `order` o on o.OrderID = od.OrderID\n"
                    + "Where od.OrderID = " + id;
            ResultSet rs2 = dao.getData(sql2);
            request.setAttribute("data", rs);
            request.setAttribute("data1", rs1);
            request.setAttribute("data2", rs2);
            request.getRequestDispatcher("OrderDetail.jsp").forward(request, response);
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
