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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DAOFeedBack;
import model.DAOLog;
import model.DAOUser;
import view.FeedBack;
import view.Log;
import view.User;

/**
 *
 * @author admin
 */
@WebServlet(name = "ControllerFeedBackDetail", urlPatterns = {"/FeedBackDetailURL"})
public class ControllerFeedBackDetail extends HttpServlet {

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
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ControllerFeedBackDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControllerFeedBackDetail at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        HttpSession session = request.getSession();
        User oldUser = (User) session.getAttribute("account");
        if (oldUser == null) {
            response.sendRedirect("HomePageURL");
        } else {
            int updateBy = oldUser.getUserID(); // nhan vien
            DAOFeedBack daoF = new DAOFeedBack();
            DAOUser daoU = new DAOUser();
            DAOLog daoLog = new DAOLog();
            int FeedBackID = Integer.parseInt(request.getParameter("FeedBackID"));
            FeedBack FeedBack = daoF.getFeedBackById(FeedBackID);
            request.setAttribute("data", FeedBack);
            String StatusCheck = request.getParameter("checkStatus");
            System.out.println("statusCheck = " + StatusCheck);
            String status = request.getParameter("status");
            String cusId_str = request.getParameter("uid");
            int cusId = Integer.parseInt(cusId_str); //nguoi phan hoi
            System.out.println("status in servlet = " + status);
            String purpose = "";
            if (status.equals("1")) {
                daoF.updateStatus(FeedBackID, 0);
                purpose = "đã kích hoạt phản hồi";
            } else {
                daoF.updateStatus(FeedBackID, 1);
                purpose = "đã vô hiệu hóa phản hồi ";
            }
            Log log = new Log(cusId, updateBy, purpose);
            int n = daoLog.insertLog(log);
            ResultSet logger = daoU.getData("SELECT * FROM loghistory as log join `user` as u on log.UserId = u.UserID where u.UserId = " + cusId + " and purpose like '%phản hồi%'");
            request.setAttribute("log", logger);
            try {
                Thread.sleep(2000);
            } catch (InterruptedException ex) {
                Logger.getLogger(ControllerFeedBackDetail.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.getRequestDispatcher("FeedBackDetail.jsp").forward(request, response);
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

}
