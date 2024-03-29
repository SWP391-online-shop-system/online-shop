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
import model.DAOLog;
import model.DAOSlider;
import view.Slider;
import view.User;

/**
 *
 * @author 84395
 */
@WebServlet(name = "sliderdetail", urlPatterns = {"/marketingSliderdetail"})
public class sliderdetail extends HttpServlet {

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
        DAOLog daoU = new DAOLog();
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("account");
        if (u == null) {
            String message = "Bạn cần đăng nhập";
            request.setAttribute("message", message);
            request.getRequestDispatcher("loginURL").forward(request, response);
        }
        String id = request.getParameter("id");
        DAOSlider DAOSlider = new DAOSlider();
        Slider slider = DAOSlider.getaSlider("select * from slider where sliderId = " + id);
        session.setAttribute("getaSlider", slider);
        ResultSet logger = daoU.getData("SELECT * FROM loghistory where ID=" + id+ " and updateBy = " + u.getUserID()
                + " and logTopic = 3 and logType like '%Cập nhật%' order by updateAt desc");
        request.setAttribute("log", logger);
        request.getRequestDispatcher("sliderdetail.jsp").forward(request, response);

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
