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
import jakarta.servlet.http.HttpSession;
import java.sql.ResultSet;
import model.DAOAddressUser;
import model.DAOCart;
import model.DAOProduct;
import view.AddressUser;
import view.User;
/**
 *
 * @author trant
 */
@WebServlet(name = "ControllerCartContact", urlPatterns = {"/contactURL"})
public class ControllerCartContact extends HttpServlet {

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
            String[] productId = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("productCookie")) {
                        String arrayAsString = cookie.getValue();
                        productId = arrayAsString.split("\\.");
                        break;
                    }
                }
            }
            HttpSession session = request.getSession();
            String service = request.getParameter("service");
            User user = (User) session.getAttribute("account");
            int userID = user.getUserID();
            DAOCart dao = new DAOCart();
            DAOProduct daoPro = new DAOProduct();
            double maxValue = daoPro.getMaxUnitPrice();
            double minValue = daoPro.getMinUnitPrice();
            request.setAttribute("inputMinPrice", minValue);
            request.setAttribute("inputMaxPrice", maxValue);
            ResultSet rsCategory = daoPro.getData("Select * from Categories");
            request.setAttribute("CategoryResult", rsCategory);
            String message = (String) request.getAttribute("message");
            if (message == null) {
                message = "";
            }
            if (service == null) {
                service = "showContact";
            }
            if (service.equals("showContact")) {
                ResultSet rs = dao.getData("SELECT * FROM Cart AS c JOIN Product AS p ON c.ProductID = p.ProductID\n"
                        + "join ProductImage as pi on p.ProductID = pi.ProductID\n"
                        + "where c.UserID = " + userID + " and pi.ProductURL like '%_1%';");
                request.setAttribute("data", rs);
                ResultSet rsAddress = dao.getData("SELECT * FROM online_shop_system.addressuser where UserID = " + userID + ";");
                ResultSet rsDefaultAdd = dao.getData("SELECT * FROM online_shop_system.addressuser where UserID = " + userID + " and `Status` = 1;");
                request.setAttribute("rsAddress", rsAddress);
                request.setAttribute("rsDefaultAdd", rsDefaultAdd);
                request.setAttribute("productToBuy", productId);
                request.setAttribute("message", message);
                request.getRequestDispatcher("cartcontact.jsp").forward(request, response);
            }
            if (service.equals("addAddress")) {
                String name = request.getParameter("name");
                String phone = request.getParameter("phone");
                String email = request.getParameter("email");
                String city = request.getParameter("city");
                String district = request.getParameter("district");
                String ward = request.getParameter("ward");
                String gender_str = request.getParameter("gender");
                String addressDetail = request.getParameter("addressDetail");
                String cityDistrictWard = city + " , " + district + " , " + ward;
                boolean gender = gender_str.equals("male");
                AddressUser add = new AddressUser(userID, name, cityDistrictWard, addressDetail, phone, email, gender);
                DAOAddressUser daoAdd = new DAOAddressUser();
                int lastAddID = daoAdd.insertAddressByPrepared(add);
                out.print("<div class=\"card\" style=\"margin: 0;    width: 100%;\">\n"
                        + "    <div class=\"p-3 card-child\">\n"
                        + "        <div class=\"d-flex flex-row align-items-center new-content\" >\n"
                        + "            <i><img src=\"images/logo/iconLocation.png\" alt=\"\" style=\"width: 30px;height: 26px;\"/></i>\n"
                        + "            <div class=\"d-flex flex-column ms-3\" style=\"flex:1\">\n"
                        + "                <h6 class=\"fw-bold\">Người nhận: " + name + "&nbsp;|&nbsp;" + (gender ? "Nam" : "Nữ") + "\n"
                        + "                    </h6>\n"
                        + "                <span>\n"
                        + "                    Số điện thoại: " + phone + " <br/>\n"
                        + "                    Email: " + email + " <br/>\n"
                        + "                    Địa chỉ: " + cityDistrictWard + " <br/>\n"
                        + "                    " + addressDetail + "\n"
                        + "                </span>\n"
                        + "            </div>\n"
                        + "            <div class=\"\">\n"
                        + "                <a href=\"#\" data-bs-target=\"#update\" data-bs-toggle=\"modal\" data-bs-dismiss=\"modal\">Chỉnh sửa</a><br/>\n"
                        + "                <span>Đặt mặc định<input type=\"radio\" value=" + lastAddID++ + " name=\"addId\"/></span>\n"
                        + "            </div>\n"
                        + "        </div>\n"
                        + "    </div>\n"
                        + "</div>");
            }
            if (service.equals("saveAdd")) {
                String id_raw = request.getParameter("addId");
                int id = Integer.parseInt(id_raw);
                DAOAddressUser daoAdd = new DAOAddressUser();
                daoAdd.clearStatus(userID);
                daoAdd.updateStatus(id);
                response.sendRedirect("contactURL");
            }
            if (service.equals("showOneAdd")) {
                String id_str = request.getParameter("addId");
                int id = Integer.parseInt(id_str);
                ResultSet rsOneAdd = dao.getData("SELECT * FROM online_shop_system.addressuser where AddressID = " + id + ";");
                request.setAttribute("rsOneAdd", rsOneAdd);
                response.getWriter().write("ajax in");
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
