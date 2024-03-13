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
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import model.DAOOrder;
import model.DAOProduct;
import view.User;

/**
 *
 * @author trant
 */
@WebServlet(name = "ControllerSaleDashBoard", urlPatterns = {"/saleDashBoardURL"})
public class ControllerSaleDashBoard extends HttpServlet {

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
            User user = (User) session.getAttribute("account");
            if (user == null) {
                response.sendRedirect("HomePageURL");
            } else {
                int userId = user.getUserID();
                DAOProduct daoPro = new DAOProduct();
                DAOOrder daoOd = new DAOOrder();
                ResultSet rsProductSold;
                ResultSet rsOrderList;
                String weekFrom = request.getParameter("weekFrom");
                String orderFrom = request.getParameter("orderFrom");
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                if (user.getRoleID() == 3) {
                    if (weekFrom == null || weekFrom.equals("")) {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        Calendar calendar = Calendar.getInstance();
                        calendar.add(Calendar.DAY_OF_YEAR, -6); // Subtract 6 days from the current date
                        weekFrom = sdf.format(calendar.getTime());
                        rsProductSold = daoPro.getData(" SELECT dates.date, COALESCE(earning, 0) AS earning \n"
                                + "                        FROM (SELECT DATE_SUB(CURDATE(), INTERVAL 6 DAY) + INTERVAL (t4.i * 10000 + t3.i * 1000 + t2.i * 100 + t1.i * 10 + t0.i) DAY AS date \n"
                                + "                        FROM (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t0, \n"
                                + "                        (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t1, \n"
                                + "                        (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t2, \n"
                                + "                        (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t3, \n"
                                + "                        (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t4) AS dates\n"
                                + "                        LEFT JOIN (\n"
                                + "                        SELECT DATE_FORMAT(OrderDate, '%Y-%m-%d') AS date, SUM(TotalPrice) AS earning   \n"
                                + "                        FROM `order` where SaleID = " + userId + " and `StatusID` = 4  GROUP BY date) \n"
                                + "                        AS earnings ON dates.date = earnings.date   \n"
                                + "                        WHERE dates.date BETWEEN (CURDATE() - INTERVAL 6 DAY) AND NOW() \n"
                                + "                        ORDER BY dates.date;");
                        request.setAttribute("rsProductSold", rsProductSold);
                        request.setAttribute("formatWeekFrom", weekFrom);
                    } else {
                        LocalDate dateWeekFrom = LocalDate.parse(weekFrom, formatter);
                        String formatWeekFrom = dateWeekFrom.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        rsProductSold = daoPro.getData("SELECT dates.date, COALESCE(earning, 0) AS earning\n"
                                + "FROM (\n"
                                + "  SELECT DATE_SUB('" + formatWeekFrom + "', INTERVAL 6 DAY) + INTERVAL (t4.i * 10000 + t3.i * 1000 + t2.i * 100 + t1.i * 10 + t0.i) DAY AS date\n"
                                + "  FROM\n"
                                + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t0,\n"
                                + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t1,\n"
                                + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t2,\n"
                                + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t3,\n"
                                + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t4\n"
                                + ") AS dates\n"
                                + "LEFT JOIN (\n"
                                + "SELECT DATE_FORMAT(OrderDate, '%Y-%m-%d') AS date, SUM(TotalPrice) AS earning   \n"
                                + "FROM `order` where SaleID = " + userId + " and `StatusID` = 4  GROUP BY date) \n"
                                + "AS earnings ON dates.date = earnings.date   \n"
                                + "WHERE dates.date BETWEEN '" + formatWeekFrom + "' and ('" + formatWeekFrom + "' + INTERVAL 6 DAY)\n"
                                + "ORDER BY dates.date;");
                        request.setAttribute("rsProductSold", rsProductSold);
                        request.setAttribute("formatWeekFrom", formatWeekFrom);
                    }
                    if (orderFrom == null || orderFrom.equals("")) {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        Calendar calendar = Calendar.getInstance();
                        calendar.add(Calendar.DAY_OF_YEAR, -6);
                        orderFrom = sdf.format(calendar.getTime());
                        rsOrderList = daoOd.getData("select * from `order` as o join `user` as u on o.UserID = u.UserID join `status` as s on o.StatusID = s.StatusID where SaleID = "+userId+" and OrderDate between now() - interval 6 day and now() ORDER BY OrderDate");
                        request.setAttribute("rsOrderList", rsOrderList);
                        request.setAttribute("formatOrderWeekFrom", orderFrom);
                    } else {
                        LocalDate dateOrderWeekFrom = LocalDate.parse(orderFrom, formatter);
                        String formatOrderWeekFrom = dateOrderWeekFrom.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        rsOrderList = daoOd.getData("select * from `order` as o join `user` as u on o.UserID = u.UserID join `status` as s on o.StatusID = s.StatusID WHERE SaleID = "+userId+" and OrderDate between '" + formatOrderWeekFrom + "' AND '" + formatOrderWeekFrom + "' + interval 7 day ORDER BY OrderDate;");
                        request.setAttribute("rsOrderList", rsOrderList);
                        request.setAttribute("formatOrderWeekFrom", formatOrderWeekFrom);
                    }
                }
                if (user.getRoleID() == 4) {
                    if (weekFrom == null || weekFrom.equals("")) {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        Calendar calendar = Calendar.getInstance();
                        calendar.add(Calendar.DAY_OF_YEAR, -6); // Subtract 6 days from the current date
                        weekFrom = sdf.format(calendar.getTime());
                        rsProductSold = daoPro.getData(" SELECT dates.date, COALESCE(earning, 0) AS earning \n"
                                + "                        FROM (SELECT DATE_SUB(CURDATE(), INTERVAL 6 DAY) + INTERVAL (t4.i * 10000 + t3.i * 1000 + t2.i * 100 + t1.i * 10 + t0.i) DAY AS date \n"
                                + "                        FROM (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t0, \n"
                                + "                        (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t1, \n"
                                + "                        (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t2, \n"
                                + "                        (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t3, \n"
                                + "                        (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t4) AS dates\n"
                                + "                        LEFT JOIN (\n"
                                + "                        SELECT DATE_FORMAT(OrderDate, '%Y-%m-%d') AS date, SUM(TotalPrice) AS earning   \n"
                                + "                        FROM `order` where `StatusID` = 4  GROUP BY date) \n"
                                + "                        AS earnings ON dates.date = earnings.date   \n"
                                + "                        WHERE dates.date BETWEEN (CURDATE() - INTERVAL 6 DAY) AND NOW() \n"
                                + "                        ORDER BY dates.date;");
                        request.setAttribute("rsProductSold", rsProductSold);
                        request.setAttribute("formatWeekFrom", weekFrom);
                    } else {
                        LocalDate dateWeekFrom = LocalDate.parse(weekFrom, formatter);
                        String formatWeekFrom = dateWeekFrom.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        rsProductSold = daoPro.getData("SELECT dates.date, COALESCE(earning, 0) AS earning\n"
                                + "FROM (\n"
                                + "  SELECT DATE_SUB('" + formatWeekFrom + "', INTERVAL 6 DAY) + INTERVAL (t4.i * 10000 + t3.i * 1000 + t2.i * 100 + t1.i * 10 + t0.i) DAY AS date\n"
                                + "  FROM\n"
                                + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t0,\n"
                                + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t1,\n"
                                + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t2,\n"
                                + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t3,\n"
                                + "    (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t4\n"
                                + ") AS dates\n"
                                + "LEFT JOIN (\n"
                                + "SELECT DATE_FORMAT(OrderDate, '%Y-%m-%d') AS date, SUM(TotalPrice) AS earning   \n"
                                + "FROM `order` where `StatusID` = 4  GROUP BY date) \n"
                                + "AS earnings ON dates.date = earnings.date   \n"
                                + "WHERE dates.date BETWEEN '" + formatWeekFrom + "' and ('" + formatWeekFrom + "' + INTERVAL 6 DAY)\n"
                                + "ORDER BY dates.date;");
                        request.setAttribute("rsProductSold", rsProductSold);
                        request.setAttribute("formatWeekFrom", formatWeekFrom);
                    }
                    if (orderFrom == null || orderFrom.equals("")) {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        Calendar calendar = Calendar.getInstance();
                        calendar.add(Calendar.DAY_OF_YEAR, -6);
                        orderFrom = sdf.format(calendar.getTime());
                        rsOrderList = daoOd.getData("select * from `order` as o join `user` as u on o.UserID = u.UserID join `status` as s on o.StatusID = s.StatusID where OrderDate between now() - interval 6 day and now() ORDER BY OrderDate");
                        request.setAttribute("rsOrderList", rsOrderList);
                        request.setAttribute("formatOrderWeekFrom", orderFrom);
                    } else {
                        LocalDate dateOrderWeekFrom = LocalDate.parse(orderFrom, formatter);
                        String formatOrderWeekFrom = dateOrderWeekFrom.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        rsOrderList = daoOd.getData("select * from `order` as o join `user` as u on o.UserID = u.UserID join `status` as s on o.StatusID = s.StatusID WHERE OrderDate between '" + formatOrderWeekFrom + "' AND '" + formatOrderWeekFrom + "' + interval 7 day ORDER BY OrderDate;");
//              
                        request.setAttribute("rsOrderList", rsOrderList);
                        request.setAttribute("formatOrderWeekFrom", formatOrderWeekFrom);
                    }
                }
                ResultSet rsOrderSuccessCount = daoOd.getData("select count(OrderID) from online_shop_system.order where StatusID = 4");
                ResultSet rsTotalOrderCount = daoOd.getData("select count(OrderID) from online_shop_system.order");
                request.setAttribute("rsOrderSuccessCount", rsOrderSuccessCount);
                request.setAttribute("rsTotalOrderCount", rsTotalOrderCount);
                request.getRequestDispatcher("saleDashboard.jsp").forward(request, response);
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

}
