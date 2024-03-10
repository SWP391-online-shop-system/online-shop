/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import view.Cart;
import view.User;
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
import java.util.Vector;
import model.DAOCart;
import model.DAOOrder;
import model.DAOOrderDetails;
import model.DAOProduct;
import view.Order;
import view.OrderDetails;

/**
 *
 * @author Laptop
 */
@WebServlet(name = "CartController", urlPatterns = {"/CartURL"})
public class CartController extends HttpServlet {

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
            DAOOrder daoOrd = new DAOOrder();
            DAOOrderDetails daoDetail = new DAOOrderDetails();
            HttpSession session = request.getSession();
            String service = request.getParameter("service");
            DAOCart dao = new DAOCart();
            DAOProduct daoPro = new DAOProduct();
            User user = (User) session.getAttribute("account");
            int userID = user.getUserID();
            String message = "";
            if (service == null) {
                service = "showCart";
            }
            if (service.equals("showCart")) {
                ResultSet rs = dao.getData("SELECT * FROM Cart AS c JOIN Product AS p ON c.ProductID = p.ProductID\n"
                        + "join ProductImage as pi on p.ProductID = pi.ProductID\n"
                        + "where c.UserID = " + userID + " and pi.ProductURL like '%_1%';");
                request.setAttribute("data", rs);
                double maxValue = daoPro.getMaxUnitPrice();
                double minValue = daoPro.getMinUnitPrice();
                request.setAttribute("inputMinPrice", minValue);
                request.setAttribute("inputMaxPrice", maxValue);
                ResultSet rsCategory = daoPro.getData("Select * from Categories");
                request.setAttribute("CategoryResult", rsCategory);
                request.getRequestDispatcher("cartdetail.jsp").forward(request, response);
            }
            if (service.equals("addcart")) {
                String pid_raw = request.getParameter("pid");
                int pid = Integer.parseInt(pid_raw);
                int quantity = 1;
                if (dao.productExistsInCart(userID, pid) == false) {
                    int count = 0;
                    dao.insertCartByPrepared(new Cart(userID, pid, quantity));
                    ResultSet countPro = dao.getData("SELECT count(*) as count FROM Cart AS c JOIN Product AS p ON c.ProductID = p.ProductID where userID = " + userID + "");
                    try {
                        while (countPro.next()) {
                            count = countPro.getInt(1);
                        }
                        countPro.close();
                    } catch (SQLException e) {
                    }
                    response.getWriter().write(String.valueOf(count));
                } else {
                    int count = 0;
                    Cart cart = dao.getCartByUser(userID, pid);
                    cart.setQuantity(cart.getQuantity() + quantity);
                    int n = dao.updateCartByUserAndPro(cart, userID, pid);
                    ResultSet countPro = dao.getData("SELECT count(*) as count FROM Cart AS c JOIN Product AS p ON c.ProductID = p.ProductID where userID = " + userID + "");
                    try {
                        while (countPro.next()) {
                            count = countPro.getInt(1);
                        }
                        countPro.close();
                    } catch (SQLException e) {
                    }
                    response.getWriter().write(String.valueOf(count));
                }
            }
            if (service.equals("rebuy")) {
                int count = 0;
                String OrderID = request.getParameter("OrderID");
                Vector<OrderDetails> list = daoDetail.getOrderDetailsById(Integer.parseInt(OrderID));
                for (OrderDetails o : list) {
                    dao.insertCartByPrepared(new Cart(userID, o.getProductID(), o.getQuantity()));
                    ResultSet countPro = dao.getData("SELECT count(*) as count FROM Cart AS c JOIN Product AS p ON c.ProductID = p.ProductID where userID = " + userID + "");
                    try {
                        while (countPro.next()) {
                            count = countPro.getInt(1);
                        }
                        countPro.close();
                    } catch (SQLException e) {
                    }
                    response.getWriter().write(String.valueOf(count));
                }
            }
            if (service.equals("deleteCart")) {
                String pid_raw = request.getParameter("proid");
                int pid = Integer.parseInt(pid_raw);
                int n = dao.deleteCart(userID, pid);
                response.sendRedirect("CartURL");
            }
            if (service.equals("deleteAllCart")) {
                int n = dao.deleteAllCart(userID);
                response.sendRedirect("CartURL");
            }
            if (service.equals("incquantity")) {
                String pid_raw = request.getParameter("proid");
                int pid = Integer.parseInt(pid_raw);
                Cart cart = dao.getCartByUser(userID, pid);
                cart.setQuantity(cart.getQuantity() + 1);
                int n = dao.updateCartByUserAndPro(cart, userID, pid);
                response.sendRedirect("CartURL");
            }
            if (service.equals("decquantity")) {
                String pid_raw = request.getParameter("proid");
                int pid = Integer.parseInt(pid_raw);
                Cart cart = dao.getCartByUser(userID, pid);
                if (cart.getQuantity() <= 1) {
                    int n = dao.deleteCart(userID, pid);

                }
                cart.setQuantity(cart.getQuantity() - 1);
                int n = dao.updateCartByUserAndPro(cart, userID, pid);
                response.sendRedirect("CartURL");
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
