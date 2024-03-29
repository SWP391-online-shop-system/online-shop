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
import java.sql.SQLException;
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
            System.out.println("ajax in controller");
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
            System.out.println("service " + service);
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
                        + "                <a onclick=\"showOneAdd(this)\"\n" +
"                                                       data-bs-toggle=\"modal\" \n" +
"                                                       data-bs-dismiss=\"modal\" style=\"cursor: pointer;padding: 0\">Chỉnh sửa</a><br/>\n"
                        + "                <span>Đặt mặc định<input type=\"radio\" class=\"defaultAdd\" value=" + lastAddID++ + " name=\"addId\"/></span>\n"
                                +"<br/><a style=\"cursor: pointer;padding: 0\" onclick=\"deleteAdd(this)\"><i class=\"fa fa-trash\"></i> Xóa</a>\n"
                        + "            </div>\n"
                        + "        </div>\n"
                        + "    </div>\n"
                        + "</div>");
            }
            if (service.equals("saveAdd")) {
                String id_raw = request.getParameter("addId");
                int id = Integer.parseInt(id_raw);
                System.out.println("id: " + id);
                DAOAddressUser daoAdd = new DAOAddressUser();
                daoAdd.clearStatus(userID);
                daoAdd.updateStatus(id);
                response.sendRedirect("contactURL");
            }
            if (service.equals("showOneAdd")) {
                String id_str = request.getParameter("addId");
                int id = Integer.parseInt(id_str);
                String result = "";
                String result1 = "";
                String result2 = "";
                String result3 = "";
                ResultSet rsOneAdd = dao.getData("SELECT * FROM online_shop_system.addressuser where AddressID = " + id + ";");
                try {
                    while (rsOneAdd.next()) {
                        String CityDistrictWard = rsOneAdd.getString("CityDistrictWard");
                        String[] parts = CityDistrictWard.split(", ");
                        String city = parts[0];
                        String district = parts[1];
                        String ward = parts[2];
                        String name = rsOneAdd.getString("Name");
                        result1 = "<input type=\"hidden\" id=\"addIdUpdate\" value=" + rsOneAdd.getInt("AddressID") + " />"
                                + "                                    <div class=\"form-group\">\n"
                                + "                                        <label>Tên người nhận</label>\n"
                                + "                                        <input name=\"name\" type=\"text\" value=\""+name+"\" required class=\"form-control\" id=\"updateName\"\n"
                                + "                                               >\n"
                                + "                                    </div>\n"
                                + "                                    <div class=\"form-group\">\n"
                                + "                                        <label>Số điện thoại người nhận</label>\n"
                                + "                                        <input name=\"phone\" type=\"number\" value=" + rsOneAdd.getString("Phone") + " required class=\"form-control\" id=\"updatePhone\" placeholder=\"Nhập số điện thoại...\">\n"
                                + "                                    </div>\n"
                                + "                                    <div class=\"form-group\">\n"
                                + "                                        <label>Email</label>\n"
                                + "                                        <input name=\"email\" value=" + rsOneAdd.getString("Email") + " required class=\"form-control\" id=\"updateEmail\" placeholder=\"Nhập email...\">\n"
                                + "                                    </div>\n"
                                + "                                    <div class=\"form-element\" style=\"display: flex;\">\n"
                                + "                                        <label>Giới tính</label>\n"
                                + "                                        <div style=\"display:flex; flex: 40%; margin-left: 11px\">\n"
                                + "                                            <div class=\"custom-control custom-radio\" style=\"margin-right: 15px;\">\n"
                                + "                                                <input type=\"radio\" id=\"updateMale\" name=\"updategender\" class=\"custom-control-input\" value=\"male\" required";
                        result2 = "                                        <label class=\"custom-control-label\" for=\"updateMale\">Nam</label>\n"
                                + "                                            </div>\n"
                                + "                                            <div class=\"custom-control custom-radio\">\n"
                                + "                                                <input type=\"radio\" id=\"updateFeMale\" name=\"updategender\" class=\"custom-control-input\" value=\"female\" required";
                        result3 = "                                                <label class=\"custom-control-label\" for=\"updateFeMale\">Nữ</label>\n"
                                + "                                            </div>\n"
                                + "                                        </div>\n"
                                + "                                    </div>\n"
                                + "                                    <div class=\"form-group\">\n"
                                + "                                        <label>Địa Chỉ Người Nhận\n"
                                + "                                        </label><br/>\n"
                                + "                                        <select name=\"city\" id=\"city1\"  style=\"width: 31%;\" required>\n"
                                + "                                            <option  selected>" + city + "</option>           \n"
                                + "                                        </select>\n"
                                + "                                        <select name=\"district\" id=\"district1\"  style=\"width: 31%;\" required>\n"
                                + "                                            <option  selected>" + district + "</option>\n"
                                + "                                        </select>\n"
                                + "                                        <select name=\"ward\" id=\"ward1\"  style=\"width: 31%\" required>\n"
                                + "                                            <option  selected>" + ward + "</option>\n"
                                + "                                        </select>\n"
                                + "                                    </div>\n"
                                + "                                    <div class=\"form-group\">\n"
                                + "                                        <label>Địa chỉ cụ thể (số nhà, tên đường)</label>\n"
                                + "                                        <textarea name=\"addressdetail\"  required class=\"form-control\" id=\"updateAddressDetail\">" + rsOneAdd.getString("AddDetail") + "</textarea>\n"
                                + "                                    </div>\n"
                                + "                                </div> ";
                        if (rsOneAdd.getInt("Gender") == 1) {
                            result1 += " checked >";
                        } else {
                            result2 += " checked >";
                        }
                        result = result1 + result2 + result3;
                    }
                    rsOneAdd.close();
                } catch (SQLException e) {
                }
                out.print(result);
            }
            if (service.equals("updateAdd")) {
                String id_str = request.getParameter("addId");
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
                int id = Integer.parseInt(id_str);
                AddressUser add = new AddressUser(id, userID, name, cityDistrictWard, addressDetail, phone, email, gender);
                DAOAddressUser daoAdd = new DAOAddressUser();
                int n =daoAdd.updateAdd(add);
                System.out.println("n:" + n);
            }
            if(service.equals("deleteAdd")){
                String id_str = request.getParameter("addId");
                int id = Integer.parseInt(id_str);
                DAOAddressUser daoAdd = new DAOAddressUser();
                daoAdd.deleteAdd(id);
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
