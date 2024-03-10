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
import model.DAOCart;
import model.DAOOrder;
import model.DAOOrderDetails;
import model.DAOReceiver;
import view.Order;
import view.OrderDetails;
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
            DAOOrderDetails daoDetail = new DAOOrderDetails();
            User user = (User) session.getAttribute("account");
            int userID = user.getUserID();
            int saleId = 0;
            int quantityOfSale = 0;
            try {
                ResultSet sale = daoOrder.getData("SELECT * FROM online_shop_system.sale order by OrderQuantity asc limit 1;");
                while (sale.next()) {
                    saleId = sale.getInt(1);
                    quantityOfSale = sale.getInt(2);
                }
                sale.close();
            } catch (SQLException e) {
            }
            quantityOfSale++;
            daoOrder.updateSale(saleId, quantityOfSale);
            String totalPrice_str = request.getParameter("totalPrice");
            Double totalPrice = Double.parseDouble(totalPrice_str);
            Order orders = new Order(userID, saleId, 1, totalPrice);
            int orderID = daoOrder.insertOrderByPreparedReturnId(orders);
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
//            String city = request.getParameter("city");
//            String district = request.getParameter("district");
//            String ward = request.getParameter("ward");
            String adress = request.getParameter("addressdetail");
            String note = request.getParameter("note");
//            Receiver rece = new Receiver(orderID, name, phone, adress, email, note);
//            daoRece.insertReceiverByPrepared(rece);
            try {
                ResultSet listCart = daoCart.getData("SELECT * FROM Cart as c join product as p on c.ProductID = p.ProductID where UserID = " + userID);
                while (listCart.next()) {
                    OrderDetails details = new OrderDetails(listCart.getInt("ProductID"), orderID, listCart.getInt("Quantity"), listCart.getInt("UnitPrice"), listCart.getInt("UnitDiscount"));
                    daoDetail.insertOrderDetailsByPrepared(details);
                }
                listCart.close();
            } catch (SQLException e) {
            }
            daoCart.deleteAllCart(userID);
            response.sendRedirect("CartcontactOTPVerify?email="+email+"&oid="+orderID);
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
