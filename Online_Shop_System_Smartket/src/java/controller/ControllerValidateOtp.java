/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Date;
import model.DAOforgotPass;

/**
 *
 * @author admin
 */
@WebServlet(name = "ControllerValidateOtp", urlPatterns = {"/validateOtp"})
public class ControllerValidateOtp extends HttpServlet {

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
        String Svalue = request.getParameter("otp");
        DAOforgotPass dao = new DAOforgotPass();
        boolean check = dao.isNumeric(Svalue);
        RequestDispatcher dispatcher = null;
        if (check == true) {
            int value = Integer.parseInt(Svalue);
            HttpSession session = request.getSession();
            int otp = (int) session.getAttribute("otp");

            Date otpCreationTime = (Date) session.getAttribute("otpCreationTime");
            long currentTime = new Date().getTime();
            long otpExpirationTime = otpCreationTime.getTime() + (1 * 60 * 1000);

            if (currentTime <= otpExpirationTime) {
                if (value == otp) {
                    request.setAttribute("email", request.getParameter("email"));
                    request.setAttribute("status", "success");
                    dispatcher = request.getRequestDispatcher("newPassword.jsp");
                    dispatcher.forward(request, response);

                } else {
                    request.setAttribute("message", "OTP sai");
                    dispatcher = request.getRequestDispatcher("EnterOtp.jsp");
                    dispatcher.forward(request, response);
                }
                // Mã OTP hợp lệ
                // Tiếp tục xử lý xác nhận và xóa mã OTP khỏi session

                // Thực hiện các bước xác nhận và xử lý sau đây
            } else {
                request.setAttribute("message", "OTP quá hạn");
                dispatcher = request.getRequestDispatcher("EnterOtp.jsp");
                dispatcher.forward(request, response);
            }

        } else {
            request.setAttribute("message", "OTP sai");
            dispatcher = request.getRequestDispatcher("EnterOtp.jsp");
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
