/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
import java.util.*;
import java.lang.*;
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
import model.DAOCategories;
import model.DAOSetting;
import model.DAOSlider;
import view.Categories;
import view.Setting;
import view.Slider;
import view.User;

/**
 *
 * @author 84395
 */
@WebServlet(name = "updatesetting", urlPatterns = {"/updatesetting"})
public class updatesetting extends HttpServlet {

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

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("111111111111111111+alo = "+request.getParameter("updateset"));
        DAOSetting dao = new DAOSetting();
        Setting Setting1 = dao.getaSlider("select * from Setting where SettingID = " + request.getParameter("updatesettingid"));
        int n = dao.updateSetting(Setting1,request.getParameter("updateset"));
        String statuscate = "false";
        if(request.getParameter("updateset").equals("0"))
            statuscate="true";
        int m = dao.updateCate(Setting1, statuscate);
        response.sendRedirect("settinglist");

    }

   



@Override
public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
