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
import model.DAOUser;
import model.EncodeSHA;
import view.User;

/**
 *
 * @author HP
 */
@WebServlet(name = "ControllerLogin", urlPatterns = {"/loginURL"})
public class ControllerLogin extends HttpServlet {

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
            DAOUser dao = new DAOUser();
            String message = " ";
            String service = request.getParameter("service");
            if (service == null) {
                service = "";
            }
            HttpSession session = request.getSession();
            if (service.equals("verify")) {
                String key = request.getParameter("key");
                User user = dao.getUserByEmail(key);
                if (user == null) {
                    message = "Sai email.";
                    request.setAttribute("message", message);
                    request.getRequestDispatcher("HomePageURL").forward(request, response);
                    return; // Stop further execution
                } else {
                    session.setAttribute("account", user);
                    response.sendRedirect("HomePageURL");
                    return; // Stop further execution
                }
            }
            String email = request.getParameter("email");
            String pass = request.getParameter("pass");
            String passwordEncode = EncodeSHA.transFer(pass);

// First, try to check with encoded password
            User user = dao.check(email, passwordEncode);

// If user is not found, try checking with plain text password
            if (user == null) {
                // Fetch user details by email without checking password
                User userWithoutPasswordCheck = dao.checkAccountExist(email);

                if (userWithoutPasswordCheck != null) {
                    // Compare plain text password
                    if (pass.equals(userWithoutPasswordCheck.getPassword())) {
                        // Password matched
                        user = userWithoutPasswordCheck;
                    }
                }
            }

            if (user == null) {
                // User not found or password doesn't match
                request.setAttribute("activeLogin", "active");
                message = "Sai tài khoản hoặc mật khẩu.";
                request.setAttribute("message", message);
                request.getRequestDispatcher("HomePageURL").forward(request, response);
            } else if (user.getUserStatus() == 0) {
                // User found but account is disabled
                request.setAttribute("activeLogin", "active");
                message = "Tài khoản của bạn chưa xác nhận";
                request.setAttribute("message", message);
                request.getRequestDispatcher("HomePageURL").forward(request, response);
            } else if (user.getUserStatus() == 2) {
                // User found but account is disabled
                request.setAttribute("activeLogin", "active");
                message = "Tài khoản của bạn đã bị vô hiệu hóa";
                request.setAttribute("message", message);
                request.getRequestDispatcher("HomePageURL").forward(request, response);
            } else {
                // Update last login time
                dao.updateLastLogin(user.getUserID());
                session.setAttribute("account", user);
                if (user.getRoleID() == 2) {
                    response.sendRedirect("MarketingDashBoardURL");
                } else {
                    response.sendRedirect("HomePageURL");
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
        request.setAttribute("activeLogin", "active");
        request.getRequestDispatcher("HomePageURL").forward(request, response);
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
