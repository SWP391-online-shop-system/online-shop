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
import java.sql.ResultSet;
import view.User;
import model.DAOUser;

/**
 *
 * @author 84395
 */
@WebServlet(name = "changeuserinfo", urlPatterns = {"/ChangeuserinfoURL"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class ControllerChangeuserinfo extends HttpServlet {

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
            int UserID = Integer.parseInt(request.getParameter("UserID"));
            String service = request.getParameter("service");
            if (service == null || service.equals("")) {
                service = "";
            }
            DAOUser daoU = new DAOUser();
            ResultSet rsProfile = daoU.getData("select * from User where UserID = " + UserID);
            request.setAttribute("rsProfile", rsProfile);
            if (service.equals("upload")) {

            }
            request.getRequestDispatcher("profileUser.jsp").forward(request, response);
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
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        int UserID = Integer.parseInt(request.getParameter("UserID"));
        String service = request.getParameter("service");
        if (service == null || service.equals("")) {
            service = "";
        }
        DAOUser daoU = new DAOUser();
        User user = daoU.getUserByUserID(UserID);
        ResultSet rsProfile = daoU.getData("select * from User where UserID = " + UserID);
        request.setAttribute("rsProfile", rsProfile);
        if (service.equals("upload")) {
            String mess = "";
            String newImageName = "AvatarUser" + UserID;
            Part filePart = request.getPart("file");
            String fileName = filePart.getSubmittedFileName();
            int dotIndex = fileName.lastIndexOf(".");
            String result = newImageName + fileName.substring(dotIndex);
            for (Part part : request.getParts()) {
                part.write("D:\\fpt\\Semeter_5\\SWP391\\Project\\Online_Shop_System_Smartket\\web\\images\\user\\" + result);
            }
            user.setUserImage(result);
            int n = daoU.updateUser(user);
            if (n > 0) {
                mess = "Tải ảnh lên thành công";
            } else {
                mess = null;
            }
            request.setAttribute("mess", mess);
            request.getRequestDispatcher("profileUser.jsp").forward(request, response);
        }
    }
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
}
