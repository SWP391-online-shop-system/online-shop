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
@WebServlet(name="Changepassword", urlPatterns={"/ChangepasswordURL"})
public class ControllerChangepassword extends HttpServlet {
   
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
       String oldPassword = request.getParameter("oldPassword");
       String newPassword = request.getParameter("newPassword");
       String renewPassword = request.getParameter("renewPassword");
       HttpSession session = request.getSession();
session.removeAttribute("inputerror");
       User user = (User) session.getAttribute("account");
       DAOUser dao = new DAOUser();
       User checkOldpassword = dao.check(user.getEmail(), oldPassword);
       if(checkOldpassword==null){
           session.setAttribute("inputerror","Nhập sai mật khẩu cũ!!");
           request.getRequestDispatcher("profileUser.jsp").forward(request, response);
       }else
            if((newPassword.length()<6)){
           session.setAttribute("inputerror","Nhập mật khẩu mới sai fomat!!");
            request.getRequestDispatcher("profileUser.jsp").forward(request, response);
       }else
       if(!newPassword.equals(renewPassword)){
           session.setAttribute("inputerror","Nhập lại sai mật khẩu mới!!");
            request.getRequestDispatcher("profileUser.jsp").forward(request, response);
       }else {
        User u= new User(user.getUserID(),user.getFirstName(),user.getLastName(),user.getAddress(),user.getPhoneNumber(),user.getDateOfBirth(),user.isGender(),user.getUserImage(),
        newPassword,user.getEmail(),user.getLastLogin(),user.isUserStatus(),user.getReportTo(),user.getRoleID());
        dao.updateUser(u);
           System.out.println("Update thnh cong");
        session.setAttribute("inputerror","Thay đổi thành công");
        request.getRequestDispatcher("profileUser.jsp").forward(request, response);
       }
    }
    
    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
  
}
