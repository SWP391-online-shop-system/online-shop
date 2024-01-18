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
           DecimalFormat decimalFormat = new DecimalFormat("#,###.#");
           double totalprice = 0;
        %>
        <div id="body">
            <jsp:include page="include/header.jsp"/>
            <section>
                <div class="card">
                    <div class="row">
                        <div class=" cart">
                            <table style="width: 100%; height: 100%; font-weight: normal;">
                                <!--                                <div class="title">
                                                                    <div class="row">
                                                                        <div class="col"><h4><b>Giỏ hàng</b></h4></div>
                                                                    </div>
                                                                    <div class="row" style="font-weight: normal;">
                                                                        <div class="col"><p>Ảnh Sản Phẩm</p></div>
                                                                        <div class="col"><p>Tên Sản Phẩm</p></div>
                                                                        <div class="col"><p>Số Lượng Sản Phẩm</p></div>
                                                                        <div class="col"><p>Giá Tiền 1 Đơn Vị</p></div>
                                                                        <div class="col"><p>Giá Tiền Sản Phẩm</p></div>
                                                                    </div>
                                                                </div>    -->
                                <thead>
                                    <tr>
                                        <td style="text-align: center;font-weight: bolder;font-size: medium;">Ảnh Sản Phẩm</td>
                                        <td style="text-align: center;font-weight: bolder;font-size: medium;">Tên Sản Phẩm</td>
                                        <td style="text-align: center;font-weight: bolder;font-size: medium;">Số Lượng Sản Phẩm</td>
                                        <td style="text-align: center;font-weight: bolder;font-size: medium;">Giá Tiền 1 Đơn Vị</td>
                                        <td style="text-align: center;font-weight: bolder;font-size: medium;">Giá Tiền Sản Phẩm</td>
                                    </tr>
                                </thead>
                                <tbody>


                                    <!--                                    <div class="col"><img class="img-fluid" src="https://i.imgur.com/1GrakTl.jpg"></div>
                                                                        <div class="col">
                                                                            <div>Shirt</div>
                                                                            <div>Cotton T-shirt</div>
                                                                        </div>
                                                                        <div class="col">
                                                                            <a href="#">-</a><a href="#" class="border">1</a><a href="#">+</a>
                                                                        </div>
                                                                        <div class="col">&euro; 44.00 <span class="close">&#10005;</span></div>-->
                                    <%
                        
                            try {
                                        while (rs.next()) {
                                        double unitPrice = rs.getDouble("UnitPrice");
                                        double totalunitprice = unitPrice*rs.getInt(3);
                                        totalprice += rs.getInt(3)*unitPrice;
                                    %>
                                    <tr>
                                        <!-- <div class="col"><img class="img-fluid" src="https://i.imgur.com/1GrakTl.jpg"></div>-->
                                        <td class="col"></td>

                                        <td class="col"><%=rs.getString(5)%></td>
                                        <td class="col"><a href="CartURL?service=decquantity&proid=<%=rs.getInt("ProductID")%>">-</a><a href="#" class="border"><%=rs.getInt(3)%></a><a href="CartURL?service=incquantity&proid=<%=rs.getInt("ProductID")%>">+</a></td>
                                        <td class="col"><%=decimalFormat.format(unitPrice)%>Đ</td>            
                                        <td class="col"><%=decimalFormat.format(totalunitprice)%>Đ</td>
                                        <td class="col">
                                            <a href="CartURL?service=deleteCart&proid=<%=rs.getInt("ProductID")%>"><i class="fa fa-times" style="color: red"></i></a>
                                        </td>
                                    </tr>
                                    <%      }
                        
                                rs.close(); 
                                } catch (SQLException e) {
                                 e.printStackTrace();
                                }
                                    %>


                                </tbody>
                            </table>

                            <div class="back-to-shop"><a href="homepage.jsp">&leftarrow; Trở Về</a></div>
                        </div>
                        <div class="summary">
                            <hr>
                            <div class="row" style="border-top: 1px solid rgba(0,0,0,.1); padding: 2vh 0;">
                                <div class="col">Tổng Đơn Hàng</div>
                                <div class="col text-right"><%=decimalFormat.format(totalprice)%>Đ</div>
                            </div>
                            <div class="row">
                                <!--                                <div class="col" style="padding-left:0;">ITEMS 3</div>
                                                                <div class="col text-right">&euro; 132.00</div>-->
                            </div>
                            <p>Mã Giảm Giá</p>
                            <button class="btn btnvoucher" id="show-voucher">Chọn Mã Giảm Giá</button>

                            <button class="btn">Thanh Toán</button>
                        </div>
                    </div>

                </div>
            </section> 
        </div>
        <div>
            <div class="popup">
                <div class="close-btn">X</div>
                <div class="form">
                    <h2>Mã Giảm Giá</h2>
                    <div class="form-element">
                        <label for="email">Không Có Mã Giảm Giá Nào</label>                                        
                    </div>


                </div>
            </div>

            <script>
                document.querySelector("#show-voucher").addEventListener("click", function () {
                    document.querySelector(".popup").style.display = "block";
                    document.querySelector(".popup").classList.add("active");
                    document.getElementById("body").classList.add("blurred-background");
                });
                document.querySelector(".popup .close-btn").addEventListener("click", function () {
//                    document.querySelector(".popup").classList.remove("active");
                    document.querySelector(".popup").style.display = "none";
                    document.getElementById("body").classList.remove("blurred-background");
                });
            </script>
        </div>

    </body>
</html>