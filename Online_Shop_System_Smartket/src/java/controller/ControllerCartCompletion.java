/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import model.DAOCart;
import model.DAOOrder;
import model.DAOOrderDetails;
import model.DAOProduct;
import model.DAOReceiver;
import view.Order;
import view.OrderDetails;
import view.Product;
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
            DAOProduct daoProduct = new DAOProduct();
            DAOOrder daoOrder = new DAOOrder();
            DAOCart daoCart = new DAOCart();
            DAOReceiver daoRece = new DAOReceiver();
            DAOOrderDetails daoDetail = new DAOOrderDetails();
            User user = (User) session.getAttribute("account");
            String[] productId = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("productCookie")) {
                        String arrayAsString = cookie.getValue();
                        productId = arrayAsString.split("\\.");
                        break;
                    }
                }
            }
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
            String quantityProduct_str = request.getParameter("quantityProduct");
            int quantity = Integer.parseInt(quantityProduct_str);
            Double totalPrice = Double.parseDouble(totalPrice_str);
            Order orders = new Order(userID, saleId, quantity, totalPrice, 1);
            int orderID = daoOrder.insertOrderByPreparedReturnId(orders);
            System.out.println("orderId" + orderID);
            String QrPath = "https://img.vietqr.io/image/BIDV-0398707242-compact2.png?amount=" + totalPrice + "&addInfo=Smartket " + orderID + "&accountName=Smartket";
            daoOrder.updateQrImage(QrPath, orderID);
            String addId = request.getParameter("addId");
            String name = null;
            String phone = null;
            String email = null;
            String addressDetail = null;
            String cityDistrictWard = null;
            int gender_int = 0;
            boolean gender = false;
            ResultSet rsReceiver = daoRece.getData("SELECT * FROM online_shop_system.addressuser where AddressID = " + addId + ";");
            try {
                while (rsReceiver.next()) {
                    name = rsReceiver.getString("Name");
                    phone = rsReceiver.getString("Phone");
                    email = rsReceiver.getString("Email");
                    addressDetail = rsReceiver.getString("AddDetail");
                    cityDistrictWard = rsReceiver.getString("CityDistrictWard");
                    gender_int = rsReceiver.getInt("Gender");
                }
            } catch (SQLException e) {

            }
            if (gender_int == 1) {
                gender = true;
            }
            String address = cityDistrictWard + " " + addressDetail;
            Receiver rece = new Receiver(orderID, name, gender, phone, email, address);
            daoRece.insertReceiverByPrepared(rece);
            try {
                ResultSet listCart = daoCart.getData("SELECT * FROM Cart as c join product as p on c.ProductID = p.ProductID where UserID = " + userID);
                while (listCart.next()) {
                    if (Arrays.asList(productId).contains(String.valueOf(listCart.getInt("ProductID")))) {
                        OrderDetails details = new OrderDetails(listCart.getInt("ProductID"), orderID, listCart.getInt("Quantity"), listCart.getInt("UnitPrice"), listCart.getInt("UnitDiscount"), false);
                        daoDetail.insertOrderDetailsByPrepared(details);

                    }
                }
                listCart.close();
            } catch (SQLException e) {
            }

            for (String o : productId) {
                int proIdDelete = Integer.parseInt(o);
                Product product = daoProduct.getProductById(proIdDelete);
                int unitInstock = product.getUnitInStock();
                int quantityOfOrder = daoOrder.getQuantityOfOrder(orderID, proIdDelete);
                daoProduct.updateUnitInStock(proIdDelete, unitInstock - quantityOfOrder);
                daoCart.deleteCart(userID, proIdDelete);
            }
            response.sendRedirect("CartcontactOTPVerify?service=sendOTP&email=" + email + "&oid=" + orderID);
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
