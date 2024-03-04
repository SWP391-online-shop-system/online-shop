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
import model.DAOProduct;

/**
 *
 * @author admin
 */
@WebServlet(name = "ControllerOrderInformation", urlPatterns = {"/OrderInformationURL"})
public class ControllerOrderInformation extends HttpServlet {

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
            out.println("<title>Servlet ControllerOrderInformation</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControllerOrderInformation at " + request.getContextPath() + "</h1>");
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
        DAOProduct daoPro = new DAOProduct();
        //sidebar part start
        double maxValue = daoPro.getMaxUnitPrice();
        double minValue = daoPro.getMinUnitPrice();
        request.setAttribute("inputMinPrice", minValue);
        request.setAttribute("inputMaxPrice", maxValue);
        ResultSet rsCategory = daoPro.getData("Select * from Categories");
        request.setAttribute("CategoryResult", rsCategory);
        //sidebar part end
        //get data from receiver
        int OrderID = Integer.parseInt(request.getParameter("OrderID"));
        ResultSet rsReceiver = daoPro.getData("select * from Receiver where OrderID = " + OrderID);
        request.setAttribute("rsReceiver", rsReceiver);
        //get data from order
        ResultSet rsOrder = daoPro.getData("select * from `Order` where OrderID =" + OrderID);
        request.setAttribute("rsOrder", rsOrder);
        //get data from OrderDetail
         ResultSet rsOrderDetail = daoPro.getData("select * from OrderDetail where OrderID =" + OrderID);
        request.setAttribute("rsOrderDetail", rsOrderDetail);
        request.setAttribute("OrderID", OrderID);
        
        request.getRequestDispatcher("orderInformation.jsp").forward(request, response);
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
