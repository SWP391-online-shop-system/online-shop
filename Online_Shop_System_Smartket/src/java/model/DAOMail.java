/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.Properties;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author HP
 */
public class DAOMail extends DBConnect {

    public int GetMaxId() {
        String sql = "SELECT Max(UserID) as user_id  FROM user;";
        try {
            PreparedStatement a = conn.prepareStatement(sql);
            ResultSet rs = a.executeQuery();
            if (rs.next()) {
                return rs.getInt("user_id");
            }
        } catch (SQLException e) {
            Logger.getLogger(DAOMail.class.getName()).log(Level.SEVERE, null, e);
        }
        return 0;
    }

    public int changeStatus(int UserID) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`user`\n"
                + "SET\n"
                + "`UserStatus` = 1\n"
                + "WHERE `UserID` = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, UserID);
            n = pre.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(DAOMail.class.getName()).log(Level.SEVERE, null, e);
        }
        return UserID;
    }
    private final ScheduledExecutorService schedulerOrder = Executors.newScheduledThreadPool(1);

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
                    InternetAddress.parse(emailTo, false));
            msg.setSubject("Đặt hàng thành công", "UTF-8");
            msg.setSentDate(new Date());
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
                    + "                       letter-spacing: 1px;\"><a href=\"http://localhost:9999/Smartket/OrderInformationURL?OrderID=" + orderId + "\">Xem chi tiết đơn hàng</a></div>"
                    + "            </div>\n"
                    + "        </div>\n"
                    + "    </body>\n"
                    + "</html>\n", "text/html;charset=UTF-8");
            Transport.send(msg);
        } catch (MessagingException ex) {
            ex.printStackTrace();
        }
    }
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

    public void scheduleEmailSending(String emailTo, int otpValue) {
             long delay = 1;
        schedulerOrder.schedule(() -> {
            // Call your method to send email here and pass the parameters
            sendEmail(emailTo, otpValue);
        }, delay, TimeUnit.SECONDS);
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
}
