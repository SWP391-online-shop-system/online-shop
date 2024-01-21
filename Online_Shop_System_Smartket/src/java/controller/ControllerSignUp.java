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
        String service = request.getParameter("service");
        HttpSession session = request.getSession();
        if (service.equals("signupRegister")) {
            String rFName = request.getParameter("rFName");
            String rLName = request.getParameter("rLName");
            String remail = request.getParameter("remail");
            System.out.println("remail = " + remail);
            String rpass = request.getParameter("rpass");
            String rrepass = request.getParameter("rrepass");
            String message = " ";
            if (!rpass.equals(rrepass)) {
                request.setAttribute("activeSignUp", "active");
                message = "Mật khẩu không khớp, hãy nhập lại";
                request.setAttribute("messageSignUp", message);
                request.getRequestDispatcher("homepage.jsp").forward(request, response);
            } else {
                User user = dao.getUserByEmail(remail);
                if (user == null) {
                    dao.signup(rFName, rLName, rpass, remail);
                } else {
                    request.getRequestDispatcher("homepage.jsp").forward(request, response);
                }
                User user1 = dao.getUserByEmail(remail);
                if (user1 == null) {
                    message = "Trung email";
                } else {
                    DAOMail daomail=new DAOMail();
                    sendEmail(remail,daomail.GetMaxId());
                    request.getRequestDispatcher("homepage.jsp").forward(request, response);
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
        String service = request.getParameter("service");
        String uid_raw = request.getParameter("uid");
        String message;
        int uid=Integer.parseInt(uid_raw);
        DAOMail dao = new DAOMail();
        if (service.equals("verify")) {
            dao.changeStatus(uid);
            request.setAttribute("activeSignUp", "active");
            message = "Đăng Ký thành công";
            request.setAttribute("messageSignUp", message);
            request.getRequestDispatcher("homepage.jsp").forward(request, response);
        }
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

    public void sendEmail(String emailTo,int userID) {
        String EMAIL = "ngongochung535@gmail.com";
        String PASSWORD = "gnqp kqdt basb nlxm";
        Properties pro = new Properties();
        pro.put("mail.smtp.host", "smtp.gmail.com");
        pro.put("mail.smtp.port", "587");
        pro.put("mail.smtp.auth", "true");
        pro.put("mail.smtp.starttls.enable", "true");
        //create authenticator
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL, PASSWORD);
            }
        };
        //workplace
        Session session = Session.getInstance(pro, auth);
        //send an email

        //create message
        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.setFrom(EMAIL);  //nguoi gui
            msg.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(emailTo, false));   //nguoi nhan

            //tieu de
            msg.setSubject("Xác nhận đăng kí tài khoản" + System.currentTimeMillis());
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
                    + "    </head>\n"
                    + "    <body>\n"
                    + "        <a href=\"http://localhost:9999/Smartket/signupURL?service=verify&uid=" + userID + "\" style=\"text-decoration:none; font-size:25px;\">Click vào đây</a>"
                    + "<span style=\"font-size:25px;\"> để xác nhận đăng nhập của bạn</span>\n"
                    + "    </body>\n"
                    + "</html>\n", "text/html;charset=UTF-8");
            //gui email
            Transport.send(msg);
            System.out.println("Email sent successful");
        } catch (MessagingException ex) {
            ex.printStackTrace();
        }
    }
}
