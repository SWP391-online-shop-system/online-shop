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
import java.net.URLEncoder;
import java.sql.ResultSet;
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
import model.DAOOrder;

/**
 *
 * @author HP
 */
@WebServlet(name = "ControllerOrderDetail", urlPatterns = {"/saleOrderDetailURL"})
public class ControllerOrderDetail extends HttpServlet {

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
            DAOOrder dao = new DAOOrder();
            String oID = request.getParameter("oID");
            int id = Integer.parseInt(oID);
            String OrderID = request.getParameter("OrderID");
            String sql = "select o.OrderID,CONCAT(u.FirstName, ' ', u.LastName) AS FullName,u.Email,u.PhoneNumber, s.StatusID, r.ReceiverEmail,o.ShippedDate,\n"
                    + "                                       o.OrderDate,o.TotalPrice,CONCAT(u_sale.FirstName, ' ', u_sale.LastName) AS SaleName, s.StatusName\n"
                    + "                                        from `order` as o\n"
                    + "                                        Join User as u on u.UserID = o.UserID\n"
                    + "                                        JOIN user AS u_sale ON o.saleID = u_sale.userID\n"
                    + "                                        JOIN receiver as r on r.OrderID = o.OrderID\n"
                    + "                                        Join status as s on s.StatusID = o.StatusID Where o.OrderID = " + id;
            ResultSet rs = dao.getData(sql);
            String sql1 = "select * from receiver where OrderID = " + id;
            ResultSet rs1 = dao.getData(sql1);
            String sql2 = "select distinct pi.ProductURLShow, p.ProductName, c.CategoryName, od.UnitPrice, od.QuantityPerUnit, od.UnitPrice * od.QuantityPerUnit as TotalPricePerUnit, o.TotalPrice,o.ShippedDate\n"
                    + "from orderDetail as od\n"
                    + "Join productImage pi on pi.ProductID = od.ProductID\n"
                    + "Join product p on p.ProductID = od.ProductID\n"
                    + "Join categories c on c.CategoryID = p.CategoryID\n"
                    + "Join `order` o on o.OrderID = od.OrderID\n"
                    + "Where od.OrderID = " + id;
            ResultSet rs2 = dao.getData(sql2);
            String sql3 = "select * from status";
            ResultSet rs3 = dao.getData(sql3);
            request.setAttribute("data3", rs3);
            request.setAttribute("data", rs);
            request.setAttribute("data1", rs1);
            request.setAttribute("data2", rs2);
            request.getRequestDispatcher("OrderDetail.jsp").forward(request, response);
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
        int statusID = Integer.parseInt(request.getParameter("status"));
        int orderID = Integer.parseInt(request.getParameter("orderID"));
        DAOOrder dao = new DAOOrder();
        int n = dao.updateStatus1(statusID, orderID);
        String email = request.getParameter("email");
        if (statusID == 4) {
            sendEmail(email);
            dao.updateShippedDate(orderID);
        }
        String st = (n > 0) ? "Cập nhật trạng thái thành công" : "Cập nhật trạng thái thất bại";
        response.sendRedirect("saleManagerOrderListURL?message=" + URLEncoder.encode(st, "UTF-8"));
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

    public void sendEmail(String emailTo) {
        String emailFrom = "smartketfpt@gmail.com";
        String password = "hvdw qdeh rbvg ahox";
        //properties
        Properties pro = new Properties();
        pro.put("mail.smtp.host", "smtp.gmail.com");
        pro.put("mail.smtp.port", "587");
        pro.put("mail.smtp.auth", "true");
        pro.put("mail.smtp.starttls.enable", "true");
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
            msg.setSubject("Đơn hàng đã được giao thành công " + System.currentTimeMillis(), "UTF-8");
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
                    + "   width: 165px;\n"
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
                    + "                <div class=\"veryfication-remind\">Đơn hàng của bạn đã được giao</div>\n"
                    + "                <div><img class=\"veryfication-logo\"src=\"https://i.imgur.com/GVovat4.png\" alt=\"logo\" title=\"logo\"/></div>\n"
                    + "                <a href=\"\" ><div class=\"veryfication-btn\">Cảm ơn và hẹn gặp lại</div></a>\n"
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
