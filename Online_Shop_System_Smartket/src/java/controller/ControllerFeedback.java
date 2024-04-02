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
import java.io.File;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DAOFeedBack;
import model.DAOOrderDetails;
import model.DAOProduct;
import view.User;

/**
 *
 * @author admin
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
@WebServlet(name = "ControllerFeedback", urlPatterns = {"/feedback"})
public class ControllerFeedback extends HttpServlet {

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
        DAOFeedBack dao = new DAOFeedBack();
        DAOProduct daoP = new DAOProduct();
        DAOOrderDetails DAODetail = new DAOOrderDetails();
        double maxValue = daoP.getMaxUnitPrice();
        double minValue = daoP.getMinUnitPrice();
        request.setAttribute("inputMinPrice", minValue);
        request.setAttribute("inputMaxPrice", maxValue);
        ResultSet rsCategory = daoP.getData("Select * from Categories");
        request.setAttribute("CategoryResult", rsCategory);
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        int isFeedBack = 0;
        if (user == null) {
            response.sendRedirect("HomePageURL");
        } else {
            String ordID = request.getParameter("orderID");
            request.setAttribute("ordID", ordID);
            String service = request.getParameter("service");
            String pID = request.getParameter("ProductID");
            int ProductID = Integer.parseInt(pID);
            try {
                ResultSet rsDetail = dao.getData("select * from OrderDetail as detail "
                        + "join `Order` as ord on detail.OrderID = ord.OrderID where UserID = " + user.getUserID() + " and ProductID =" + ProductID + " and ord.orderID=" + ordID);
                if (rsDetail.next()) {
                    isFeedBack = rsDetail.getInt("isFeedBack");
                    if (rsDetail.getInt("isFeedBack") == 1) {
                        request.getRequestDispatcher("ProductDetailURL?ProductID=" + ProductID).forward(request, response);
                    }
                }
            } catch (SQLException ex) {
                Logger.getLogger(ControllerFeedback.class.getName()).log(Level.SEVERE, null, ex);
            }

            if (service.equals("gofeedback")) {
                ResultSet rsProduct = daoP.getData("select * from product as p\n"
                        + " JOIN productimage as i ON p.ProductID = i.ProductID where p.ProductID = " + pID + " and i.ProductURL=i.ProductURLShow;");
                request.setAttribute("rsProduct", rsProduct);
                request.getRequestDispatcher("feedback.jsp").forward(request, response);
            }

            if (service.equals("upload")) {
                if (isFeedBack == 0) {
                    String st_OrderID = request.getParameter("ordID");
                    int OrderID = Integer.parseInt(st_OrderID);
                    Part photo1 = request.getPart("feedbackImg");
                    String feedbackImg = getSubmittedFileName(photo1);
                    System.out.println("215615415165165" + feedbackImg);
                    String imageDirectory = "/images/";
                    String path1 = imageDirectory + "feedback/" + feedbackImg;
                    String filename1 = request.getServletContext().getRealPath(path1);
                    String realFileName1 = filename1;
                    System.out.println("215615415165165" + realFileName1);
                    if (filename1.contains("\\build")) {
                        realFileName1 = filename1.replace("\\build", "");
                    }
                    if (photo1.getSize() > 0) {
                        photo1.write(realFileName1);
                    }
                    String msgFeedback = request.getParameter("msg");
                    String SRate = request.getParameter("rating3");
                    if (SRate == null) {
                        SRate = "1";
                    }
                    int rate = Integer.parseInt(SRate);
                    int UserID = user.getUserID();
                    dao.addFeedback(ProductID, UserID, feedbackImg, msgFeedback, rate);
                    DAODetail.updateIsFeedBack(OrderID, ProductID, 1);
                }
                try {
                    Thread.sleep(3500);
                } catch (InterruptedException ex) {
                    Logger.getLogger(ControllerAddPost.class.getName()).log(Level.SEVERE, null, ex);
                }
                response.sendRedirect("ProductDetailURL?ProductID=" + ProductID);
            }
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
