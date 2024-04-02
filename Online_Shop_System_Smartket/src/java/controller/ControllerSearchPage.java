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
        try {
            DAOProduct dao = new DAOProduct();
            DAOCategories daoCate = new DAOCategories();
            String filterChoice = request.getParameter("filterChoice");
            String TotalRate_raw = request.getParameter("TotalRate");
            String CategoryID = request.getParameter("CategoryID");
            int TotalRate = 0;
            String type = request.getParameter("type");
            String keyWord = request.getParameter("keyWord");
            if (keyWord == null || keyWord.equals("")) {
                keyWord = "";
            }
            if (filterChoice == null) {
                filterChoice = "createDate desc";
            }
            double minValue;
            double maxValue;
            String maxValue_raw = request.getParameter("inputMaxPrice");
            String minValue_raw = request.getParameter("inputMinPrice");
            if (maxValue_raw == null) {
                maxValue = dao.getMaxUnitPriceSearch(keyWord);
            } else {
                maxValue = Double.parseDouble(maxValue_raw);
            }
            if (minValue_raw == null) {
                minValue = dao.getMinUnitPriceSearch(keyWord);
            } else {
                minValue = Double.parseDouble(minValue_raw);
            }
            //Start get All product----------------------------------------------------------------
            request.setAttribute("filterChoice", filterChoice);
            if (filterChoice.equals("createDate desc") || filterChoice.equals("p.CreateDate desc")) {
                filterChoice = "p.CreateDate desc";
                if (TotalRate_raw == null || TotalRate_raw.equals("")) {
                    if (type == null || type.equals("")) {
                        if (CategoryID == null || CategoryID.equals("")) {
                            System.out.println("1");
                            String index_raw = request.getParameter("index");
                            int index = 1;
                            if (index_raw != null) {
                                index = Integer.parseInt(index_raw);
                            }
                            int count = dao.getTotalProductBySearch(keyWord, minValue, maxValue);
                            int endPage = count / 12;
                            if (count % 12 != 0) {
                                endPage++;
                            }
                            request.setAttribute("endPage", endPage);
                            ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where pi.ProductURL = pi.ProductURLShow and p.ProductStatus = 0 and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                    + " and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like N'%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                            request.setAttribute("rsPaging", rsPaging);
                            request.setAttribute("index", index);
                        } else {
                            System.out.println("2");
                            String index_raw = request.getParameter("index");
                            int index = 1;
                            if (index_raw != null) {
                                index = Integer.parseInt(index_raw);
                            }
                            int count = dao.getTotalProductBySearchCategory(keyWord, Integer.parseInt(CategoryID), minValue, maxValue);
                            int endPage = count / 12;
                            if (count % 12 != 0) {
                                endPage++;
                            }
                            request.setAttribute("endPage", endPage);
                            ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                    + "and c.CategoryID = " + CategoryID + " and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like N'%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12)
                            );
                            System.out.println("sql = select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                    + " and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like N'%" + keyWord + "%'and c.CategoryID = " + CategoryID + " order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12)
                            );
                            request.setAttribute("rsPaging", rsPaging);
                            request.setAttribute("index", index);
                        }
                    } else {
                        if (type.equals("showSale")) {
                            System.out.println("3");
                            if (CategoryID == null || CategoryID.equals("")) {
                                String index_raw = request.getParameter("index");
                                int index = 1;
                                if (index_raw != null) {
                                    index = Integer.parseInt(index_raw);
                                }
                                int count = dao.getTotalProductByTypeSearch(keyWord, type, minValue, maxValue);
                                int endPage = count / 12;
                                if (count % 12 != 0) {
                                    endPage++;
                                }
                                request.setAttribute("endPage", endPage);
                                ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                        + "and p.UnitDiscount != 0 and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like %'" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                                request.setAttribute("rsPaging", rsPaging);
                                request.setAttribute("index", index);
                            } else {
                                System.out.println("4");
                                String index_raw = request.getParameter("index");
                                int index = 1;
                                if (index_raw != null) {
                                    index = Integer.parseInt(index_raw);
                                }
                                int count = dao.getTotalProductByTypeSearchCategory(keyWord, Integer.parseInt(CategoryID), type, minValue, maxValue);
                                int endPage = count / 12;
                                if (count % 12 != 0) {
                                    endPage++;
                                }
                                request.setAttribute("endPage", endPage);
                                ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                        + "and c.CategoryID = " + CategoryID + "and p.UnitDiscount != 0 and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like %'" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12)
                                );
                                request.setAttribute("rsPaging", rsPaging);
                                request.setAttribute("index", index);
                            }
                        }
                    }
                } else {
                    TotalRate = Integer.parseInt(TotalRate_raw);
                    String resultRate = "";
                    if (TotalRate == 0) {
                        resultRate = "and p.TotalRate between 0 and 5 ";
                    } else {
                        resultRate = "and p.TotalRate =" + TotalRate + " ";
                    }
                    if (type == null || type.equals("")) {
                        System.out.println("5");
                        if (CategoryID == null || CategoryID.equals("")) {
                            String index_raw = request.getParameter("index");
                            int index = 1;
                            if (index_raw != null) {
                                index = Integer.parseInt(index_raw);
                            }
                            int count = dao.getTotalProductByRateSearch(keyWord, TotalRate, minValue, maxValue);
                            int endPage = count / 12;
                            if (count % 12 != 0) {
                                endPage++;
                            }
                            request.setAttribute("endPage", endPage);
                            ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                    + resultRate + " and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                            request.setAttribute("rsPaging", rsPaging);
                            System.out.println("sql 5 = select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                    + resultRate + " and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                            request.setAttribute("index", index);
                        } else {
                            String index_raw = request.getParameter("index");
                            int index = 1;
                            if (index_raw != null) {
                                index = Integer.parseInt(index_raw);
                            }
                            int count = dao.getTotalProductByRateSearchCategory(keyWord, Integer.parseInt(CategoryID), TotalRate, minValue, maxValue);
                            int endPage = count / 12;
                            if (count % 12 != 0) {
                                endPage++;
                            }
                            request.setAttribute("endPage", endPage);
                            ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and c.CategoryID =" + CategoryID + " and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                    + resultRate + "and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));

                            request.setAttribute("rsPaging", rsPaging);
                            request.setAttribute("index", index);
                        }
                    } else {
                        if (type.equals("showSale")) {
                            if (CategoryID == null || CategoryID.equals("")) {
                                System.out.println("7");
                                String index_raw = request.getParameter("index");
                                int index = 1;
                                if (index_raw != null) {
                                    index = Integer.parseInt(index_raw);
                                }
                                int count = dao.getTotalTypeAndRateProduct(type, TotalRate, minValue, maxValue);
                                int endPage = count / 12;
                                if (count % 12 != 0) {
                                    endPage++;
                                }
                                request.setAttribute("endPage", endPage);
                                ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.UnitPrice between " + minValue + " and " + maxValue + " and pi.ProductURL like '%_1%'\n"
                                        + resultRate + " and p.UnitDiscount != 0 and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                                request.setAttribute("rsPaging", rsPaging);
                                request.setAttribute("index", index);
                            } else {
                                System.out.println("8");
                                String index_raw = request.getParameter("index");
                                int index = 1;
                                if (index_raw != null) {
                                    index = Integer.parseInt(index_raw);
                                }
                                int count = dao.getTotalTypeAndRateProductCategory(type, Integer.parseInt(CategoryID), TotalRate, minValue, maxValue);
                                int endPage = count / 12;
                                if (count % 12 != 0) {
                                    endPage++;
                                }
                                ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and c.CategoryID = " + CategoryID + " \n"
                                        + resultRate + " and p.UnitPrice between " + minValue + " and " + maxValue + " and p.UnitDiscount != 0 and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                                request.setAttribute("endPage", endPage);
                                request.setAttribute("rsPaging", rsPaging);
                                request.setAttribute("index", index);
                            }
                        }
                    }
                }
            }
            if (filterChoice.equals("createDate asc") || filterChoice.equals("p.CreateDate asc")) {
                filterChoice = "p.CreateDate asc";
                if (TotalRate_raw == null || TotalRate_raw.equals("")) {
                    if (type == null || type.equals("")) {
                        if (CategoryID == null || CategoryID.equals("")) {
                            String index_raw = request.getParameter("index");
                            int index = 1;
                            if (index_raw != null) {
                                index = Integer.parseInt(index_raw);
                            }
                            int count = dao.getTotalProductBySearch(keyWord, minValue, maxValue);
                            int endPage = count / 12;
                            if (count % 12 != 0) {
                                endPage++;
                            }
                            request.setAttribute("endPage", endPage);
                            ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID  join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                    + "and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                            request.setAttribute("rsPaging", rsPaging);
                            request.setAttribute("index", index);
                        } else {
                            String index_raw = request.getParameter("index");
                            int index = 1;
                            if (index_raw != null) {
                                index = Integer.parseInt(index_raw);
                            }
                            int count = dao.getTotalProductBySearchCategory(keyWord, Integer.parseInt(CategoryID), minValue, maxValue
                            );
                            int endPage = count / 12;
                            if (count % 12 != 0) {
                                endPage++;
                            }
                            request.setAttribute("endPage", endPage);
                            ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID  join Categories as c on p.CategoryID = c.Category IDwhere p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and c.CategoryID = " + CategoryID + "\n"
                                    + "and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                            request.setAttribute("rsPaging", rsPaging);
                            request.setAttribute("index", index);
                        }
                    } else {
                        if (type.equals("showSale")) {
                            if (CategoryID == null || CategoryID.equals("")) {
                                String index_raw = request.getParameter("index");
                                int index = 1;
                                if (index_raw != null) {
                                    index = Integer.parseInt(index_raw);
                                }
                                int count = dao.getTotalProductByTypeSearch(keyWord, type, minValue, maxValue);
                                int endPage = count / 12;
                                if (count % 12 != 0) {
                                    endPage++;
                                }
                                request.setAttribute("endPage", endPage);
                                ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                        + "and p.UnitDiscount != 0 and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                                request.setAttribute("rsPaging", rsPaging);
                                request.setAttribute("index", index);
                            } else {
                                String index_raw = request.getParameter("index");
                                int index = 1;
                                if (index_raw != null) {
                                    index = Integer.parseInt(index_raw);
                                }
                                int count = dao.getTotalProductByTypeSearchCategory(keyWord, Integer.parseInt(CategoryID), type, minValue, maxValue);
                                int endPage = count / 12;
                                if (count % 12 != 0) {
                                    endPage++;
                                }
                                request.setAttribute("endPage", endPage);
                                ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and c.CategoryID = " + CategoryID + "\n"
                                        + "and p.UnitDiscount != 0 and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                                request.setAttribute("rsPaging", rsPaging);
                                request.setAttribute("index", index);
                            }
                        }
                    }
                } else {
                    TotalRate = Integer.parseInt(TotalRate_raw);
                    String resultRate = "";
                    if (TotalRate == 0) {
                        resultRate = "and p.TotalRate between 0 and 5 ";
                    } else {
                        resultRate = "and p.TotalRate =" + TotalRate + " ";
                    }
                    if (type == null || type.equals("")) {
                        if (CategoryID == null || CategoryID.equals("")) {
                            String index_raw = request.getParameter("index");
                            int index = 1;
                            if (index_raw != null) {
                                index = Integer.parseInt(index_raw);
                            }
                            int count = dao.getTotalProductByRateSearch(keyWord, TotalRate, minValue, maxValue);
                            int endPage = count / 12;
                            if (count % 12 != 0) {
                                endPage++;
                            }
                            request.setAttribute("endPage", endPage);
                            ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                    + resultRate + "and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                            request.setAttribute("rsPaging", rsPaging);
                            request.setAttribute("index", index);
                        } else {
                            String index_raw = request.getParameter("index");
                            int index = 1;
                            if (index_raw != null) {
                                index = Integer.parseInt(index_raw);
                            }
                            int count = dao.getTotalProductByRateSearchCategory(keyWord, Integer.parseInt(CategoryID), TotalRate, minValue, maxValue);
                            int endPage = count / 12;
                            if (count % 12 != 0) {
                                endPage++;
                            }
                            request.setAttribute("endPage", endPage);
                            ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and c.CategoryID = " + CategoryID + "\n"
                                    + resultRate + "and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                            request.setAttribute("rsPaging", rsPaging);
                            request.setAttribute("index", index);
                        }
                    } else {
                        if (type.equals("showSale")) {
                            if (CategoryID == null || CategoryID.equals("")) {
                                String index_raw = request.getParameter("index");
                                int index = 1;
                                if (index_raw != null) {
                                    index = Integer.parseInt(index_raw);
                                }
                                int count = dao.getTotalProductByRateAndTypeSearch(keyWord, TotalRate, type, minValue, maxValue);
                                int endPage = count / 12;
                                if (count % 12 != 0) {
                                    endPage++;
                                }
                                request.setAttribute("endPage", endPage);
                                ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                        + resultRate + "and p.UnitDiscount != 0 and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                                request.setAttribute("rsPaging", rsPaging);
                                request.setAttribute("index", index);
                            } else {
                                String index_raw = request.getParameter("index");
                                int index = 1;
                                if (index_raw != null) {
                                    index = Integer.parseInt(index_raw);
                                }
                                int count = dao.getTotalProductByRateAndTypeSearchCategory(keyWord, Integer.parseInt(CategoryID), TotalRate, type, minValue, maxValue);
                                int endPage = count / 12;
                                if (count % 12 != 0) {
                                    endPage++;
                                }
                                request.setAttribute("endPage", endPage);
                                ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and c.CategoryID = " + CategoryID + " \n"
                                        + resultRate + "and p.UnitDiscount != 0 and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                                request.setAttribute("rsPaging", rsPaging);
                                request.setAttribute("index", index);
                            }
                        }
                    }
                }
            }
            if (filterChoice.equals("priceasc") || filterChoice.equals("(UnitPrice*(100-UnitDiscount)/100) asc")) {
                filterChoice = "(UnitPrice*(100-UnitDiscount)/100) asc";
                if (TotalRate_raw == null || TotalRate_raw.equals("")) {
                    if (type == null || type.equals("")) {
                        if (CategoryID == null || CategoryID.equals("")) {
                            String index_raw = request.getParameter("index");
                            int index = 1;
                            if (index_raw != null) {
                                index = Integer.parseInt(index_raw);
                            }
                            int count = dao.getTotalProductBySearch(keyWord, minValue, maxValue);
                            int endPage = count / 12;
                            if (count % 12 != 0) {
                                endPage++;
                            }
                            request.setAttribute("endPage", endPage);
                            ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                    + "and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                            request.setAttribute("rsPaging", rsPaging);
                            request.setAttribute("index", index);
                        } else {
                            String index_raw = request.getParameter("index");
                            int index = 1;
                            if (index_raw != null) {
                                index = Integer.parseInt(index_raw);
                            }
                            int count = dao.getTotalProductBySearchCategory(keyWord, Integer.parseInt(CategoryID), minValue, maxValue);
                            int endPage = count / 12;
                            if (count % 12 != 0) {
                                endPage++;
                            }
                            request.setAttribute("endPage", endPage);
                            ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and c.CategoryID =" + CategoryID + "\n"
                                    + "and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                            request.setAttribute("rsPaging", rsPaging);
                            request.setAttribute("index", index);
                        }
                    } else {
                        if (type.equals("showSale")) {
                            if (CategoryID == null || CategoryID.equals("")) {
                                String index_raw = request.getParameter("index");
                                int index = 1;
                                if (index_raw != null) {
                                    index = Integer.parseInt(index_raw);
                                }
                                int count = dao.getTotalProductByTypeSearch(keyWord, type, minValue, maxValue);
                                int endPage = count / 12;
                                if (count % 12 != 0) {
                                    endPage++;
                                }
                                request.setAttribute("endPage", endPage);
                                ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                        + "and p.UnitDiscount != 0 and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                                request.setAttribute("rsPaging", rsPaging);
                                request.setAttribute("index", index);
                            } else {
                                String index_raw = request.getParameter("index");
                                int index = 1;
                                if (index_raw != null) {
                                    index = Integer.parseInt(index_raw);
                                }
                                int count = dao.getTotalProductByTypeSearchCategory(keyWord, Integer.parseInt(CategoryID), type, minValue, maxValue);
                                int endPage = count / 12;
                                if (count % 12 != 0) {
                                    endPage++;
                                }
                                request.setAttribute("endPage", endPage);
                                ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and c.CategoryID = " + CategoryID + " \n"
                                        + "and p.UnitDiscount != 0 and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                                request.setAttribute("rsPaging", rsPaging);
                                request.setAttribute("index", index);
                            }
                        }
                    }
                } else {
                    TotalRate = Integer.parseInt(TotalRate_raw);
                    String resultRate = "";
                    if (TotalRate == 0) {
                        resultRate = "and p.TotalRate between 0 and 5 ";
                    } else {
                        resultRate = "and p.TotalRate =" + TotalRate + " ";
                    }
                    if (type == null || type.equals("")) {
                        if (CategoryID == null || CategoryID.equals("")) {
                            String index_raw = request.getParameter("index");
                            int index = 1;
                            if (index_raw != null) {
                                index = Integer.parseInt(index_raw);
                            }
                            int count = dao.getTotalProductByRateSearch(keyWord, TotalRate, minValue, maxValue);
                            int endPage = count / 12;
                            if (count % 12 != 0) {
                                endPage++;
                            }
                            request.setAttribute("endPage", endPage);
                            ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                    + resultRate + "and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                            request.setAttribute("rsPaging", rsPaging);
                            request.setAttribute("index", index);
                        } else {
                            String index_raw = request.getParameter("index");
                            int index = 1;
                            if (index_raw != null) {
                                index = Integer.parseInt(index_raw);
                            }
                            int count = dao.getTotalProductByRateSearchCategory(keyWord, Integer.parseInt(CategoryID), TotalRate, minValue, maxValue);
                            int endPage = count / 12;
                            if (count % 12 != 0) {
                                endPage++;
                            }
                            request.setAttribute("endPage", endPage);
                            ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and c.CategoryID = " + CategoryID + " \n"
                                    + ""
                                    + resultRate + "and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                            request.setAttribute("rsPaging", rsPaging);
                            request.setAttribute("index", index);
                        }

                    } else {
                        if (type.equals("showSale")) {
                            if (CategoryID == null || CategoryID.equals("")) {
                                String index_raw = request.getParameter("index");
                                int index = 1;
                                if (index_raw != null) {
                                    index = Integer.parseInt(index_raw);
                                }
                                int count = dao.getTotalProductByRateAndTypeSearch(keyWord, TotalRate, type, minValue, maxValue);
                                int endPage = count / 12;
                                if (count % 12 != 0) {
                                    endPage++;
                                }
                                request.setAttribute("endPage", endPage);
                                ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                        + resultRate + "and p.UnitDiscount != 0 and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                                request.setAttribute("rsPaging", rsPaging);
                                request.setAttribute("index", index);
                            } else {
                                String index_raw = request.getParameter("index");
                                int index = 1;
                                if (index_raw != null) {
                                    index = Integer.parseInt(index_raw);
                                }
                                int count = dao.getTotalProductByRateAndTypeSearchCategory(keyWord, Integer.parseInt(CategoryID), TotalRate, type, minValue, maxValue);
                                int endPage = count / 12;
                                if (count % 12 != 0) {
                                    endPage++;
                                }
                                request.setAttribute("endPage", endPage);
                                ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and c.CategoryID = " + CategoryID + " \n"
                                        + resultRate + "and p.UnitDiscount != 0 and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                                request.setAttribute("rsPaging", rsPaging);
                                request.setAttribute("index", index);
                            }
                        }
                    }
                }
            }
            if (filterChoice.equals("pricedesc") || filterChoice.equals("(UnitPrice*(100-UnitDiscount)/100) desc")) {
                filterChoice = "(UnitPrice*(100-UnitDiscount)/100) desc";
                if (TotalRate_raw == null || TotalRate_raw.equals("")) {
                    if (type == null || type.equals("")) {
                        if (CategoryID == null || CategoryID.equals("")) {
                            String index_raw = request.getParameter("index");
                            int index = 1;
                            if (index_raw != null) {
                                index = Integer.parseInt(index_raw);
                            }
                            int count = dao.getTotalProductBySearch(keyWord, minValue, maxValue);
                            int endPage = count / 12;
                            if (count % 12 != 0) {
                                endPage++;
                            }
                            request.setAttribute("endPage", endPage);
                            ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                    + " and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                            request.setAttribute("rsPaging", rsPaging);
                            request.setAttribute("index", index);
                        } else {
                            String index_raw = request.getParameter("index");
                            int index = 1;
                            if (index_raw != null) {
                                index = Integer.parseInt(index_raw);
                            }
                            int count = dao.getTotalProductBySearchCategory(keyWord, Integer.parseInt(CategoryID), minValue, maxValue);
                            int endPage = count / 12;
                            if (count % 12 != 0) {
                                endPage++;
                            }
                            request.setAttribute("endPage", endPage);
                            ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and c.CategoryID = " + CategoryID + "  \n"
                                    + " and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                            request.setAttribute("rsPaging", rsPaging);
                            request.setAttribute("index", index);
                        }

                    } else {
                        if (type.equals("showSale")) {
                            if (CategoryID == null || CategoryID.equals("")) {
                                String index_raw = request.getParameter("index");
                                int index = 1;
                                if (index_raw != null) {
                                    index = Integer.parseInt(index_raw);
                                }
                                int count = dao.getTotalProductByTypeSearch(keyWord, type, minValue, maxValue);
                                int endPage = count / 12;
                                if (count % 12 != 0) {
                                    endPage++;
                                }
                                request.setAttribute("endPage", endPage);
                                ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                        + "and p.UnitDiscount != 0 and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                                request.setAttribute("rsPaging", rsPaging);
                                request.setAttribute("index", index);
                            } else {
                                String index_raw = request.getParameter("index");
                                int index = 1;
                                if (index_raw != null) {
                                    index = Integer.parseInt(index_raw);
                                }
                                int count = dao.getTotalProductByTypeSearchCategory(keyWord, Integer.parseInt(CategoryID), type, minValue, maxValue);
                                int endPage = count / 12;
                                if (count % 12 != 0) {
                                    endPage++;
                                }
                                request.setAttribute("endPage", endPage);
                                ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and c.CategoryID = " + CategoryID + " \n"
                                        + "and p.UnitDiscount != 0 and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                                request.setAttribute("rsPaging", rsPaging);
                                request.setAttribute("index", index);
                            }
                        }
                    }
                } else {
                    TotalRate = Integer.parseInt(TotalRate_raw);
                    String resultRate = "";
                    if (TotalRate == 0) {
                        resultRate = "and p.TotalRate between 0 and 5 ";
                    } else {
                        resultRate = "and p.TotalRate =" + TotalRate + " ";
                    }
                    if (type == null || type.equals("")) {
                        if (CategoryID == null || CategoryID.equals("")) {
                            String index_raw = request.getParameter("index");
                            int index = 1;
                            if (index_raw != null) {
                                index = Integer.parseInt(index_raw);
                            }
                            int count = dao.getTotalProductByRateSearch(keyWord, TotalRate, minValue, maxValue);
                            int endPage = count / 12;
                            if (count % 12 != 0) {
                                endPage++;
                            }
                            request.setAttribute("endPage", endPage);
                            ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                    + resultRate + "and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                            request.setAttribute("rsPaging", rsPaging);
                            request.setAttribute("index", index);

                        } else {
                            String index_raw = request.getParameter("index");
                            int index = 1;
                            if (index_raw != null) {
                                index = Integer.parseInt(index_raw);
                            }
                            int count = dao.getTotalProductByRateSearchCategory(keyWord, Integer.parseInt(CategoryID), TotalRate, minValue, maxValue);
                            int endPage = count / 12;
                            if (count % 12 != 0) {
                                endPage++;
                            }
                            request.setAttribute("endPage", endPage);
                            ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and c.CategoryID = " + CategoryID + " \n"
                                    + resultRate + "and p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                            request.setAttribute("rsPaging", rsPaging);
                            request.setAttribute("index", index);
                        }
                    } else {
                        if (type.equals("showSale")) {
                            if (CategoryID == null || CategoryID.equals("")) {
                                String index_raw = request.getParameter("index");
                                int index = 1;
                                if (index_raw != null) {
                                    index = Integer.parseInt(index_raw);
                                }
                                int count = dao.getTotalProductByRateAndTypeSearch(keyWord, TotalRate, type, minValue, maxValue);
                                int endPage = count / 12;
                                if (count % 12 != 0) {
                                    endPage++;
                                }
                                request.setAttribute("endPage", endPage);
                                ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and p.UnitPrice between " + minValue + " and " + maxValue + " \n"
                                        + resultRate + "and p.ProductName like N'%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                                request.setAttribute("rsPaging", rsPaging);
                                request.setAttribute("index", index);
                            } else {
                                String index_raw = request.getParameter("index");
                                int index = 1;
                                if (index_raw != null) {
                                    index = Integer.parseInt(index_raw);
                                }
                                int count = dao.getTotalProductByRateAndTypeSearchCategory(keyWord, Integer.parseInt(CategoryID), TotalRate, type, minValue, maxValue);
                                int endPage = count / 12;
                                if (count % 12 != 0) {
                                    endPage++;
                                }
                                request.setAttribute("endPage", endPage);
                                ResultSet rsPaging = dao.getData("select * from product as p join ProductImage as pi on p.ProductID = pi.ProductID join Categories as c on p.CategoryID = c.CategoryID where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow and c.CategoryID = " + CategoryID + " \n"
                                        + resultRate + "and p.ProductName like N'%" + keyWord + "%' order by " + filterChoice + " limit 12 offset " + ((index - 1) * 12));
                                request.setAttribute("rsPaging", rsPaging);
                                request.setAttribute("index", index);
                            }
                        }
                    }
                }
            }
            //Startget All category----------------------------------------------------------------
            ResultSet rsCategory = dao.getData("Select * from Categories");
            request.setAttribute("CategoryResult", rsCategory);
            Double maxPrice = 0.0;
            Double minPrice = 0.0;
            ResultSet rsMax = dao.getData("select UnitPrice from Product as p join Categories as c on p.CategoryID = c.CategoryID where p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by (p.UnitPrice*(100-p.UnitDiscount)/100) desc limit 1");
            ResultSet rsMin = dao.getData("select UnitPrice from Product as p join Categories as c on p.CategoryID = c.CategoryID where p.ProductName like N'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by (p.UnitPrice*(100-p.UnitDiscount)/100) asc limit 1");
            if (rsMax.next() && rsMin.next()) {
                maxPrice = rsMax.getDouble("UnitPrice");
                minPrice = rsMin.getDouble("UnitPrice");
            }
            request.setAttribute("minPrice", minPrice);
            request.setAttribute("maxPrice", maxPrice);
            request.setAttribute("oldMinPrice", minValue);
            request.setAttribute("oldMaxPrice", maxValue);
            //End get All Category----------------------------------------------------------------
            request.setAttribute("keyWord", keyWord);
            request.setAttribute("type", type);
            request.setAttribute("TotalRate", TotalRate_raw);
            request.setAttribute("categoryID", CategoryID);
            request.getRequestDispatcher("searchPage.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ControllerSearchPage.class.getName()).log(Level.SEVERE, null, ex);
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
