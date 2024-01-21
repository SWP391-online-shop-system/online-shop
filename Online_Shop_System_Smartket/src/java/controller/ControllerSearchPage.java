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
import model.DAOProduct;

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
        String keyWord = request.getParameter("keyWord");
        if (keyWord.isEmpty()) {
            keyWord = "";
        }
        DAOProduct dao = new DAOProduct();
        ResultSet rsSearchResult = dao.getData("select * from product as p join productImage as pi "
                + "on p.ProductID = pi.ProductID "
                + "where p.ProductName like N'%" + keyWord + "%' and pi.ProductURL like '%_1%';");
        request.setAttribute("result", rsSearchResult);

        //paging
        String CategoryID_raw = request.getParameter("CategoeyID");
        int CategoryID = 0;
        if (CategoryID_raw != null) {
            CategoryID = Integer.parseInt("CategoryID_raw");
        }
        String index_raw = request.getParameter("index");
        int index = 1;
        if (index_raw != null) {
            index = Integer.parseInt(index_raw);
        }
        int count = dao.getTotalProductByCateID(CategoryID);
        int endPage = count / 9;
        if (count % 9 != 0) {
            endPage++;
        }
        request.setAttribute("endPage", endPage);
        //get product by CategoryId
//        Vector<Product> listProduct = dao.get6NextByCateId(index, CategoryID);

        ResultSet rsPaging = dao.getData("SELECT * FROM Product as p join ProductImage as pi "
                + "on p.ProductID = pi.ProductID\n"
                + "where pi.ProductURL like '%_1%' ORDER BY p.ProductID asc \n"
                + "limit" + CategoryID_raw + "offset 0");
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
