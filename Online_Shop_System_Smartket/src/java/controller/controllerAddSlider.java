/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.DAOProduct;
import model.DAOProductImage;
import model.DAOSlider;
import view.Product;
import view.ProductImage;
import view.Slider;
import view.User;

/**
 *
 * @author 84395
 */
@WebServlet(name = "AddSlider", urlPatterns = {"/AddSlider"})
@MultipartConfig

public class controllerAddSlider extends HttpServlet {

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
            out.println("<title>Servlet controllerAddSlider</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet controllerAddSlider at " + request.getContextPath() + "</h1>");
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
        int sliderID1 = Integer.parseInt(request.getParameter("sliderID1").trim());
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("account");
        String sliderLink1 = request.getParameter("sliderLink1");
        String createDate1 = request.getParameter("createDate1");
        boolean sliderStatus1 = Boolean.parseBoolean(request.getParameter("sliderStatus1"));
        Part sliderImage1 = request.getPart("sliderImage1");
        String fileName = sliderImage1.getSubmittedFileName();
        String productImageURL = "images/slider/" + fileName;
        sliderImage1.write(productImageURL);
//        Slider newSlider = new Slider(sliderID1, u.getUserID(), fileName, sliderLink1, sliderStatus1, createDate1);
        DAOSlider DAOSlider = new DAOSlider();
//        int n = DAOSlider.insertSlider(newSlider);
        response.sendRedirect("sliderList");
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
