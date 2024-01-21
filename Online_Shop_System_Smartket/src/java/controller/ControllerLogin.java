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
         out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ControllerHomepage</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Check email cua ban</h1>");
            out.println("</body>");
            out.println("</html>");
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
                } else {
                    session.setAttribute("account", user);
                }
            }
            String email = request.getParameter("email");
            String pass = request.getParameter("pass");
            User user = dao.check(email, pass);
            if (user == null) {
                request.setAttribute("activeLogin", "active");
                message = "Sai tài khoản hoặc mật khẩu.";
                request.setAttribute("message", message);
                request.getRequestDispatcher("homepage.jsp").forward(request, response);
            } else {
                session.setAttribute("account", user);
                response.sendRedirect("homepage.jsp");
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
