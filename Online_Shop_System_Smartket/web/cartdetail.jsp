<%-- 
    Document   : cartdetail
    Created on : Jan 10, 2024, 11:49:22 PM
    Author     : trant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page import="java.util.Vector,java.sql.SQLException,java.sql.ResultSet" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="view.Categories" %>
<%@page import="model.DAOCategories" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/cartstyle.css"/>
        <link rel="stylesheet" href="css/css_header/header.css"/>
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <title>Giỏ Hàng</title>
    </head>
    <body>
        <%
           ResultSet rs = (ResultSet)request.getAttribute("data");
           String message ="";
           DecimalFormat decimalFormat = new DecimalFormat("#,###.#");
           double totalprice = 0;
        %>
        <div id="body">
            <jsp:include page="include/header.jsp"/>
            <section style="display: flex">
                <aside>
                    <p> Menu </p>
                    <div class="menu-section-content-search-form" style="margin-bottom: 20px;">
                        <form action="searchPageURL" method="get">
                            <input name="keyWord" type="text" placeholder="Bạn cần tìm gì?" style="width: 67%;border-radius: 7px;padding: 8px 2px 8px 6px;"/>
                            <button type="submit" class="search-btn">Tìm kiếm</button>
                        </form>
                    </div>
                    <a href="HomePageURL"><i class="fa fa-home"></i> Trang Chủ</a>
                    <a href="HomePageURL?section=newProduct">Sản Phẩm Mới Nhất</a>
                    <p style="font-size: 16px;text-align: center;">Danh Mục Sản Phẩm:</p>
                        <!--<label for="touch-1"><span class="content-title-2">Danh Mục Sản Phẩm</span>-->
                            <!--<i class="fa-solid fa-angle-down"></i>-->
                        <!--</label>-->               
                        <!--<input type="checkbox" id="touch-1">--> 
                        <ul class="sider-menu-1">
                            <%
                            DAOCategories daoCate = new DAOCategories();
                            Vector<Categories> CateList = daoCate.getCategories("select * from Categories");
                            for(Categories cate: CateList){%>
                            <li><a href="ProductListURL?service=ShowCategory&CategoryID=<%=cate.getCategoryID()%>&index=1"><%=cate.getCategoryName()%></a></li> 
                                <%}%>
                        </ul>
                    
                </aside>
                <div class="card">
                    <div class="row">
                        <div class=" cart">
                            <table style="font-weight: normal; width: 100%;">
                                <thead>
                                    <tr>
                                        <td style="text-align: center;font-weight: bolder;font-size: medium;padding-bottom: 30px;">Ảnh Sản Phẩm</td>
                                        <td style="text-align: center;font-weight: bolder;font-size: medium;padding-bottom: 30px;">Tên Sản Phẩm</td>
                                        <td style="text-align: center;font-weight: bolder;font-size: medium;padding-bottom: 30px;">Số Lượng</td>
                                        <td style="text-align: center;font-weight: bolder;font-size: medium;padding-bottom: 30px;">Giá Tiền</td>
                                        <td style="text-align: center;font-weight: bolder;font-size: medium;padding-bottom: 30px;">Thành Tiền</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                     try {
                                     if(!rs.next()){
                                            message = "Không có sản phẩm nào được chọn";
                                        }
                                        do {
                                        double unitPrice = rs.getDouble("UnitPrice");
                                        double totalunitprice = unitPrice*rs.getInt("Quantity");
                                        totalprice += rs.getInt("Quantity")*unitPrice;
                                    %>
                                    <tr>

                                        <td class="col"><img class="img-fluid" src="<%=rs.getString("ProductURL")%>"></td>

                                        <td class="col"><%=rs.getString("ProductName")%></td>
                                        <td class="col">
                                            <div style="display: flex;">
                                                <div class="change-quantity"><a href="CartURL?service=decquantity&proid=<%=rs.getInt("ProductID")%>">-</a></div>
                                                <a href="#" class="border"><%=rs.getInt("Quantity")%></a>
                                                <div class="change-quantity"><a href="CartURL?service=incquantity&proid=<%=rs.getInt("ProductID")%>">+</a></div>
                                            </div>
                                        </td>
                                        <td class="col"><%=decimalFormat.format(unitPrice)%>đ</td>            
                                        <td class="col"><%=decimalFormat.format(totalunitprice)%>đ</td>
                                        <td class="col">
                                            <a href="CartURL?service=deleteCart&proid=<%=rs.getInt("ProductID")%>"><i class="fa fa-times" style="color: red"></i></a>
                                        </td>
                                    </tr>
                                    <%} while (rs.next());         
                                        rs.close(); 
                                        } catch (SQLException e) {
                                         e.printStackTrace();
                                        }
                                    %>
                                </tbody>


                            </table>
                            <div style="font-weight: normal;display: flex;justify-content: center;">
                                <%
                                    if(message == ""){
                                %>
                                <a href="CartURL?service=deleteAllCart"><i class="fa fa-trash"></i></a>Xóa Tất Cả Sản Phẩm
                                    <%} else{%>
                                <p><%=message%></p>
                                <%}%>
                            </div>
                        </div>
                        <div class="summary">
                            <hr>
                            <div class="summary-child">
                                <div style="bottom: 0">
                                    <div class="row" style="padding: 2vh 0;">
                                        <div class="col" style="">Tổng Đơn Hàng:</div>
                                        <div class="col" style=""><%=decimalFormat.format(totalprice)%>đ</div>
                                    </div>
                                </div>
                            <button class="btn">Thanh Toán</button>
                            </div>
                        </div>
                    </div>

                </div>        
            </section> 
        </div>
        <script>
            document.querySelector("#show-voucher").addEventListener("click", function () {
                document.querySelector(".popup").style.display = "block";
                document.querySelector(".popup").classList.add("active");
                document.getElementById("body").classList.add("blurred-background");
            });
            document.querySelector(".popup .close-btn").addEventListener("click", function () {
                document.querySelector(".popup").style.display = "none";
                document.getElementById("body").classList.remove("blurred-background");
            });
        </script>
    </body>
</html>