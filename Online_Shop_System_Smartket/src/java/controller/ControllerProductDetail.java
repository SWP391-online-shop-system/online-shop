package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import model.DAOProduct;
import view.Product;

/**
 *
 * @author admin
 */
@WebServlet(name = "ControllerProductDetail", urlPatterns = {"/ProductDetailURL"})
public class ControllerProductDetail extends HttpServlet {

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
        System.out.println("Ajax in");
        DAOProduct daoPro = new DAOProduct();
        int ProductID = Integer.parseInt(request.getParameter("ProductID"));
        Product p = daoPro.getProductById(ProductID);
        ResultSet rsFeedBack;
        String filterValue = request.getParameter("filterValue");
        System.out.println("filterValue = " + filterValue);
        ResultSet rsDetail = daoPro.getData("select * from Product as p join ProductImage as pi on p.ProductID = pi.ProductID "
                + "where p.ProductID = " + ProductID);
        ResultSet rsRate = daoPro.getData("SELECT p.ProductID, COALESCE(avg(fb.FeedBackRate), 3) AS AverageFeedbackRate, count(fb.ProductID) as timeRateCount, count(fb.UserID) as userRateCount\n"
                + "FROM Product p\n"
                + "LEFT JOIN FeedBack fb ON p.ProductID = fb.ProductID where p.ProductID = " + ProductID + " \n"
                + "GROUP BY p.ProductID");
        if (filterValue == null) {
            filterValue = "";
            rsFeedBack = daoPro.getData("select u.UserImage, (CONCAT(u.FirstName,\" \",u.LastName))as UserName,\n"
                    + "fb.FeedBackRate,fb.FeedBackImage, fb.FeedBackContent, fb.FeedBackDate \n"
                    + "from User as u join FeedBack as fb on u.UserID = fb.UserID where fb.FeedBackStatus = 0 and fb.ProductID= " + ProductID + " order by fb.FeedBackDate;");
        } else {
            rsFeedBack = daoPro.getData("select u.UserImage, (CONCAT(u.FirstName,\" \",u.LastName))as UserName,\n"
                    + "fb.FeedBackRate,fb.FeedBackImage, fb.FeedBackContent, fb.FeedBackDate \n"
                    + "from User as u join FeedBack as fb on u.UserID = fb.UserID where fb.FeedBackStatus = 0 and fb.ProductID= " + ProductID + " and fb.FeedBackRate = " + filterValue + " order by fb.FeedBackDate;");
        }
        request.setAttribute("rsDetail", rsDetail);
        request.setAttribute("rsRate", rsRate);
        request.setAttribute("rsFeedBack", rsFeedBack);
        double maxValue = daoPro.getMaxUnitPrice();
        double minValue = daoPro.getMinUnitPrice();
        request.setAttribute("inputMinPrice", minValue);
        request.setAttribute("inputMaxPrice", maxValue);
        ResultSet rsCategory = daoPro.getData("Select * from Categories");
        request.setAttribute("CategoryResult", rsCategory);
        request.getRequestDispatcher("productDetail.jsp").forward(request, response);
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
