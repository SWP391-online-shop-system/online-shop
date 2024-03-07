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
import model.DAOOrder;

/**
 *
 * @author admin
 */
@WebServlet(name = "ControllerOrderTrack", urlPatterns = {"/OrderTrackURL"})
public class ControllerOrderTrack extends HttpServlet {

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
            out.println("<title>Servlet ControllerOrderTrack</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControllerOrderTrack at " + request.getContextPath() + "</h1>");
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
        DAOOrder daoOrd = new DAOOrder();
        //filter
        String status = request.getParameter("status").toLowerCase();
        System.out.println("status = " + status);
        if (status.equals("")) {
            status = "all";
        }
        String orderFrom = request.getParameter("orderFrom");
        System.out.println("status = " + status);
        String orderTo = request.getParameter("orderTo");
        System.out.println("status = " + status);
        String sql = "select * from `Order` ";

        if (status.equals("all")) {
            System.out.println("1");
            if (sql.contains("where")) {
                sql += " and";
            } else {
                sql += "";
            }
        }
        if (status.equals("1")) {
            System.out.println("2");
            if (sql.contains("where")) {
                sql += " and";
            } else {
                sql += " where";
            }
            sql += " StatusID = 1";
        }
        if (status.equals("2")) {
            System.out.println("3");
            if (sql.contains("where")) {
                sql += " and";
            } else {
                sql += " where";
            }
            sql += " StatusID = 2";
        }
        if (status.equals("3")) {
            System.out.println("4");
            if (sql.contains("where")) {
                sql += " and";
            } else {
                sql += " where";
            }
            sql += " StatusID = 3";
        }
        if (status.equals("4")) {
            System.out.println("5");
            if (sql.contains("where")) {
                sql += " and";
            } else {
                sql += " where";
            }
            sql += " StatusID = 4";
        }
        if (status.equals("5")) {
            System.out.println("6");
            if (sql.contains("where")) {
                sql += " and";
            } else {
                sql += " where";
            }
            sql += " StatusID = 5";
        }
        if (orderFrom.equals("") || orderFrom == null) {
            System.out.println("7");
        } else {
            System.out.println("8");
            if (sql.contains("where")) {
                sql += " and";
            } else {
                sql += " where";
            }
            sql += " orderDate >='" + orderFrom + "'";
        }

        if (orderTo.equals("") || orderTo == null) {
            System.out.println("9");
        } else {
            System.out.println("10");
            if (sql.contains("where")) {
                sql += " and";
            } else {
                sql += " where";
            }
            sql += " OrderDate <='" + orderTo + " 23:59:59'";
        }
        System.out.println("sql = " + sql);
        ResultSet rsOrder = daoOrd.getData(sql);
        request.setAttribute("status", status);
        request.setAttribute("orderFrom", orderFrom);
        request.setAttribute("orderTo", orderTo);
        request.setAttribute("rsOrder", rsOrder);
        request.getRequestDispatcher("orderTrack.jsp").forward(request, response);
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
