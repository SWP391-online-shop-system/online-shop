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
import model.DAOOrder;
import model.DAOProduct;
import view.User;

/**
 *
 * @author admin
 */
@WebServlet(name = "ControllerMyOrder", urlPatterns = {"/MyOrderURL"})
public class ControllerMyOrder extends HttpServlet {

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
            DAOOrder daoOrd = new DAOOrder();
            DAOProduct daoPro = new DAOProduct();
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("account");

            String message = "";

            if (user == null) {
                message = "Bạn cần đăng nhập";
                request.setAttribute("message", message);
                request.getRequestDispatcher("loginURL").forward(request, response);
            } else {
                double maxValue = daoPro.getMaxUnitPrice();
                double minValue = daoPro.getMinUnitPrice();
                request.setAttribute("inputMinPrice", minValue);
                request.setAttribute("inputMaxPrice", maxValue);
                ResultSet rsCategory = daoPro.getData("Select * from Categories");
                request.setAttribute("CategoryResult", rsCategory);
                int UserID = user.getUserID();
                String indexPage = request.getParameter("index");
                if (indexPage == null) {
                    indexPage = "1";
                }
                int index = Integer.parseInt(indexPage);
                int pagingindex = (index - 1) * 2;
                ResultSet rsOrderGroup = daoOrd.getData("SELECT * FROM `order` as o\n"
                        + "JOIN `OrderDetail` as od ON o.orderID = od.orderID\n"
                        + "where o.UserID = " + UserID + " group BY o.orderID limit " + pagingindex + ", 2");
                System.out.println("sql = SELECT * FROM `order` as o\n"
                        + "JOIN `OrderDetail` as od ON o.orderID = od.orderID\n"
                        + "where o.UserID = " + UserID + " group BY o.orderID limit " + pagingindex + ", 2");
                int count = daoOrd.getTotalOrderOfUser(UserID);
                int endPage = count / 2;
                if (count % 2 != 0) {
                    endPage++;
                }
                request.setAttribute("rsOrderGroup", rsOrderGroup);
                request.setAttribute("endP", endPage);
                request.setAttribute("tag", index);
                request.getRequestDispatcher("MyOrder.jsp").forward(request, response);
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
