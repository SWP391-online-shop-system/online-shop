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
            if (service == null) {
                service = "sendOTP";
            }
            if (service.equals("sendOTP")) {
                String emailTo = request.getParameter("email");
                String orderID_str = request.getParameter("oid");
                Random rand = new Random();
                int otpvalue = rand.nextInt(900000) + 100000;
                sendEmail(emailTo, otpvalue);
                session.setAttribute("otp", otpvalue);
                session.setAttribute("email", emailTo);
                session.setAttribute("orderId", orderID_str);
                session.setAttribute("otpCreationTime", new Date());
                ResultSet rsCategory = dao.getData("Select * from Categories");
                request.setAttribute("CategoryResult", rsCategory);                
                request.getRequestDispatcher("cartcontactOTP.jsp").forward(request, response);
            }
            if (service.equals("reSendOTP")) {
                String emailTo = (String)session.getAttribute("email");
                String orderID_str = (String)session.getAttribute("orderId");
                Random rand = new Random();
                int otpvalue = rand.nextInt(900000) + 100000;
                sendEmail(emailTo, otpvalue);
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
                        DAOProduct daoPro = new DAOProduct();
                        ResultSet rs = daoPro.getData("SELECT * FROM orderdetail as od join product as p on od.ProductID = p.ProductID where od.OrderID = "+orderID);
                        try {
                            while(rs.next()){
                                int proId = rs.getInt("ProductID");
                                int stock = rs.getInt("UnitInStock");
                                int quantity = rs.getInt("QuantityPerUnit");
                                stock -= quantity;
                                daoPro.updateUnitInStock(proId, stock);
                            }
                        } catch (SQLException e) {
                        }
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

    public void sendEmail(String emailTo, int otpValue) {
        String emailFrom = "smartketfpt@gmail.com";
        String password = "hvdw qdeh rbvg ahox";
        //properties
        Properties pro = new Properties();
        pro.put("mail.smtp.host", "smtp.gmail.com");
        pro.put("mail.smtp.port", "587");
        pro.put("mail.smtp.auth", "true");
        pro.put("mail.smtp.starttls.enable", "true");
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(emailFrom, password);
            }
        };
        Session session = Session.getInstance(pro, auth);
        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.setFrom(emailFrom);  //nguoi gui
            msg.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(emailTo, false));   //nguoi nhan

            //tieu de
            msg.setSubject("Mã xác nhận OTP đặt hàng tại Smartket", "UTF-8");
            //quy dinh ngay gui
            msg.setSentDate(new Date());
            //quy dinh email nhan phan hoi
            //msg.setReplyTo(addresses);
            //noi dung
            msg.setContent("<!DOCTYPE html>\n"
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
                    + "                <div class=\"veryfication-remind\">Vui lòng xác nhận mã OTP của bạn</div>\n"
                    + "                <div><img class=\"veryfication-logo\"src=\"https://i.imgur.com/GVovat4.png\" alt=\"logo\" title=\"logo\"/></div>\n"
                    + "                <div style=\"text-align: center;\n"
                    + "    font-size: 18px;\n"
                    + "    font-weight: 500;\n"
                    + "    letter-spacing: 1px;\"> Mã OTP xác nhận: <span style=\"font-weight: 700\">" + otpValue + "</span></div>\n"
                    + "            </div>\n"
                    + "        </div>\n"
                    + "    </body>\n"
                    + "</html>\n", "text/html;charset=UTF-8");
            Transport.send(msg);
        } catch (MessagingException ex) {
            ex.printStackTrace();
        }
    }
}
