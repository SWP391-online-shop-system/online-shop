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
import model.DAOLog;
import model.DAOUser;
import view.Log;
import view.User;

/**
 *
 * @author trant
 */
@WebServlet(name = "ControllerCustomerDetail", urlPatterns = {"/marketingCustomerDetail"})
public class ControllerCustomerDetail extends HttpServlet {

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
        /* TODO output your page here. You may use following sample code. */
        DAOUser dao = new DAOUser();
        DAOLog daoLog = new DAOLog();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account"); //nhan vien
        if (user == null) {
            response.sendRedirect("HomePageURL");
        } else {
            String service = request.getParameter("service");
            String status_raw = request.getParameter("status");
            String cusID = request.getParameter("uid"); // khach hang
            if (service == null) {
                service = "showDetail";
            }
            if (service.equals("showDetail")) {
                User u1 = dao.getUserByUserID(Integer.parseInt(cusID));
                int status = 0;
                if (status_raw == null || status_raw.equals("")) {
                    status = u1.getUserStatus();
                } else {
                    status = Integer.parseInt(status_raw);
                }
                ResultSet rs = dao.getData("SELECT * FROM `user` where userID = " + cusID);
                ResultSet log = dao.getData("SELECT * FROM loghistory as log join `user` as u on log.UserId = u.UserID where u.UserId = " + cusID + " order by updateAt desc ");
                request.setAttribute("data", rs);
                request.setAttribute("log", log);
                request.setAttribute("status", status);
                request.getRequestDispatcher("customerdetails.jsp").forward(request, response);
            }

            if (service.equals("changeStatus")) {
                int updateBy = user.getUserID();
                int status = Integer.parseInt(status_raw);
                String purpose = "";
                int cusId = Integer.parseInt(cusID);
                if (status == 1) {
                    int n = dao.updateStatus(cusId, 2);
                    status = 2;
                    purpose = "đã vô hiệu hóa";
                }
                else {
                    int a = dao.updateStatus(cusId, 1);
                    status = 1;
                    purpose = "đã kích hoạt";
                }
                Log logger = new Log(cusId, updateBy, purpose);
                daoLog.insertLog(logger);
                ResultSet rs = dao.getData("SELECT * FROM `user` where userID = " + cusID);
                ResultSet log = dao.getData("SELECT * FROM loghistory as log join `user` as u on log.UserId = u.UserID where u.UserId = " + cusID + " order by updateAt desc ");
                request.setAttribute("data", rs);
                request.setAttribute("log", log);
                request.setAttribute("status", status);
                request.getRequestDispatcher("customerdetails.jsp").forward(request, response);
            }
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
