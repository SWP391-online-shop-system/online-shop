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
                String emailTo = (String) session.getAttribute("email");
                String orderID_str = (String) session.getAttribute("orderId");
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
                        ResultSet rs = daoPro.getData("SELECT * FROM orderdetail as od join product as p on od.ProductID = p.ProductID where od.OrderID = " + orderID);
                        try {
                            while (rs.next()) {
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
                        String email = getEmail(orderID);
                        sendEmailOrder(email, orderID);
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

    public void sendEmailOrder(String emailTo, int orderId) {
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
            msg.setSubject("Đặt hàng thành công", "UTF-8");
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
                    + "            height: 300px;\n"
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
                    + "                <div class=\"veryfication-remind\">Ấn link bên dưới để xem chi tiết đơn hàng</div>\n"
                    + "                <div><img class=\"veryfication-logo\"src=\"https://i.imgur.com/GVovat4.png\" alt=\"logo\" title=\"logo\"/></div>\n"
                    + "                 <div style=\"text-align: center;\n"
                    + "                      font-size: 18px;\n"
                    + "                        font-weight: 500;\n"
                    + "                       letter-spacing: 1px;\"><a href=\"http://localhost:8080/Smartket/OrderInformationURL?OrderID="+orderId+"\">Xem chi tiết đơn hàng</a></div>"
                    + "            </div>\n"
                    + "        </div>\n"
                    + "    </body>\n"
                    + "</html>\n", "text/html;charset=UTF-8");
            Transport.send(msg);
        } catch (MessagingException ex) {
            ex.printStackTrace();
        }
    }

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

