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
import java.util.Vector;
import model.DAOCategories;
import model.DAOProduct;
import view.Categories;
import view.Product;

/**
 *
 * @author admin
 */
@WebServlet(name = "ControllerProductList", urlPatterns = {"/ProductListURL"})
public class ControllerProductList extends HttpServlet {

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
            out.println("<title>Servlet ControllerProductList</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControllerProductList at " + request.getContextPath() + "</h1>");
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
        DAOProduct dao = new DAOProduct();
        String service = request.getParameter("service");
        String CategoryID_raw = request.getParameter("CategoryID");
        System.out.println("Category_raw = " + CategoryID_raw);
        if (CategoryID_raw == null || CategoryID_raw.equals("")|| service==null) {
            service = "ShowAllProduct";
        } else {
            service = "ShowCategory";
        }
        //Start get All product----------------------------------------------------------------
        if (service.equals("ShowAllProduct")) {
            System.out.println("service = " + service);
            String index_raw = request.getParameter("index");
            int index = 1;
            if (index_raw != null) {
                index = Integer.parseInt(index_raw);
            }
            //paging
            int count = dao.getTotalProduct();
            int endPage = count / 9;
            if (count % 9 != 0) {
                endPage++;
            }
            request.setAttribute("endPage", endPage);
            Vector<Product> list = dao.get9Next(index);
            request.setAttribute("listPage", list);
        }
        // End get All Product----------------------------------------------------------------

        //Start get Product from CategoryID
        if (service.equals("ShowCategory")) {
            System.out.println("service = " + service);
            DAOCategories daoCate = new DAOCategories();
            String index_raw = request.getParameter("index");
            int index = 1;
            if (index_raw != null) {
                index = Integer.parseInt(index_raw);
                System.out.println("index = " + index);
            }
            //paging
            int CategoryID = Integer.parseInt(CategoryID_raw);
            System.out.println("CategoryID = " + CategoryID);
            Categories cateName = daoCate.getCategoriesById(CategoryID);
            request.setAttribute("catename", cateName);
            int count = dao.getTotalProductByCateID(CategoryID);
            System.out.println("count= " + count);
            int endPage = count / 9;
            if (count % 9 != 0) {
                endPage++;
            }
            request.setAttribute("endPage", endPage);
            Vector<Product> list = dao.get9NextByCateId(index, CategoryID);
            request.setAttribute("listPage", list);
        }
        //End get Product from CategoryID-------------------------------------------------------
        //Startget All category----------------------------------------------------------------
        ResultSet rsCategory = dao.getData("Select * from Categories");

        request.setAttribute(
                "CategoryResult", rsCategory);
        //End get All Category----------------------------------------------------------------

        //Start Paging
        //End Paging
        request.getRequestDispatcher(
                "productList.jsp").forward(request, response);
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
