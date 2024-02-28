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
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DAOBlog;
import model.DAOProduct;

/**
 *
 * @author admin
 */
@WebServlet(name = "ControllerHomePage", urlPatterns = {"/HomePageURL"})
public class ControllerHomePage extends HttpServlet {

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
            DAOBlog daoBlog = new DAOBlog();
            DAOProduct dao = new DAOProduct();
            ResultSet rsNewBlog = daoBlog.getData("select * from Blog order by CreateTime desc limit 1");
            ResultSet rsFeatureBlog = daoBlog.getData("select * from Blog order by BlogRate desc limit 3");
            ResultSet rsSlider = daoBlog.getData("select SliderImage, SliderLink from Slider");
            int settingPage = 0;
            ResultSet rsSettingPage = dao.getData("select * from Setting where SettingID = 1");
            try {
                if (rsSettingPage.next()) {
                    settingPage = Integer.parseInt(rsSettingPage.getString("SettingValue"));
                }
            } catch (SQLException ex) {
                Logger.getLogger(ControllerHomePage.class.getName()).log(Level.SEVERE, null, ex);
            }
            ResultSet rsNewProduct = dao.getData("select * from product as p join productImage as pi on p.ProductID = pi.ProductID "
                    + "where pi.ProductURL = pi.ProductURLShow order by p.CreateDate desc limit "+settingPage);
            request.setAttribute("rsNewProduct", rsNewProduct);
            request.setAttribute("rsSlider", rsSlider);
            request.setAttribute("rsNewBlog", rsNewBlog);
            request.setAttribute("rsFeatureBlog", rsFeatureBlog);
            double maxValue = dao.getMaxUnitPrice();
            double minValue = dao.getMinUnitPrice();
            request.setAttribute("inputMinPrice", minValue);
            request.setAttribute("inputMaxPrice", maxValue);
            request.getRequestDispatcher("homepage.jsp").forward(request, response);
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
