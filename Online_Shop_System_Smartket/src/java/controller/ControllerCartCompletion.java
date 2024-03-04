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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import model.DAOCart;
import model.DAOOrder;
import model.DAOReceiver;
import view.Order;
import view.Receiver;
import view.User;

/**
 *
 * @author trant
 */
@WebServlet(name = "ControllerCartCompletion", urlPatterns = {"/CartCompletion"})
public class ControllerCartCompletion extends HttpServlet {

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
            HttpSession session = request.getSession();
            DAOOrder daoOrder = new DAOOrder();
            DAOCart daoCart = new DAOCart();
            DAOReceiver daoRece = new DAOReceiver();
            User user = (User) session.getAttribute("account");
            int userID = user.getUserID();
            String submit = request.getParameter("submit");
            ResultSet rsCategory = daoCart.getData("Select * from Categories");
            request.setAttribute("CategoryResult", rsCategory);
            request.getRequestDispatcher("cartcompletion.jsp").forward(request, response);
            if (submit != null) {
                LocalDate orderDate = LocalDate.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                String orderDateStr = orderDate.format(formatter);
//                Order orders = new Order(userID, 3, orderDateStr, 1);
//                int orderID = daoOrder.insertOrderByPreparedReturnId(orders);
                String name = request.getParameter("name");
                String phone = request.getParameter("phone");
                String email = request.getParameter("email");
                String city = request.getParameter("city");
                String district = request.getParameter("district");
                String ward = request.getParameter("ward");
                String addressdetail = request.getParameter("addressdetail");
                String note = request.getParameter("note");
                String adress = addressdetail + " " + ward + " " + district + " " + city;
//                Receiver rece = new Receiver(orderID, name, phone, adress, email, note);
//                daoRece.insertReceiverByPrepared(rece);
                try {
                    ResultSet listCart = daoCart.getData("SELECT * FROM Cart AS c JOIN Product AS p ON c.ProductID = p.ProductID\n"
                            + "join ProductImage as pi on p.ProductID = pi.ProductID\n"
                            + "where c.UserID = " + userID + " ;");
                    while (listCart.next()) {
                        
                    }
                } catch (SQLException e) {
                }
            }
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
