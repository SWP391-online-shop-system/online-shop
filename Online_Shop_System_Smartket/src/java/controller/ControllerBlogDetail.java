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
import java.util.List;
import model.DAOBlog;
import view.Blog;
import view.Categories;
import view.User;

/**
 *
 * @author admin
 */
@WebServlet(name = "ControllerBlogDetail", urlPatterns = {"/blogdetail"})
public class ControllerBlogDetail extends HttpServlet {

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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        if (user != null) {
            String userImage = user.getUserImage();
            request.setAttribute("userImage", userImage);
        }
        String bid_st = request.getParameter("bid");
        int bid = Integer.parseInt(bid_st);
        DAOBlog dao = new DAOBlog();
        List<Blog> listNB = dao.getNewBlog();
        List<Blog> listGB = dao.getGoodBlog();
        List<Categories> listC = dao.getAllCategories();
        Blog b = dao.getBlogByID(bid);
        ResultSet rs;
        String sql = "select * from user as u join comments as c on u.UserID = c.UserID where BlogID= " + bid_st + "\n";
        rs = dao.getData(sql);

        request.setAttribute("bid", bid_st);
        request.setAttribute("listC", listC);
        request.setAttribute("listNB", listNB);
        request.setAttribute("listGB", listGB);
        request.setAttribute("Bdetail", b);
        request.setAttribute("rs", rs);
        request.getRequestDispatcher("blogdetail.jsp").forward(request, response);
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
