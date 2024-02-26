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
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.List;
import java.util.Vector;
import model.DAOBlog;
import model.DAOCategories;
import view.Blog;
import view.Categories;

/**
 *
 * @author admin
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB

@WebServlet(name = "ControlllerEditPost", urlPatterns = {"/editPost"})
public class ControlllerEditPost extends HttpServlet {

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
        String uploadAuthorImg = "images/blog_author"; // Đường dẫn thư mục để lưu trữ ảnh 1
        String uploadPostImg = "images/blog"; // Đường dẫn thư mục để lưu trữ ảnh 2
        DAOBlog dao = new DAOBlog();
        DAOCategories daoCate = new DAOCategories();
        String SBlogID = request.getParameter("BlogID");
        int BlogID = Integer.parseInt(SBlogID);
        Blog blog = dao.getBlogByID(BlogID);
        Vector<Categories> categories = daoCate.getCategories("SELECT * FROM categories");
//        dao.editBlog(Blog.getCategoryID(),Blog.getBlogAuthor(),Blog.getAuthorImage(),Blog.getBlogImage(),Blog.getBlogTitle(),Blog.getBlogContent(),Blog.getHiddenStatus(),Blog.getCreateTime(), Blog.getBlogID());
        
//        File dir1 = new File(uploadAuthorImg);
//        if (!dir1.exists()) {
//            dir1.mkdirs();
//        }
//
//        File dir2 = new File(uploadPostImg);
//        if (!dir2.exists()) {
//            dir2.mkdirs();
//        }
//
//        Part authorImg = request.getPart("authorImg");
//        String authorImgFileName = authorImg.getSubmittedFileName();
//        String authorImgFilePath = uploadAuthorImg + File.separator + authorImgFileName;
//        authorImg.write(authorImgFilePath);
//
//        Part blogImg = request.getPart("blogImg");
//        String blogImgFileName = blogImg.getSubmittedFileName();
//        String blogImgFilePath = uploadPostImg + File.separator + blogImgFileName;
//        blogImg.write(blogImgFilePath);

        // Thực hiện các xử lý khác sau khi upload file thành công
        request.setAttribute("blog", blog);
        request.setAttribute("category", categories);
        request.getRequestDispatcher("EditPost.jsp").forward(request, response);
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
