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
import java.util.Vector;
import model.DAOUser;
import view.User;

/**
 *
 * @author trant
 */
@WebServlet(name = "ControllerCustomerList", urlPatterns = {"/customerlist"})
public class ControllerCustomerList extends HttpServlet {

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
            String service = request.getParameter("service");
            DAOUser dao = new DAOUser();
            String message = "";
            if (service == null) {
                service = "showList";
            }
            if (service.equals("showList")) {
                String index_raw = request.getParameter("index");
                String limit_raw = request.getParameter("limit");
                int limit = 5;
                int index = 1;
                if (limit_raw != null) {
                    limit = Integer.parseInt(limit_raw);
                }
                if (index_raw != null) {
                    index = Integer.parseInt(index_raw);
                }
                //paging
                int count = dao.getTotalCus();
                int endPage = count / limit;
                if (count % limit != 0) {
                    endPage++;
                }
                request.setAttribute("limit", limit_raw);
                request.setAttribute("endPage", endPage);
                Vector<User> list = dao.getUser("SELECT * FROM online_shop_system.user where roleID = 1");
                request.setAttribute("index", index);
                request.setAttribute("data", list);
                request.getRequestDispatcher("customerlist.jsp").forward(request, response);
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
