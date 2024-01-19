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
@WebServlet(name = "ControllerSignUp", urlPatterns = {"/signupURL"})
public class ControllerSignUp extends HttpServlet {

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
        DAOUser dao = new DAOUser();
        HttpSession session = request.getSession();
        String rFName = request.getParameter("rFName");
        String rLName = request.getParameter("rLName");
        String remail = request.getParameter("remail");
        String rpass = request.getParameter("rpass");
        String rrepass = request.getParameter("rrepass");
        String message = " ";
        if (!rpass.equals(rrepass)) {
            request.setAttribute("activeSignUp", "active");
            message = "Mật khẩu không khớp, hãy nhập lại";
            request.setAttribute("messageSignUp", message);
            request.getRequestDispatcher("homepage.jsp").forward(request, response);
        }else {
        User user = dao.checkAccountExist(remail);
        if (user == null) {
            // duoc signup
            dao.signup(rFName, rLName, rpass, remail);
            response.sendRedirect("homepage.jsp");
        } else {
            // khong duoc signup
           
            request.getRequestDispatcher("homepage.jsp").forward(request, response);
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
