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
@WebServlet(name = "searchPageURL", urlPatterns = {"/searchPageURL"})
public class ControllerSearchPage extends HttpServlet {

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
            out.println("<title>Servlet searchPageURL</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet searchPageURL at " + request.getContextPath() + "</h1>");
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
        DAOCategories daoCate = new DAOCategories();
        String filterChoice = request.getParameter("filterChoice");
        String keyWord = request.getParameter("keyWord");
        if (keyWord == null || keyWord.equals("")) {
            keyWord = "";
        }
        if (filterChoice == null) {
            filterChoice = "createDate asc";
        }
        System.out.println("fil = " + filterChoice);
        System.out.println("keyWord = " + keyWord);
        //Start get All product----------------------------------------------------------------
        String index_raw = request.getParameter("index");
        int index = 1;
        if (index_raw != null) {
            index = Integer.parseInt(index_raw);
        }
        //paging
        int count = dao.getTotalProductBySearch(keyWord);
        int endPage = count / 9;
        if (count % 9 != 0) {
            endPage++;
        }
        request.setAttribute("endPage", endPage);
        request.setAttribute("filterChoice", filterChoice);
        if (filterChoice.equals("priceasc") || filterChoice.equals("(UnitPrice*(100-UnitDiscount)/100) asc")) {
            filterChoice = "(UnitPrice*(100-UnitDiscount)/100) asc";
        }
        if (filterChoice.equals("pricedesc") || filterChoice.equals("(UnitPrice*(100-UnitDiscount)/100) desc")) {
            filterChoice = "(UnitPrice*(100-UnitDiscount)/100) desc";
        }
        if (filterChoice.equals("createDate asc") || filterChoice.equals("p.CreateDate asc")) {
            filterChoice = "p.CreateDate asc";
        }
        if (filterChoice.equals("createDate desc") || filterChoice.equals("p.CreateDate desc")) {
            filterChoice = "p.CreateDate desc";
        }
        ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                + " and ProductName like '%" + keyWord + "%'order by " + filterChoice + " limit 9 offset " + ((index - 1) * 9)
        );
        request.setAttribute("rsPaging", rsPaging);
        request.setAttribute("index", index);
        //Startget All category----------------------------------------------------------------
        ResultSet rsCategory = dao.getData("Select * from Categories");

        request.setAttribute("CategoryResult", rsCategory);
        //End get All Category----------------------------------------------------------------

        //Start Paging
        //End Paging
        request.setAttribute("keyWord", keyWord);
        request.getRequestDispatcher("searchPage.jsp").forward(request, response);
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
