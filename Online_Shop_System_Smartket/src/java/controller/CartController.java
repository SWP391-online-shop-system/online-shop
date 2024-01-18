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
            HttpSession session = request.getSession();
            String service = request.getParameter("service");
            DAOCart dao = new DAOCart();
//            User user = (User) session.getAttribute("account");
//            int userID = user.getUserID();
            int userID = 1;
            if (service == null) {
                service = "showCart";
            }
            if (service.equals("showCart")) {
                ResultSet rs = dao.getData("SELECT * FROM Cart AS c JOIN Product AS p ON c.ProductID = p.ProductID where c.UserID = " + userID + ";");
                if (rs == null) {
//                    message = "No product";
                    out.print("<p>NoPRODUCT</p>");
                }
                request.setAttribute("data", rs);
                request.getRequestDispatcher("cartdetail.jsp").forward(request, response);
            }
            if (service.equals("addcart")) {
                String pid_raw = request.getParameter("pid");
                String quantity_String = request.getParameter("quan");
                int pid = Integer.parseInt(pid_raw);
                int quantity = Integer.parseInt(quantity_String);
                if (dao.productExistsInCart(userID, pid) == false) {
                    quantity = 1;
                    int n = dao.insertCartByPrepared(new Cart(userID, pid, quantity));
                    response.sendRedirect("CartURL");

                } else {
                    Cart cart = dao.getCartByUser(userID, pid);
                    cart.setQuantity(cart.getQuantity() + quantity);
                    int n = dao.updateCartByUserAndPro(cart, userID, pid);
                    response.sendRedirect("CartURL");
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
                if(cart.getQuantity()<=1){
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
