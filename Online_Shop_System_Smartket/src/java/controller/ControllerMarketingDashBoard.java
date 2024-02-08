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
import java.util.Calendar;
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
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Calendar calendar = Calendar.getInstance();
                calendar.add(Calendar.DAY_OF_YEAR, -6); // Subtract 6 days from the current date
                weekFrom = sdf.format(calendar.getTime());
                rsProductSold = daoPro.getData("SELECT dates.date, COALESCE(earning, 0) AS earning\n"
                        + "FROM (\n"
                        + "  SELECT DATE_SUB(CURDATE(), INTERVAL 6 DAY) + INTERVAL (t4.i * 10000 + t3.i * 1000 + t2.i * 100 + t1.i * 10 + t0.i) DAY AS date\n"
                        + "  FROM\n"
                        + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t0,\n"
                        + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t1,\n"
                        + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t2,\n"
                        + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t3,\n"
                        + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t4\n"
                        + ") AS dates\n"
                        + "LEFT JOIN (\n"
                        + "  SELECT DATE_FORMAT(p.CreateDate, '%Y-%m-%d') AS date, SUM(((p.UnitPrice * (100 - p.UnitDiscount) / 100) * (p.TotalStock - p.UnitInStock))) AS earning\n"
                        + "  FROM Product AS p\n"
                        + "  LEFT JOIN ProductImage AS pi ON p.ProductID = pi.ProductID \n"
                        + "  WHERE pi.ProductURL LIKE '%_1%' AND ((p.TotalStock - p.UnitInStock) > 0)\n"
                        + "  GROUP BY date\n"
                        + ") AS earnings ON dates.date = earnings.date\n"
                        + "WHERE dates.date BETWEEN (CURDATE() - INTERVAL 6 DAY) AND CURDATE()\n"
                        + "ORDER BY dates.date;");
                request.setAttribute("rsProductSold", rsProductSold);
                request.setAttribute("formatWeekFrom", weekFrom);
            } else {
                LocalDate dateWeekFrom = LocalDate.parse(weekFrom, formatter);
                String formatWeekFrom = dateWeekFrom.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                rsProductSold = daoPro.getData("SELECT dates.date, COALESCE(earning, 0) AS earning\n"
                        + "FROM (\n"
                        + "  SELECT DATE_SUB(CURDATE(), INTERVAL 6 DAY) + INTERVAL (t4.i * 10000 + t3.i * 1000 + t2.i * 100 + t1.i * 10 + t0.i) DAY AS date\n"
                        + "  FROM\n"
                        + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t0,\n"
                        + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t1,\n"
                        + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t2,\n"
                        + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t3,\n"
                        + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t4\n"
                        + ") AS dates\n"
                        + "LEFT JOIN (\n"
                        + "  SELECT DATE_FORMAT(p.CreateDate, '%Y-%m-%d') AS date, SUM(((p.UnitPrice * (100 - p.UnitDiscount) / 100) * (p.TotalStock - p.UnitInStock))) AS earning\n"
                        + "  FROM Product AS p\n"
                        + "  LEFT JOIN ProductImage AS pi ON p.ProductID = pi.ProductID \n"
                        + "  WHERE pi.ProductURL LIKE '%_1%' AND ((p.TotalStock - p.UnitInStock) > 0)\n"
                        + "  GROUP BY date\n"
                        + ") AS earnings ON dates.date = earnings.date\n"
                        + "WHERE dates.date BETWEEN '" + formatWeekFrom + "' and ('" + formatWeekFrom + "' + INTERVAL 6 DAY)\n"
                        + "ORDER BY dates.date;");
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
