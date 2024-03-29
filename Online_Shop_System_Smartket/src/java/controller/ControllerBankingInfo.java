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
import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import model.DAOMail;
import model.DAOOrder;

/**
 *
 * @author trant
 */
@WebServlet(name = "ControllerBankingInfo", urlPatterns = {"/BankingInfo"})
public class ControllerBankingInfo extends HttpServlet {

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
            String orderId_str = (String) session.getAttribute("orderId");
            int orderId = Integer.parseInt(orderId_str);
            DAOOrder daoOrder = new DAOOrder();
            String QrPath = null;
            ResultSet rs = daoOrder.getData("SELECT * FROM online_shop_system.order where OrderID = " + orderId);
            try {
                while (rs.next()) {
                    QrPath = rs.getString("OrderImage");
                }
                rs.close();
            } catch (SQLException e) {
            }
            String email = getEmail(orderId);
            DAOMail daoMail = new DAOMail();
            daoMail.scheduleEmailSendingOrder(email, orderId);
//            sendEmailOrder(email, orderId);
            request.setAttribute("QrPath", QrPath);
            request.getRequestDispatcher("bankingInfo.jsp").forward(request, response);
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

    private String getEmail(int orderId) {
        DAOOrder dao = new DAOOrder();
        String email = null;
        ResultSet rs = dao.getData("SELECT * FROM online_shop_system.receiver where OrderID = " + orderId);
        try {
            while (rs.next()) {
                email = rs.getString("ReceiverEmail");
            }
        } catch (SQLException e) {

        }
        return email;
    }
}
