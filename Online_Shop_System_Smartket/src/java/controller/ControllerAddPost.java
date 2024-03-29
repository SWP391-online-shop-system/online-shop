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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DAOBlog;
import model.DAOCategories;
import view.Blog;
import view.Categories;

/**
 *
 * @author admin
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
@WebServlet(name = "ControllerAddPost", urlPatterns = {"/marketingAddPost"})
public class ControllerAddPost extends HttpServlet {

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
        String service = request.getParameter("service");
        DAOBlog dao = new DAOBlog();
        List<Categories> categories = dao.getAllCategories();
        if (service.equals("addPost")) {
            request.setAttribute("category", categories);
            request.getRequestDispatcher("addPost.jsp").forward(request, response);
        }
        if (service.equals("upload")) {
            Part photo1 = request.getPart("authorImg");
            Part photo2 = request.getPart("blogImg");

            System.out.println("photo1" + photo1);
            System.out.println("photo2" + photo2);

            String authorImg = getSubmittedFileName(photo1);
            String blogImg = getSubmittedFileName(photo2);

            String imageDirectory = "/images/";
            String path1 = imageDirectory + "blog_author/" + authorImg;
            String path2 = imageDirectory + "blog/" + blogImg;

            String filename1 = request.getServletContext().getRealPath(path1);
            String filename2 = request.getServletContext().getRealPath(path2);

            String realFileName1 = filename1;
            String realFileName2 = filename2;
            
            if (filename1.contains("\\build")) {
                realFileName1 = filename1.replace("\\build", "");
            }

            if (filename2.contains("\\build")) {
                realFileName2 = filename2.replace("\\build", "");
            }

            if (photo1.getSize() > 0) {
                photo1.write(realFileName1);
            }

            if (photo2.getSize() > 0) {
                photo2.write(realFileName2);
            }

            String SCategoryID = request.getParameter("categoryId");
            String BlogAuthor = request.getParameter("author");
            String BlogTitle = request.getParameter("title");
            String BlogContent = request.getParameter("content");
            String SHiddenStatus = request.getParameter("hidden");
            int CategoryID = Integer.parseInt(SCategoryID);
            int HiddenStatus = Integer.parseInt(SHiddenStatus);

            dao.addBlog(BlogAuthor, CategoryID, authorImg, blogImg, BlogTitle, BlogContent, HiddenStatus);
            try {
                Thread.sleep(5000);
            } catch (InterruptedException ex) {
                Logger.getLogger(ControllerAddPost.class.getName()).log(Level.SEVERE, null, ex);
            }

            response.sendRedirect("marketingPost");
        }

    }

    private String getSubmittedFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return null;
    }

    private String removeBuildPath(String filename) {
        return filename.replace("\\build", "");
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
