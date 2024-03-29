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
import model.DAOLog;
import model.DAOSlider;
import view.Log;
import view.Slider;
import view.User;

/**
 *
 * @author 84395
 */
@WebServlet(name = "updateslider", urlPatterns = {"/updateslider"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class controllerUpdateSlider extends HttpServlet {

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
        HttpSession session = request.getSession();
        DAOLog log = new DAOLog();
        User user = (User) session.getAttribute("account");
        if (user == null) {
            String message = "Bạn cần đăng nhập";
            request.setAttribute("message", message);
            request.getRequestDispatcher("loginURL").forward(request, response);
        }
        int sliderID1 = Integer.parseInt(request.getParameter("updatesliderid").trim());
        String sliderLink1 = request.getParameter("updateLink");
        boolean sliderStatus1 = Boolean.parseBoolean(request.getParameter("updateStatus"));
        String newImageName = "slide" + sliderID1;
        Part sliderpart = request.getPart("updateImg");
        String slidername = sliderpart.getSubmittedFileName();
        int dotIndex = slidername.lastIndexOf(".");
        if (!slidername.equals("")) {
            String result = newImageName + slidername.substring(dotIndex);
            String path = "images/slider/" + result;
            String realFileName = request.getServletContext().getRealPath(path);
            String realFileName1 = realFileName.replace("\\build", "");
            sliderpart.write(realFileName1);
            DAOSlider DAOSlider = new DAOSlider();
            Slider slider = DAOSlider.getaSlider("select * from slider where sliderId = " + sliderID1);
            slider.setSliderImage(result);
            slider.setSliderLink(sliderLink1);
            slider.setSliderStatus(sliderStatus1);
            int n = DAOSlider.updateProduct(slider);
            if (n > 0) {
                Log log1 = new Log(sliderID1, 3, "Cập nhật", user.getUserID(), "Đã cập nhật slide");
                log.insertLog(log1);
                request.setAttribute("log", log1);
            }
            try {
                Thread.sleep(3000);
                response.sendRedirect("marketingSliderList");
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        } else {
            DAOSlider DAOSlider = new DAOSlider();
            Slider slider = DAOSlider.getaSlider("select * from slider where sliderId = " + sliderID1);
            slider.setSliderLink(sliderLink1);
            slider.setSliderStatus(sliderStatus1);
            int n = DAOSlider.updateProduct(slider);
            if (n > 0) {
                Log log1 = new Log(sliderID1, 3, "Cập nhật", user.getUserID(), "Đã cập nhật slide");
                log.insertLog(log1);
                request.setAttribute("log", log1);
            }
            try {
                Thread.sleep(3000);
                response.sendRedirect("marketingSliderList");
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
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
