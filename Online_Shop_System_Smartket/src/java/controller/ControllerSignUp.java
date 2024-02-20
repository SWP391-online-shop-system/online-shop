/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
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
import model.EncodeSHA;
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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<head>"
                    + "<meta charset=\"UTF-8\">\n"
                    + "        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n"
                    + "        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                    + "        <title>Thank You for Sign Up</title>\n"
                    + "        <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\n"
                    + "    </head>\n"
                    + "\n"
                    + "    <body>\n"
                    + "        <div class=\"vh-100 d-flex justify-content-center align-items-center\">\n"
                    + "            <div>\n"
                    + "                <div class=\"mb-4 text-center\">\n"
                    + "                    <svg xmlns=\"http://www.w3.org/2000/svg\" class=\"text-success\" width=\"75\" height=\"75\"\n"
                    + "                        fill=\"currentColor\" class=\"bi bi-check-circle-fill\" viewBox=\"0 0 16 16\">\n"
                    + "                        <path\n"
                    + "                            d=\"M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z\" />\n"
                    + "                    </svg>\n"
                    + "                </div>\n"
                    + "                <div class=\"text-center\">\n"
                    + "                    <h1>Cảm ơn !</h1>\n"
                    + "                    <p>Chúng tôi đã gửi email xác nhận ở hòm thư. Bạn hãy kiểm tra </p>\n"
                    + "                </div>\n"
                    + "            </div>"
                    + "</body>");
            DAOUser dao = new DAOUser();
            String service = request.getParameter("service");
            HttpSession session = request.getSession();
            if (service.equals("signupRegister")) {
                String rFName = request.getParameter("rFName");
                String rLName = request.getParameter("rLName");
                String remail = request.getParameter("remail");
                String rpass = request.getParameter("rpass");
                String rrepass = request.getParameter("rrepass");
                User u = new User(rLName, rFName, remail, rpass, rrepass);
                request.setAttribute("lastUser", u);
                User user = dao.getUserByEmail(remail);
                rFName = rFName.replaceAll("\\s+", " ");
                rLName = rLName.replaceAll("\\s+", " ");
                rFName = rFName.trim();
                rLName = rLName.trim();
                String message = " ";
                if (user != null) {
                    message = "Email đã được sử dụng";
                    request.setAttribute("activeSignUp", "active");
                    request.setAttribute("messageSignUp", message);
                    request.getRequestDispatcher("HomePageURL").forward(request, response);
                } else if (!rpass.equals(rrepass)) {
                    // Passwords do not match
                    message = "Mật khẩu không khớp";
                    request.setAttribute("activeSignUp", "active");
                    request.setAttribute("messageSignUp", message);
                    request.getRequestDispatcher("HomePageURL").forward(request, response);
                } else {
                    // User does not exist, proceed with signup
                    dao.signup(rFName, rLName, EncodeSHA.transFer(rpass), remail);
                    message = "User successfully signed up";
                    request.setAttribute("msg1", message);
                    dao.updateCreateDate(user.getUserID());
                    // Send email or perform other necessary actions
                    DAOMail daomail = new DAOMail();
                    long timestamp = System.currentTimeMillis();
                    sendEmail(remail, daomail.GetMaxId(), timestamp);
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
        String timestampStr = request.getParameter("timestamp"); // Retrieve timestamp from the request parameters

        if (timestampStr != null) {
            // Convert timestamp to long
            long timestamp = Long.parseLong(timestampStr);

            // Get current time
            long currentTime = System.currentTimeMillis();

            // Check if the link has expired
            long expirationTime = 1 * 60 * 1000; // 1 minute in milliseconds
            if (currentTime - timestamp > expirationTime) {
                // Link has expired, handle accordingly (e.g., show an error message)
                response.sendRedirect("linkExpired.jsp");
                return; // Exit the method to avoid further processing
            }
        }
        int uid = Integer.parseInt(uid_raw);
        DAOMail dao = new DAOMail();
        if (service.equals("verify")) {
            dao.changeStatus(uid);
            request.setAttribute("activeSignUp", "active");
            message = "Đăng Ký thành công";
            request.setAttribute("messageSignUp", message);
            request.getRequestDispatcher("HomePageURL").forward(request, response);
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

    public void sendEmail(String emailTo, int userID, long timestamp) {
        String emailFrom = "smartketfpt@gmail.com";
        String password = "hvdw qdeh rbvg ahox";
        //properties
        Properties pro = new Properties();
        pro.put("mail.smtp.host", "smtp.gmail.com");
        pro.put("mail.smtp.port", "587");
        pro.put("mail.smtp.auth", "true");
        pro.put("mail.smtp.starttls.enable", "true");
        String verificationLink = "http://localhost:9999/Smartket/signupURL?service=verify&uid=" + userID + "&timestamp=" + timestamp;
        //create authenticator
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(emailFrom, password);
            }
        };
        //workplace
        Session session = Session.getInstance(pro, auth);
        //create message
        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.setFrom(emailFrom);  //nguoi gui
            msg.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(emailTo, false));   //nguoi nhan

            //tieu de
            msg.setSubject("Xác nhận đăng kí tài khoản Smartket" + System.currentTimeMillis(), "UTF-8");
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
                    + "                <div class=\"veryfication-remind\">Vui lòng xác nhận email của bạn</div>\n"
                    + "                <div><img class=\"veryfication-logo\"src=\"https://i.imgur.com/GVovat4.png\" alt=\"logo\" title=\"logo\"/></div>\n"
                    + "                <a href=\"" + verificationLink + "\" ><div class=\"veryfication-btn\">Xác nhận email</div></a>\n"
                    + "            </div>\n"
                    + "        </div>\n"
                    + "    </body>\n"
                    + "</html>\n", "text/html;charset=UTF-8");
            Transport.send(msg);
            System.out.println("Email sent successful");
        } catch (MessagingException ex) {
            ex.printStackTrace();
        }
    }
}
