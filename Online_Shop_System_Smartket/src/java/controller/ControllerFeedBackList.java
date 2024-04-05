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
import java.sql.ResultSet;
import model.DAOFeedBack;
import view.FeedBack;

/**
 *
 * @author admin
 */
@WebServlet(name = "ControllerFeedBackList", urlPatterns = {"/marketingFeedBackListURL"})
public class ControllerFeedBackList extends HttpServlet {

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
            out.println("<title>Servlet ControllerFeedBackList</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControllerFeedBackList at " + request.getContextPath() + "</h1>");
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
        DAOFeedBack daoFeedBack = new DAOFeedBack();
        ResultSet rsFeedBack;
        String status_raw = request.getParameter("status");
        String ProductID_raw = request.getParameter("ProductID");
        String ProductRate_raw = request.getParameter("ProductRate");
        int status = 0, productID = 0, feedBackRate = 0;
        String sql = "select * from FeedBack";
        if (status_raw != null && !status_raw.equals("")) {
            status = Integer.parseInt(status_raw);
            if (!status_raw.equals("2")) {
                sql += " where FeedBackStatus=" + status;
            }
        }
        if (ProductID_raw != null && !ProductID_raw.equals("")) {
            productID = Integer.parseInt(ProductID_raw);
            if (!ProductID_raw.equals("0")) {
                if (sql.contains("where")) {
                    sql += " and";
                } else {
                    sql += " where";
                }
                sql += " ProductID = " + ProductID_raw;
            }
        }
        if (ProductRate_raw != null && !ProductRate_raw.equals("")) {
            feedBackRate = Integer.parseInt(ProductRate_raw);
            if (!ProductRate_raw.equals("0")) {
                if (sql.contains("where")) {
                    sql += " and";
                } else {
                    sql += " where";
                }
                sql += " FeedbackRate = " + ProductRate_raw;
            }
        }
        rsFeedBack = daoFeedBack.getData(sql);
        ResultSet rsProductSelect = daoFeedBack.getData("select ProductID from FeedBack group by ProductID;");
        request.setAttribute("rsFeedBack", rsFeedBack);
        request.setAttribute("status", status);
        request.setAttribute("rsProductSelect", rsProductSelect);
        request.setAttribute("productID", productID);
        request.setAttribute("feedBackRate", feedBackRate);
        request.getRequestDispatcher("feedbackList.jsp").forward(request, response);

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