//    public void sendEmailOrder(String emailTo, int orderId) {
//        DAOOrder dao = new DAOOrder();
//        DecimalFormat df = new DecimalFormat("###,###");
//        df.setMaximumFractionDigits(8);
//        ResultSet rs = dao.getData("SELECT * FROM online_shop_system.order as o \n"
//                + "join online_shop_system.orderdetail as od on o.OrderID = od.OrderID \n"
//                + " where o.OrderID = " + orderId);
//        double totalPrice;
//        String emailFrom = "smartketfpt@gmail.com";
//        String password = "hvdw qdeh rbvg ahox";
//        //properties
//        Properties pro = new Properties();
//        pro.put("mail.smtp.host", "smtp.gmail.com");
//        pro.put("mail.smtp.port", "587");
//        pro.put("mail.smtp.auth", "true");
//        pro.put("mail.smtp.starttls.enable", "true");
//        Authenticator auth = new Authenticator() {
//            @Override
//            protected PasswordAuthentication getPasswordAuthentication() {
//                return new PasswordAuthentication(emailFrom, password);
//            }
//        };
//        Session session = Session.getInstance(pro, auth);
//        MimeMessage msg = new MimeMessage(session);
//        try {
//            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
//            msg.setFrom(emailFrom);  //nguoi gui
//            msg.setRecipients(Message.RecipientType.TO,
//                    InternetAddress.parse(emailTo, false));   //nguoi nhan
//
//            //tieu de
//            msg.setSubject("Thông tin đơn hàng", "UTF-8");
//            //quy dinh ngay gui
//            msg.setSentDate(new Date());
//            //quy dinh email nhan phan hoi
//            //msg.setReplyTo(addresses);
//            //noi dung
//            msg.setContent("<!DOCTYPE html>  \n"
//                    + "<html>  \n"
//                    + "    <head> \n"
//                    + "        <title>TODO supply a title</title>  \n"
//                    + "        <meta charset=\"UTF-8\">  \n"
//                    + "        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">  \n"
//                    + "        <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity= \"sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC\" crossorigin=\"anonymous\"> \n"
//                    + "        <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js\" integrity= \"sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM\" crossorigin=\"anonymous\">\n"
//                    + "        </script>\n"
//                    + "        <style>\n"
//                    + "            .cart-contact{\n"
//                    + "                max-width: 500px;\n"
//                    + "                min-width: 0;\n"
//                    + "                word-wrap: break-word;\n"
//                    + "                background-color: #fff;\n"
//                    + "                background-clip: border-box;\n"
//                    + "                border-radius: 0.375rem;\n"
//                    + "                background:#e5f2e5;\n"
//                    + "            }\n"
//                    + "            footer{\n"
//                    + "                max-width: 500px;\n"
//                    + "                background-color: #050505cc;\n"
//                    + "                font-size: 13px;\n"
//                    + "                height: 116px;\n"
//                    + "            }\n"
//                    + "            a{\n"
//                    + "                text-decoration: none;\n"
//                    + "                color: black;\n"
//                    + "            }\n"
//                    + "            .container_1 {\n"
//                    + "                max-width: 1140px;\n"
//                    + "                margin: 0 auto;\n"
//                    + "                display: flex;\n"
//                    + "                align-items: center;\n"
//                    + "            }\n"
//                    + "            .row_1{\n"
//                    + "                display: flex;\n"
//                    + "                justify-content: space-between;\n"
//                    + "                align-items: center;\n"
//                    + "            }\n"
//                    + "\n"
//                    + "            .col_1{\n"
//                    + "                color: #f2f2f2f2;\n"
//                    + "                padding: 0 1rem;\n"
//                    + "                height: 202px;\n"
//                    + "            }\n"
//                    + "            .footer_title_1{\n"
//                    + "                color:#f2f2f2f2;\n"
//                    + "                font-family: poppins;\n"
//                    + "                font-size: 23px;\n"
//                    + "            }\n"
//                    + "            .col_1 .logo_1{\n"
//                    + "                width: 86px;\n"
//                    + "            }\n"
//                    + "            .col_1 h5{\n"
//                    + "                color:#ff014fff;\n"
//                    + "            }\n"
//                    + "            .col_1 .social_1 a i{\n"
//                    + "                color:#ff014fff;\n"
//                    + "                margin-top:2rem;\n"
//                    + "                margin-right: 5px;\n"
//                    + "                transition: 0.3s ease;\n"
//                    + "            }\n"
//                    + "            .col_1 .social_1 a i:hover{\n"
//                    + "                transform: scale(1.5);\n"
//                    + "                filter:grayscale(25);\n"
//                    + "            }\n"
//                    + "            .col_1 .contact-details_1{\n"
//                    + "                display: inline-flex;\n"
//                    + "                justify-content: space-between;\n"
//                    + "                height: 44px;\n"
//                    + "            }\n"
//                    + "            .col_1 .contact-details_1 i{\n"
//                    + "                margin-right:15px;\n"
//                    + "            }\n"
//                    + "            .contact-details_1 p{\n"
//                    + "                margin-top: -2px;\n"
//                    + "            }\n"
//                    + "        </style>\n"
//                    + "    </head>  \n"
//                    + "    <body>  \n"
//                    + "        <div class=\"cart-contact\">\n"
//                    + "            <div style=\"text-align: center\"><img style=\"width: 20%\" src=\"https://i.imgur.com/GVovat4.png\" alt=\"logo\" title=\"logo\"/></div>\n"
//                    + "            <div></div>\n"
//                    + "            <div style=\"text-align: center;\"><strong>Thông tin đơn hàng</strong></div>\n"
//                    + "            <div class=\"card-body\">\n"
//                    + "                <div class=\"table-responsive-sm\">\n"
//                    + "                    <table class=\"table table-striped\">\n"
//                    + "                        <thead>\n"
//                    + "\n"
//                    + "                        </thead>\n"
//                    + "                        <tbody>\n"
//                    + "\n"
//                    + "                            <tr>\n"
//                    + "                                <td>                                        \n"
//                    + "                                    áo\n"
//                    + "                                </td>\n"
//                    + "                                <td style=\"text-align: center;\">\n"
//                    + "                                    1\n"
//                    + "                                </td>\n"
//                    + "                                <td style=\"border-right: none;\">\n"
//                    + "                                    11111đ\n"
//                    + "                                </td>\n"
//                    + "                            </tr>\n"
//                    + "\n"
//                    + "                        </tbody>\n"
//                    + "                    </table>\n"
//                    + "                </div>\n"
//                    + "                <div class=\"row\">\n"
//                    + "                    <div class=\"\" style=\"    margin-left: 5%;\">\n"
//                    + "                        <h6 class=\"mb-3\"><strong>Địa chỉ nhận hàng:</strong></h6>\n"
//                    + "                        <div></div>\n"
//                    + "                        <div></div>\n"
//                    + "                        <div>Nguời Nhận: </div>\n"
//                    + "                        <div>Email: </div>\n"
//                    + "                        <div>Số điện thoại: </div>\n"
//                    + "                    </div>\n"
//                    + "                    <div class=\"\">\n"
//                    + "                        <table class=\"table table-clear\">\n"
//                    + "                            <tbody>\n"
//                    + "                                <tr>\n"
//                    + "                                    <td class=\"left\"><strong>Tổng đơn hàng: 00000 đ</strong></td>\n"
//                    + "                                </tr>\n"
//                    + "                            </tbody>\n"
//                    + "                        </table>\n"
//                    + "                    </div>\n"
//                    + "                </div>\n"
//                    + "            </div>\n"
//                    + "            <div style=\"text-align: center;\"><strong>Thông tin thanh toán</strong></div>\n"
//                    + "            <div style=\"text-align: center;padding-bottom: 10px\">\n"
//                    + "                <img style=\"width: 39%\" src=\"https://img.vietqr.io/image/BIDV-0398707242-compact2.png?amount=1091000.0&addInfo=Smartket 1&accountName=Smartket\" alt=\"QR code\"/>\n"
//                    + "            </div>\n"
//                    + "        </div>\n"
//                    + "    </body>\n"
//                    + "    <footer>\n"
//                    + "        <div class=\"container_1\">\n"
//                    + "            <div class=\"row_1\">\n"
//                    + "                <div class=\"col_1\" id=\"company\">\n"
//                    + "                    <img src=\"https://i.imgur.com/GVovat4.png\" alt=\"\" class=\"logo_1\">\n"
//                    + "                    <p>\n"
//                    + "                        công ty Smartket Việt Nam, 54 Liễu Giai, quận Ba Đình, Hà Nội \n"
//                    + "                    </p>\n"
//                    + "                    <div class=\"social_1\">\n"
//                    + "                        <a href=\"#\"><i class=\"fab fa-facebook\"></i></a>\n"
//                    + "                        <a href=\"#\"><i class=\"fa-brands fa-x-twitter\"></i></a>\n"
//                    + "                    </div>\n"
//                    + "                </div>\n"
//                    + "\n"
//                    + "                <div class=\"col_1\" id=\"contact\">\n"
//                    + "                    <h5>Liên hệ</h5>\n"
//                    + "                    <div class=\"contact-details_1\">\n"
//                    + "                        <i class=\"fa-regular fa-envelope\"></i>\n"
//                    + "                        <p>Smartket@gmail.com</p>\n"
//                    + "                    </div>\n"
//                    + "                    <div class=\"contact-details_1\">\n"
//                    + "                        <i class=\"fa fa-phone\"></i>\n"
//                    + "                        <p>+84 99.999.999</p>\n"
//                    + "                    </div>\n"
//                    + "                </div>\n"
//                    + "            </div>\n"
//                    + "        </div>\n"
//                    + "    </footer>\n"
//                    + "</html>  ", "text/html;charset=UTF-8");
//            Transport.send(msg);
//        } catch (MessagingException ex) {
//            ex.printStackTrace();
//        }
//    }
}
