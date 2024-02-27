/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAOforgotPass;
import model.EncodeSHA;
import util.MaHoa;

/**
 *
 * @author admin
 */
@WebServlet(name = "ControllerNewPass", urlPatterns = {"/newPass"})
public class ControllerNewPass extends HttpServlet {

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
        DAOforgotPass dao = new DAOforgotPass();
        HttpSession session = request.getSession();
        String newPassword = request.getParameter("password");
        String confPassword = request.getParameter("confPassword");
        boolean check = dao.validatePassword(newPassword);
        RequestDispatcher dispatcher = null;
        String msg = null;
        if (check == true) {
            if (newPassword != null && confPassword != null && newPassword.equals(confPassword)) {
                newPassword = EncodeSHA.transFer(newPassword);
                int row = dao.rePass(newPassword, (String) session.getAttribute("email"));
                if (row > 0) {
                    msg = "đổi thành công";
                    request.setAttribute("message", msg);
                    dispatcher = request.getRequestDispatcher("newPassword.jsp");
                } else {
                    msg = "xảy ra lỗi";
                    request.setAttribute("message", msg);
                    dispatcher = request.getRequestDispatcher("newPassword.jsp");
                }
                dispatcher.forward(request, response);
            } else {
                msg = "mật khẩu xác nhận không trùng khớp";
                request.setAttribute("message", msg);
                dispatcher = request.getRequestDispatcher("newPassword.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            msg = "mật khẩu phải dài ít nhất 6 kí tự và có chứa ít nhất 1 kí tự số";
            request.setAttribute("message", msg);
            dispatcher = request.getRequestDispatcher("newPassword.jsp");
            dispatcher.forward(request, response);
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
