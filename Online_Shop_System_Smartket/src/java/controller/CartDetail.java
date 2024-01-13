/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Arrays;

/**
 *
 * @author trant
 */
@WebServlet(name = "CartDetail", urlPatterns = {"/cart"})
public class CartDetail extends HttpServlet {

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
//            response.sendRedirect("cartdetail.jsp");
            String service = request.getParameter("service");
            if (service == null) {
                service = "showcart";
            }
            if (service.equals("showcart")) {
                response.sendRedirect("cartdetail.jsp");
            }
            if (service.equals("addcart")) {
                String proid = request.getParameter("proid");
                String quantity_raw = request.getParameter("quantity");
                int quantity = Integer.parseInt(quantity_raw);
                // Lấy giỏ hàng từ cookie
                String cartItems = "";
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("cartItems")) {
                            cartItems = cookie.getValue();
                            break;
                        }
                    }
                }

                // Xử lý thông tin giỏ hàng
                // Định dạng có thể là một chuỗi được phân cách (ví dụ: productId1:2,productId2:1)
                // Bạn có thể tìm kiếm và cập nhật sản phẩm tương ứng.
                // Thêm hoặc cập nhật sản phẩm trong giỏ hàng
//                if (!cartItems.contains(proid)) {
//                    cartItems += proid + ":" + quantity + "_";
//                } else {
//                    // Cập nhật số lượng nếu sản phẩm đã tồn tại
//                    String[] items = cartItems.split("_");
//                    for (int i = 0; i < items.length; i++) {
//                        if (items[i].startsWith(proid)) {
//                            String[] parts = items[i].split(":");
//                            int newQuantity = Integer.parseInt(parts[1]) + quantity;
//                            items[i] = proid + ":" + newQuantity +"_";
//                            break;
//                        }
//                    }
//                    cartItems = String.join("_", items);
//                }
                String[] items = cartItems.split("_");
                boolean found = false;
                for (int i = 0; i < items.length; i++) {
                    if (items[i].startsWith(proid)) {
                        String[] parts = items[i].split(":");
                        int newQuantity = Integer.parseInt(parts[1]) + quantity;
                        items[i] = proid + ":" + newQuantity;
                        found = true;
                        break;
                    }
                }

                if (!found) {
                    items = Arrays.copyOf(items, items.length + 1);
                    items[items.length - 1] = proid + ":" + quantity + "_";
                }

// Nối mảng thành chuỗi
                cartItems = String.join("_", items);

                // Lưu thông tin giỏ hàng vào cookie
                Cookie cartCookie = new Cookie("cartItems", cartItems);
                cartCookie.setMaxAge(30 * 24 * 60 * 60); // Cookie tồn tại trong 30 ngày
                response.addCookie(cartCookie);
                response.sendRedirect("cartdetail.jsp");
            }

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
