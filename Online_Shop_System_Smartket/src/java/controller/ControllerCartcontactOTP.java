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
import java.text.DecimalFormat;
import java.util.Date;
import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import model.DAOCategories;
import model.DAOMail;
import model.DAOOrder;
import model.DAOProduct;

/**
 *
 * @author trant
 */
@WebServlet(name = "ControllerCartcontactOTP", urlPatterns = {"/CartcontactOTPVerify"})
public class ControllerCartcontactOTP extends HttpServlet {

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
            DAOCategories dao = new DAOCategories();
            DAOOrder daoOrder = new DAOOrder();
            if (service.equals("sendOTP")) {
                String emailTo = request.getParameter("email");
                String orderID_str = request.getParameter("oid");
                Random rand = new Random();
                int otpvalue = rand.nextInt(900000) + 100000;
                DAOMail daoMail = new DAOMail();
                daoMail.scheduleEmailSending(emailTo, otpvalue);
                session.setAttribute("otp", otpvalue);
                session.setAttribute("email", emailTo);
                session.setAttribute("orderId", orderID_str);
                session.setAttribute("otpCreationTime", new Date());
                ResultSet rsCategory = dao.getData("Select * from Categories");
                request.setAttribute("CategoryResult", rsCategory);
                request.getRequestDispatcher("cartcontactOTP.jsp").forward(request, response);
            }
            if (service.equals("reSendOTP")) {
                String emailTo = (String) session.getAttribute("email");
                String orderID_str = (String) session.getAttribute("orderId");
                Random rand = new Random();
                int otpvalue = rand.nextInt(900000) + 100000;
                DAOMail daoMail = new DAOMail();
                daoMail.scheduleEmailSending(emailTo, otpvalue);
                session.setAttribute("otp", otpvalue);
                session.setAttribute("orderId", orderID_str);
                session.setAttribute("otpCreationTime", new Date());
                ResultSet rsCategory = dao.getData("Select * from Categories");
                request.setAttribute("CategoryResult", rsCategory);
                request.getRequestDispatcher("cartcontactOTP.jsp").forward(request, response);
            }
            if (service.equals("verify")) {
                String otpValuesStr = request.getParameter("otpValues");
                int otp = (int) session.getAttribute("otp");
                String orderID_str = (String) session.getAttribute("orderId");
                int orderID = Integer.parseInt(orderID_str);
                int OTPInput = Integer.parseInt(otpValuesStr);
                Date otpCreationTime = (Date) session.getAttribute("otpCreationTime");
                long currentTime = new Date().getTime();
                long otpExpirationTime = otpCreationTime.getTime() + (1 * 60 * 1000);
                if (currentTime <= otpExpirationTime) {
                    if (otp == OTPInput) {
                        daoOrder.updateStatus(orderID);                        
                        response.getWriter().write("Đã xác nhận thành công");
                        session.removeAttribute("otp");
                        session.removeAttribute("otpCreationTime");

                    } else {
                        response.getWriter().write("Sai mã OTP");
                    }
                } else {
                    response.getWriter().write("Mã OTP đã hết hạn");
                    session.removeAttribute("otp");
                    session.removeAttribute("otpCreationTime");
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
