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
import model.DAOProduct;
import view.Cart;
import view.User;

/**
 *
 * @author trant
 */
@WebServlet(name = "ControllerCartContact", urlPatterns = {"/contactURL"})
public class ControllerCartContact extends HttpServlet {

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
            String service = request.getParameter("service");
            User user = (User) session.getAttribute("account");
            int userID = user.getUserID();
            DAOCart dao = new DAOCart();
            DAOProduct daoPro = new DAOProduct();
            double maxValue = daoPro.getMaxUnitPrice();
            double minValue = daoPro.getMinUnitPrice();
            request.setAttribute("inputMinPrice", minValue);
            request.setAttribute("inputMaxPrice", maxValue);
            ResultSet rsCategory = daoPro.getData("Select * from Categories");
            request.setAttribute("CategoryResult", rsCategory);
            String message = "";
            int count = countPro(request, response);
            for (int i = 1; i <= count; i++) {
                String quan_str = request.getParameter("quan"+i);
                String proid_str = request.getParameter("proid"+i);
                int quan = Integer.parseInt(quan_str);
                int proid = Integer.parseInt(proid_str);
                dao.updateQuantity(userID, proid, quan);
            }
            if (service == null) {
                service = "showContact";
            }
            if (service.equals("showContact")) {
                ResultSet rs = dao.getData("SELECT * FROM Cart AS c JOIN Product AS p ON c.ProductID = p.ProductID\n"
                        + "join ProductImage as pi on p.ProductID = pi.ProductID\n"
                        + "where c.UserID = " + userID + " and pi.ProductURL like '%_1%';");
                request.setAttribute("data", rs);
                request.getRequestDispatcher("cartcontact.jsp").forward(request, response);
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

    private int countPro(HttpServletRequest request, HttpServletResponse response) {
        DAOCart dao = new DAOCart();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        int userID = user.getUserID();
        int count = 0;
        ResultSet countPro = dao.getData("SELECT count(*) FROM Cart where UserID = " + userID);
        try {
            while (countPro.next()) {
                count = countPro.getInt(1);
            }
        } catch (SQLException e) {
        }
        return count;
    }
}
