/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Date;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author admin
 */
@WebServlet(name = "ControllerResendOTP", urlPatterns = {"/resendOTP"})
public class ControllerResendOTP extends HttpServlet {

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
        RequestDispatcher dispatcher = null;
        int otpvalue = 0;
        HttpSession mySession = request.getSession();
        String email = (String) mySession.getAttribute("email");
        String msg = null;
        Random rand = new Random();
        otpvalue = rand.nextInt(1255650);
        if (email != null) {
            String to = email;// change accordingly
            // Get the session object
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.port", "465");
            Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("kofpytago22@gmail.com", "kmnv wwlz gczo xfmi");// Put your email
                    // id and
                    // password here
                }
            });
            // compose message
            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress(email));// change accordingly
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                message.setSubject("Smartket");
                message.setContent("<!DOCTYPE html>\n"
                        + "<html>\n"
                        + "    <head>\n"
                        + "        <title>TODO supply a title</title>\n"
                        + "        <meta charset=\"UTF-8\">\n"
                        + "        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                        + "    <style>\n"
                        + "        .veryfication-content{\n"
                        + "            width: 500px;\n"
                        + "            height: 225px;\n"
                        + "            margin: 0 auto;\n"
                        + "            border-radius: 6px;\n"
                        + "            background:#e5f2e5;\n"
                        + "        }\n"
                        + "        .veryfication-logo{\n"
                        + "            width: 159px;\n"
                        + "            height: 117px;\n"
                        + "            margin-left: 34%;\n"
                        + "            margin-top: 13px;\n"
                        + "        }\n"
                        + "        .veryfication-btn{\n"
                        + "   width: 141px;\n"
                        + "     height: 25px;\n"
                        + "    color: white;\n"
                        + "   background: #26a352;\n"
                        + "   padding-bottom: -18px;\n"
                        + "   padding-top: -17px;\n"
                        + "   border-radius: 9px;\n"
                        + "   font-size: 17px;\n"
                        + "  padding: 6px;\n"
                        + "    font-family: math;\n"
                        + "   text-align: center;\n"
                        + "   margin: 0 auto;\n"
                        + "        }\n"
                        + "        .veryfication-btn div{\n"
                        + "        }\n"
                        + "        .veryfication-btn:hover{\n"
                        + "            transform: scale(0.95);\n"
                        + "            cursor: pointer;\n"
                        + "        }\n"
                        + "        a{\n"
                        + "            text-decoration: none;\n"
                        + "            color: white;\n"
                        + "        }\n"
                        + "        .veryfication-remind{\n"
                        + "            text-align: center;\n"
                        + "            font-size: 20px;\n"
                        + "            color: #456c68;\n"
                        + "            font-weight:700;\n"
                        + "            font-family: math;\n"
                        + "            padding-top: 15px;\n"
                        + "            letter-spacing: 1px;\n"
                        + "        }\n"
                        + "    </style>\n"
                        + "    </head>\n"
                        + "    <body>\n"
                        + "        <div class=\"veryfication-content\">\n"
                        + "            <div >\n"
                        + "                <div class=\"veryfication-remind\">Vui lòng xác nhận email của bạn</div>\n"
                        + "                <div><img class=\"veryfication-logo\"src=\"https://i.imgur.com/GVovat4.png\" alt=\"logo\" title=\"logo\"/></div>\n"
                        + "                <div style=\"text-align: center;\n"
                        + "    font-size: 18px;\n"
                        + "    font-weight: 500;\n"
                        + "    letter-spacing: 1px;\"> Mã OTP xác nhận: <span style=\"font-weight: 700\">"  + otpvalue+ "</span></div>\n"
                        + "            </div>\n"
                        + "        </div>\n"
                        + "    </body>\n"
                        + "</html>\n", "text/html;charset=UTF-8");

                // send message
                Transport.send(message);
            } catch (MessagingException e) {
                throw new RuntimeException(e);
            }
            dispatcher = request.getRequestDispatcher("EnterOtp.jsp");
            msg = "OTP đã được gửi tới mail của bạn";
            request.setAttribute("message", msg);
            //request.setAttribute("connection", con);
            mySession.setAttribute("otp", otpvalue);
            mySession.setAttribute("otpCreationTime", new Date());
            mySession.setAttribute("email", email);
            dispatcher.forward(request, response);

        } else {
            dispatcher = request.getRequestDispatcher("forgotpass.jsp");
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
