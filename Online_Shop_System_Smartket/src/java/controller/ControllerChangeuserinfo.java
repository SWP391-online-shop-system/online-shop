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
import view.User;
import model.DAOUser;


/**
 *
 * @author 84395
 */
@WebServlet(name="changeuserinfo", urlPatterns={"/changeuserinfo"})
public class ControllerChangeuserinfo extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet changeuserinfo</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet changeuserinfo at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
            request.getRequestDispatcher("profileUser.jsp").forward(request, response);

    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        
        
        //change password
       String lastname = request.getParameter("lastname");
       String firstName = request.getParameter("firstName");
       String phonenumber = request.getParameter("phonenumber");
       String address = request.getParameter("address");

       HttpSession session = request.getSession();
       User user = (User) session.getAttribute("user");
       DAOUser dao = new DAOUser();
       
        User u= new User(user.getUserID(),firstName,firstName,address,phonenumber,user.getDateOfBirth(),user.isGender(),user.getUserImage(),
        user.getPassword(),user.getEmail(),user.getLastLogin(),user.isUserStatus(),user.getReportTo(),user.getRoleID());
        dao.updateUser(u);
        session.setAttribute("inputerror","Thay đổi thành công");
        request.getRequestDispatcher("profileUser.jsp").forward(request, response);
       
    }
    
    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
  
}
