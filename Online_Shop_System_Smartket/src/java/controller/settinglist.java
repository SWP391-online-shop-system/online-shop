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
import jakarta.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.util.Vector;
import java.util.logging.Logger;
import model.DAOSetting;
import model.DAOUser;
import view.Setting;
import view.User;

/**
 *
 * @author trant
 */
@WebServlet(name = "settinglist", urlPatterns = {"/settinglist"})
public class settinglist extends HttpServlet {

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
            HttpSession session = request.getSession();
            String service = request.getParameter("service");
            DAOSetting dao = new DAOSetting();
            String message = "";
            if (service == null) {
                service = "showList";
            }
            if (service.equals("showList")) {
                Vector<Setting> list = dao.getSetting("SELECT * FROM online_shop_system.setting");
                String status = "3";
                String type = "0";
                request.setAttribute("status", status);
                request.setAttribute("type", type);
                request.setAttribute("listsetting", list);
                request.getRequestDispatcher("settinglist.jsp").forward(request, response);
            }
            if (service.equals("addsetting")) {
                String SettingName = request.getParameter("settingname1");
                int SettingOrder = Integer.parseInt(request.getParameter("settingorder1"));
                String SettingValue = request.getParameter("settingvalue1");
                String SettingDescription = request.getParameter("settingdes1");;
                Setting newsetting = new Setting(SettingName, SettingOrder, SettingValue, SettingDescription, 1);
                int n = dao.addNewUserByMKT(newsetting);
                if (n > 0) {
                    message = "Thêm thành công";
                }
                session.setAttribute("message", message);
                response.sendRedirect("settinglist");
            }
            if (service.equals("fillter")) {
                String status = request.getParameter("status");
                String type = request.getParameter("type");
                String sql = "SELECT * FROM online_shop_system.setting ";
                // String status = "3";
                //String role = "0";
                //String gender = "0";
//                if(status.equals("3")&&role.equals("0")&&gender.equals("0")){
//                Vector<User> list = dao.getUser(sql);
//                request.setAttribute("data", list);
//                request.setAttribute("status", status);
//                request.setAttribute("role", role);
//                request.setAttribute("gender", gender);
//                request.getRequestDispatcher("userlist.jsp").forward(request, response);  
//                }

//                if(status.equals("3")&&gender.equals("0")){
//                    if(role.equals("0"))
                if (type.equals("0")) {
                    sql = sql;
                } else 
                    sql = sql + " where SettingName = " + type;
                if (status.equals("3")) {
                    sql = sql;
                } else {
                    if (sql.contains("where")) {
                        sql = sql + " and SettingStatus = " + status;
                    } else {
                        sql = sql + " where SettingStatus = " + status;
                    }
                }
               
                Vector<Setting> list = dao.getSetting(sql);
//                request.setAttribute("data", list);
//                request.setAttribute("status", status);
//                request.setAttribute("role", role);
//                request.setAttribute("gender", gender);
//                request.getRequestDispatcher("userlist.jsp").forward(request, response);  
//                }
                request.setAttribute("sql", sql);
                request.setAttribute("listsetting", list);
                request.setAttribute("status", status);
                request.setAttribute("type", type);
                request.getRequestDispatcher("settinglist.jsp").forward(request, response);
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
