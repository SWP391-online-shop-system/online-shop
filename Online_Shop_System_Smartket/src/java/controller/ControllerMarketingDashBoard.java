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
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import model.DAOProduct;

/**
 *
 * @author admin
 */
@WebServlet(name = "ControllerMarketingDashBoard", urlPatterns = {"/MarketingDashBoardURL"})
public class ControllerMarketingDashBoard extends HttpServlet {

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
            DAOProduct daoPro = new DAOProduct();
            ResultSet rsProductSold;
            String weekFrom = request.getParameter("weekFrom");
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            if (weekFrom == null || weekFrom.equals("")) {
                SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
                weekFrom = sdf.format(new Date());
                rsProductSold = daoPro.getData("select p.CreateDate,sum(((p.UnitPrice * (100-p.UnitDiscount)/100) * (p.TotalStock - p.UnitInStock))) as earning from Product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%'\n"
                        + "and  ((p.TotalStock - p.UnitInStock) > 0) group by p.CreateDate having p.CreateDate BETWEEN (CURDATE() - INTERVAL 6 DAY) and CURDATE();");
                request.setAttribute("rsProductSold", rsProductSold);
                request.setAttribute("formatWeekFrom", weekFrom);
            } else {
                LocalDate dateWeekFrom = LocalDate.parse(weekFrom, formatter);
                String formatWeekFrom = dateWeekFrom.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                rsProductSold = daoPro.getData("select p.CreateDate,sum(((p.UnitPrice * (100-p.UnitDiscount)/100) * (p.TotalStock - p.UnitInStock))) as earning from Product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%'\n"
                        + "and  ((p.TotalStock - p.UnitInStock) > 0) group by p.CreateDate having p.CreateDate between '" + formatWeekFrom + "' and (" + formatWeekFrom + " - INTERVAL 6 DAY)");
                request.setAttribute("rsProductSold", rsProductSold);
                request.setAttribute("formatWeekFrom", formatWeekFrom);
            }
            request.getRequestDispatcher("marketingDashboard.jsp").forward(request, response);
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
