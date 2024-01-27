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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
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
        try {
            DAOProduct dao = new DAOProduct();
            DAOCategories daoCate = new DAOCategories();
            String service = request.getParameter("service");
            double minValue;
            double maxValue;
            String maxValue_raw = request.getParameter("inputMaxPrice");
            String minValue_raw = request.getParameter("inputMinPrice");
            if (maxValue_raw == null) {
                maxValue = dao.getMaxUnitPrice();
            } else {
                maxValue = Double.parseDouble(maxValue_raw);
            }
            if (minValue_raw == null) {
                minValue = dao.getMinUnitPrice();
            } else {
                minValue = Double.parseDouble(minValue_raw);

            }
            System.out.println("in svlet: minValue = " + minValue + " and MaxValue =" + maxValue);
            String CategoryID_raw = request.getParameter("CategoryID");
            String filterChoice = request.getParameter("filterChoice");
            if (filterChoice == null) {
                filterChoice = "createDate desc";
            }
            if (service == null) {
                if (CategoryID_raw == null || CategoryID_raw.equals("")) {
                    service = "ShowAllProduct";
                } else {
                    service = "ShowCategory";
                }
            }
            System.out.println("service = " + service);
            System.out.println("fil = " + filterChoice);
            //Start get All product----------------------------------------------------------------
            if (service.equals("ShowAllProduct")) {
                String index_raw = request.getParameter("index");
                int index = 1;
                if (index_raw != null) {
                    index = Integer.parseInt(index_raw);
                }
                //paging
                int count = dao.getTotalProduct(minValue, maxValue);
                int endPage = count / 9;
                if (count % 9 != 0) {
                    endPage++;
                }
                request.setAttribute("endPage", endPage);

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
                        + "and p.UnitPrice between " + minValue + " and " + maxValue + " order by " + filterChoice + " limit 9 offset " + ((index - 1) * 9));
                request.setAttribute("rsPaging", rsPaging);
                System.out.println("index in et = " + index);
                request.setAttribute("index", index);
            }
            // End get All Product----------------------------------------------------------------

            //Start get Product from CategoryID
            if (service.equals("ShowCategory")) {
                String index_raw = request.getParameter("index");
                int index = 1;
                if (index_raw != null) {
                    index = Integer.parseInt(index_raw);
                }
                if (filterChoice.equals("createDate asc") || filterChoice.equals("p.CreateDate asc")) {
                    filterChoice = "p.CreateDate asc";
                    //paging
                    int CategoryID = Integer.parseInt(CategoryID_raw);
                    Categories cateName = daoCate.getCategoriesById(CategoryID);
                    request.setAttribute("catename", cateName);
                    int count = dao.getTotalProductByCateID(CategoryID, minValue, maxValue);
                    int endPage = count / 9;
                    if (count % 9 != 0) {
                        endPage++;
                    }
                    request.setAttribute("endPage", endPage);
                    ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                            + "and p.CategoryID = " + CategoryID + " order by " + filterChoice + " limit 9 offset " + ((index - 1) * 9));
                    request.setAttribute("rsPaging", rsPaging);
                    request.setAttribute("index", index);
                }
                if (filterChoice.equals("createDate desc") || filterChoice.equals("p.CreateDate desc")) {
                    filterChoice = "p.CreateDate desc";
                    int CategoryID = Integer.parseInt(CategoryID_raw);
                    Categories cateName = daoCate.getCategoriesById(CategoryID);
                    request.setAttribute("catename", cateName);
                    int count = dao.getTotalProductByCateID(CategoryID, minValue, maxValue);
                    int endPage = count / 9;
                    if (count % 9 != 0) {
                        endPage++;
                    }
                    request.setAttribute("endPage", endPage);
                    ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                            + "and p.CategoryID = " + CategoryID + " order by " + filterChoice + " limit 9 offset " + ((index - 1) * 9));
                    request.setAttribute("rsPaging", rsPaging);
                    request.setAttribute("index", index);
                }
                if (filterChoice.equals("priceasc") || filterChoice.equals("(UnitPrice*(100-UnitDiscount)/100) asc")) {
                    filterChoice = "(UnitPrice*(100-UnitDiscount)/100) asc";
                    int CategoryID = Integer.parseInt(CategoryID_raw);
                    Categories cateName = daoCate.getCategoriesById(CategoryID);
                    request.setAttribute("catename", cateName);
                    int count = dao.getTotalProductByCateID(CategoryID, minValue, maxValue);
                    int endPage = count / 9;
                    if (count % 9 != 0) {
                        endPage++;
                    }
                    request.setAttribute("endPage", endPage);
                    ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                            + "and p.CategoryID = " + CategoryID + " order by " + filterChoice + " limit 9 offset " + ((index - 1) * 9));
                    request.setAttribute("rsPaging", rsPaging);
                    request.setAttribute("index", index);
                }
                if (filterChoice.equals("pricedesc") || filterChoice.equals("(UnitPrice*(100-UnitDiscount)/100) desc")) {
                    filterChoice = "(UnitPrice*(100-UnitDiscount)/100) desc";
                    int CategoryID = Integer.parseInt(CategoryID_raw);
                    Categories cateName = daoCate.getCategoriesById(CategoryID);
                    request.setAttribute("catename", cateName);
                    int count = dao.getTotalProductByCateID(CategoryID, minValue, maxValue);
                    int endPage = count / 9;
                    if (count % 9 != 0) {
                        endPage++;
                    }
                    request.setAttribute("endPage", endPage);
                    ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                            + "and p.CategoryID = " + CategoryID + " order by " + filterChoice + " limit 9 offset " + ((index - 1) * 9));
                    request.setAttribute("rsPaging", rsPaging);
                    request.setAttribute("index", index);
                }

            }

            if (service.equals("filter")) {
                if (filterChoice == null) {
                    filterChoice = "createDate desc";
                }
                System.out.println("in filer: categoryID = " + CategoryID_raw);
                //orderDate giam dan
                if (filterChoice.equals("createDate asc") || filterChoice.equals("p.CreateDate asc")) {
                    filterChoice = "p.CreateDate asc";
                    String index_raw = request.getParameter("index");
                    int index = 1;
                    if (index_raw != null) {
                        index = Integer.parseInt(index_raw);
                    }
                    if (CategoryID_raw == null || CategoryID_raw.equals("")) {
                        //paging
                        int count = dao.getTotalProduct(minValue, maxValue);
                        int endPage = count / 9;
                        if (count % 9 != 0) {
                            endPage++;
                        }
                        request.setAttribute("endPage", endPage);
                        ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                                + "and p.UnitPrice between " + minValue + " and " + maxValue + " order by " + filterChoice + " limit 9 offset " + ((index - 1) * 9));
                        request.setAttribute("rsPaging", rsPaging);
                        request.setAttribute("index", index);
                    } else {
                        //paging
                        int categoryID = Integer.parseInt(CategoryID_raw);
                        int count = dao.getTotalProductByCateID(categoryID, minValue, maxValue);
                        int endPage = count / 9;
                        if (count % 9 != 0) {
                            endPage++;
                        }
                        request.setAttribute("endPage", endPage);
                        ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                                + "and p.UnitPrice between " + minValue + " and " + maxValue + " and p.CategoryID = " + categoryID + " order by " + filterChoice + " limit 9 offset " + ((index - 1) * 9));
                        request.setAttribute("rsPaging", rsPaging);
                        request.setAttribute("index", index);
                    }

                }
                //orderDate tang dan
                if (filterChoice.equals("createDate desc") || filterChoice.equals("p.CreateDate desc")) {
                    filterChoice = "p.CreateDate desc";
                    String index_raw = request.getParameter("index");
                    int index = 1;
                    if (index_raw != null) {
                        index = Integer.parseInt(index_raw);
                    }
                    //paging
                    if (CategoryID_raw == null || CategoryID_raw.equals("")) {
                        int count = dao.getTotalProduct(minValue, maxValue);
                        int endPage = count / 9;
                        if (count % 9 != 0) {
                            endPage++;
                        }
                        request.setAttribute("endPage", endPage);
                        ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                                + "and p.UnitPrice between " + minValue + " and " + maxValue + " order by " + filterChoice + " limit 9 offset " + ((index - 1) * 9));
                        request.setAttribute("rsPaging", rsPaging);
                        request.setAttribute("index", index);
                    } else {
                        //paging
                        System.out.println("in paging of filter createDate desc");
                        int categoryID = Integer.parseInt(CategoryID_raw);
                        int count = dao.getTotalProductByCateID(categoryID, minValue, maxValue);
                        int endPage = count / 9;
                        if (count % 9 != 0) {
                            endPage++;
                        }
                        request.setAttribute("endPage", endPage);
                        ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                                + "and p.UnitPrice between " + minValue + " and " + maxValue + " and p.CategoryID= " + categoryID + " order by " + filterChoice + " limit 9 offset " + ((index - 1) * 9));
                        request.setAttribute("rsPaging", rsPaging);
                        request.setAttribute("index", index);
                    }

                }
                //UnitPrice giam dan
                if (filterChoice.equals("priceasc") || filterChoice.equals("(UnitPrice*(100-UnitDiscount)/100) asc")) {
                    String index_raw = request.getParameter("index");
                    int index = 1;
                    if (index_raw != null) {
                        index = Integer.parseInt(index_raw);
                    }
                    if (CategoryID_raw == null || CategoryID_raw.equals("")) {
                        //paging
                        int count = dao.getTotalProduct(minValue, maxValue);
                        int endPage = count / 9;
                        if (count % 9 != 0) {
                            endPage++;
                        }
                        request.setAttribute("endPage", endPage);
                        ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                                + "and p.UnitPrice between " + minValue + " and " + maxValue + " order by (UnitPrice*(100-UnitDiscount)/100) asc limit 9 offset " + ((index - 1) * 9));
                        request.setAttribute("rsPaging", rsPaging);
                        request.setAttribute("index", index);
                    } else {
                        //paging
                        int categoryID = Integer.parseInt(CategoryID_raw);
                        int count = dao.getTotalProductByCateID(categoryID, minValue, maxValue);
                        int endPage = count / 9;
                        if (count % 9 != 0) {
                            endPage++;
                        }
                        request.setAttribute("endPage", endPage);
                        ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                                + "and p.UnitPrice between " + minValue + " and " + maxValue + " and p.CategoryID= " + CategoryID_raw + " order by (UnitPrice*(100-UnitDiscount)/100) asc limit 9 offset " + ((index - 1) * 9));
                        request.setAttribute("rsPaging", rsPaging);
                        request.setAttribute("index", index);
                    }

                }
                //UnitPrice tang dan
                if (filterChoice.equals("pricedesc") || filterChoice.equals("UnitPrice*(100-UnitDiscount)/100) asc")) {
                    String index_raw = request.getParameter("index");
                    int index = 1;
                    if (index_raw != null) {
                        index = Integer.parseInt(index_raw);
                    }
                    if (CategoryID_raw == null || CategoryID_raw.equals("")) {
                        //paging
                        int count = dao.getTotalProduct(minValue, maxValue);
                        int endPage = count / 9;
                        if (count % 9 != 0) {
                            endPage++;
                        }
                        request.setAttribute("endPage", endPage);
                        System.out.println("in categoryID = null of pricedesc");
                        ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                                + "and p.UnitPrice between " + minValue + " and " + maxValue + " order by(UnitPrice*(100-UnitDiscount)/100) desc limit 9 offset " + ((index - 1) * 9));
                        request.setAttribute("rsPaging", rsPaging);
                        request.setAttribute("index", index);
                    } else {
                        //paging
                        int categoryID = Integer.parseInt(CategoryID_raw);
                        int count = dao.getTotalProductByCateID(categoryID, minValue, maxValue);
                        int endPage = count / 9;
                        if (count % 9 != 0) {
                            endPage++;
                        }
                        request.setAttribute("endPage", endPage);
                        System.out.println("in categoryID != null of pricedesc");
                        ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                                + "and p.UnitPrice between " + minValue + " and " + maxValue + " and p.CategoryID= " + CategoryID_raw + " order by(UnitPrice*(100-UnitDiscount)/100) desc limit 9 offset " + ((index - 1) * 9));
                        request.setAttribute("rsPaging", rsPaging);
                        request.setAttribute("index", index);
                    }

                }
                request.setAttribute("filterChoice", filterChoice);
            }

            if (service.equals("price")) {
                String index_raw = request.getParameter("index");
                System.out.println("filter chocie in here = " + filterChoice);
                int index = 1;
                if (index_raw != null) {
                    index = Integer.parseInt(index_raw);
                }
                if (filterChoice.equals("createDate asc") || filterChoice.equals("p.CreateDate asc")) {
                    filterChoice = "p.CreateDate asc";
                    //paging
                    if (CategoryID_raw == null || CategoryID_raw.equals("")) {
                        int count = dao.getTotalProductByPrice(minValue, maxValue);
                        int endPage = count / 9;
                        if (count % 9 != 0) {
                            endPage++;
                        }
                        request.setAttribute("endPage", endPage);
                        ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                                + "and p.UnitPrice between " + minValue + " and " + maxValue + " order by " + filterChoice + " limit 9 offset " + ((index - 1) * 9));
                        request.setAttribute("rsPaging", rsPaging);
                        request.setAttribute("index", index);
                    } else {
                        int CategoryID = Integer.parseInt(CategoryID_raw);
                        int count = dao.getTotalProductByCateID(CategoryID, minValue, maxValue);
                        int endPage = count / 9;
                        if (count % 9 != 0) {
                            endPage++;
                        }
                        request.setAttribute("endPage", endPage);
                        ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                                + "and p.CategoryID = " + CategoryID + " and p.UnitPrice between " + minValue + " and " + maxValue + " order by " + filterChoice + " limit 9 offset " + ((index - 1) * 9));
                        request.setAttribute("rsPaging", rsPaging);
                        request.setAttribute("index", index);
                    }

                }
                if (filterChoice.equals("createDate desc") || filterChoice.equals("p.CreateDate desc")) {
                    filterChoice = "p.CreateDate desc";
                    if (CategoryID_raw == null || CategoryID_raw.equals("")) {
                        int count = dao.getTotalProductByPrice(minValue, maxValue);
                        int endPage = count / 9;
                        if (count % 9 != 0) {
                            endPage++;
                        }
                        request.setAttribute("endPage", endPage);
                        ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                                + "and p.UnitPrice between " + minValue + " and " + maxValue + " order by " + filterChoice + " limit 9 offset " + ((index - 1) * 9));
                        request.setAttribute("rsPaging", rsPaging);
                        request.setAttribute("index", index);
                    } else {
                        int CategoryID = Integer.parseInt(CategoryID_raw);
                        int count = dao.getTotalProductByCateID(CategoryID, minValue, maxValue);
                        int endPage = count / 9;
                        if (count % 9 != 0) {
                            endPage++;
                        }
                        request.setAttribute("endPage", endPage);
                        ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                                + "and p.CategoryID = " + CategoryID + " and p.UnitPrice between " + minValue + " and " + maxValue + " order by " + filterChoice + " limit 9 offset " + ((index - 1) * 9));
                        request.setAttribute("rsPaging", rsPaging);
                        request.setAttribute("index", index);
                    }

                }
                if (filterChoice.equals("priceasc") || filterChoice.equals("(UnitPrice*(100-UnitDiscount)/100) asc")) {
                    filterChoice = "(UnitPrice*(100-UnitDiscount)/100) asc";
                    if (CategoryID_raw == null || CategoryID_raw.equals("")) {
                        int count = dao.getTotalProductByPrice(minValue, maxValue);
                        int endPage = count / 9;
                        if (count % 9 != 0) {
                            endPage++;
                        }
                        request.setAttribute("endPage", endPage);
                        ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                                + "and p.UnitPrice between " + minValue + " and " + maxValue + " order by " + filterChoice + " limit 9 offset " + ((index - 1) * 9));
                        request.setAttribute("rsPaging", rsPaging);
                        request.setAttribute("index", index);
                    } else {
                        int CategoryID = Integer.parseInt(CategoryID_raw);
                        int count = dao.getTotalProductByCateID(CategoryID, minValue, maxValue);
                        int endPage = count / 9;
                        if (count % 9 != 0) {
                            endPage++;
                        }
                        request.setAttribute("endPage", endPage);
                        ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                                + "and p.CategoryID = " + CategoryID + " and p.UnitPrice between " + minValue + " and " + maxValue + " order by " + filterChoice + " limit 9 offset " + ((index - 1) * 9));
                        request.setAttribute("rsPaging", rsPaging);
                        request.setAttribute("index", index);
                    }

                }
                if (filterChoice.equals("pricedesc") || filterChoice.equals("(UnitPrice*(100-UnitDiscount)/100) desc")) {
                    filterChoice = "(UnitPrice*(100-UnitDiscount)/100) desc";
                    if (CategoryID_raw == null || CategoryID_raw.equals("")) {
                        int count = dao.getTotalProductByPrice(minValue, maxValue);
                        int endPage = count / 9;
                        if (count % 9 != 0) {
                            endPage++;
                        }
                        request.setAttribute("endPage", endPage);
                        ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                                + "and p.UnitPrice between " + minValue + " and " + maxValue + " order by " + filterChoice + " limit 9 offset " + ((index - 1) * 9));
                        request.setAttribute("rsPaging", rsPaging);
                        request.setAttribute("index", index);
                    } else {
                        int CategoryID = Integer.parseInt(CategoryID_raw);
                        int count = dao.getTotalProductByCateID(CategoryID, minValue, maxValue);
                        int endPage = count / 9;
                        if (count % 9 != 0) {
                            endPage++;
                        }
                        request.setAttribute("endPage", endPage);
                        ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID where pi.ProductURL like '%_1%' \n"
                                + "and p.CategoryID = " + CategoryID + " and p.UnitPrice between " + minValue + " and " + maxValue + " order by " + filterChoice + " limit 9 offset " + ((index - 1) * 9));
                        request.setAttribute("rsPaging", rsPaging);
                        request.setAttribute("index", index);
                    }
                }
            }
            if (service.equals("highestRate")) {

            }
            request.setAttribute("oldMaxPrice", maxValue);
            request.setAttribute("oldMinPrice", minValue);
            //End get Product from CategoryID-------------------------------------------------------
            //Startget All category----------------------------------------------------------------
            ResultSet rsCategory = dao.getData("Select * from Categories");
            request.setAttribute("CategoryResult", rsCategory);
            //End get All Category----------------------------------------------------------------
            ResultSet rsMax = dao.getData("select * from Product order by (UnitPrice*(100-UnitDiscount)/100) desc limit 1");
            ResultSet rsMin = dao.getData("select * from Product order by (UnitPrice*(100-UnitDiscount)/100) asc limit 1");
            Double maxPrice = 0.0;
            Double minPrice = 0.0;
            if (rsMax.next() && rsMin.next()) {
                maxPrice = rsMax.getDouble(6);
                minPrice = rsMin.getDouble(6);
            }
            System.out.println("in servlet: maxPrice = " + maxPrice + " and minPrice = " + minPrice);
            request.setAttribute("maxPrice", maxPrice);
            request.setAttribute("minPrice", minPrice);
            request.setAttribute("filterChoice", filterChoice);
            request.setAttribute("categoryID", CategoryID_raw);
            request.getRequestDispatcher("productList.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ControllerProductList.class.getName()).log(Level.SEVERE, null, ex);
        }
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
