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
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import model.DAOProduct;
import static model.DAOProduct.getCurrentTimestamp;
import model.DAOSlider;
import view.Slider;

/**
 *
 * @author 84395
 */
public class sliderList extends HttpServlet {

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
            out.println("<title>Servlet sliderList</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet sliderList at " + request.getContextPath() + "</h1>");
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
        DAOSlider dao = new DAOSlider();
        HttpSession session = request.getSession();
        Vector<Slider> sliderlist = new Vector<>();
        String statusfilter = request.getParameter("statusfilter");
            sliderlist = dao.getSlider("select * from slider");
            session.setAttribute("sliderlist", sliderlist);
        session.setAttribute("timetoday", getCurrentTimestamp());
        if(statusfilter!=null){
        if (statusfilter.equalsIgnoreCase("true")) {
            sliderlist = dao.getSlider("select * from slider where SliderStatus=0");
            session.setAttribute("sliderlist", sliderlist);
        }
        if (statusfilter.equalsIgnoreCase("false")) {
            sliderlist = dao.getSlider("select * from slider where SliderStatus=1");
            session.setAttribute("sliderlist", sliderlist);
        }
        if (statusfilter.equalsIgnoreCase("tatca")) {
            sliderlist = dao.getSlider("select * from slider ");
            session.setAttribute("sliderlist", sliderlist);
        }}

        request.getRequestDispatcher("sliderList.jsp").forward(request, response);

          
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
