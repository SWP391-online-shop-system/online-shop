<%-- 
    Document   : cartdetail
    Created on : Jan 10, 2024, 11:49:22 PM
    Author     : trant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="view.User" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.DAOCart, view.Cart,view.User" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page import="java.util.Vector,java.sql.SQLException,java.sql.ResultSet" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="view.Categories" %>
<%@page import="model.DAOCategories" %>
<%@page import="model.DAOProduct" %>
<%@page import="view.Product" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/cartstyle.css"/>
        <link rel="stylesheet" href="css/css_header/header.css"/>
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="css/css_productList/style.css"/>
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
                <div style="    width: 264px;
                     height: 843px;">
                    <div class="shop__sidebar__search">
                        <form action="searchPageURL" method="GET">
                            <input style="    width: 83%;
                                   font-size: 15px;
                                   color: #b7b7b7;
                                   padding-left: 20px;
                                   border: 2px solid #e5e5e5;
                                   height: 36px;
                                   margin-left: 20px;" name="keyWord" type="text" placeholder="Search...">
                            <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
                        </form>
                    </div>
                    <div class="hottest-pro"style="margin-left: 23px;">
                        <div class="hottest-pro-title">Bán chạy nhất</div>
                        <div class="row" style="display: contents">
                            <%
                                    DAOProduct daoP = new DAOProduct();
                                ResultSet rsHotPro = daoP.getData("select * from Product as p join ProductImage as pi on p.ProductID = pi.ProductID where  pi.ProductURL like '%_1%'\n"
                                +"group by p.ProductID having min(p.TotalStock - p.UnitInStock) > 0");
                            if(rsHotPro.next()) {
                            %>
                            <div class="product__item" style="border: 1px solid #c1e8c1ba;
                                 border-radius: 40px;
                                 padding: 1px;
                                 width: 241px;">
                                <div class="product__item__pic set-bg" style="height: 201px;">
                                    <a href="ProductDetailURL?ProductID=<%=rsHotPro.getInt(1)%>">
                                        <img style="width: 192px;
                                             height: 174px;
                                             margin-left: 25px;
                                             margin-top: 10px;
                                             padding: 0px;" src="<%=rsHotPro.getString("ProductURL")%>" alt="alt"/>
                                    </a>
                                    <%if(rsHotPro.getInt("UnitDiscount")!=0) {%>
                                    <div class="sale-cotification">Sale</div>
                                    <%}%>
                                    <%    ResultSet rsNew2Product = daoP.getData("select * from product as p join productImage as pi "
                                       + "on p.ProductID = pi.ProductID "
                                       + "where pi.ProductURL like '%_1%' "
                                       + "order by p.CreateDate desc limit 6 ");
                                         while(rsNew2Product.next()) {
                                            if(rsHotPro.getString("CreateDate").substring(0,10).equals(rsNew2Product.getString("CreateDate").substring(0,10))){%>
                                    <div class="sale-cotification">Mới</div>
                                    <%}}%>
                                </div>
                                <div class="product__item__text">
                                    <h6 style="text-align: center;"><%=rsHotPro.getString("ProductName")%></h6>
                                    <a href="#" class="add-cart" style="left: 12px;">+ Thêm vào giỏ</a><a style="margin-left: 136px;" href="#">Mua ngay</a>
                                    <div style="display: flex;">
                                        <div class="rating" style="margin-left: 30px;">
                                            <%int star = (int)rsHotPro.getInt("totalRate");
                                              Product pro2 = new Product();
                                              String totalRate = pro2.convertStar(star);
                                            %>
                                            <%=totalRate%>
                                        </div>
                                    </div>
                                    <div style="display: flex;flex-direction: row;justify-content: space-between;">
                                        <%if(rsHotPro.getInt("UnitDiscount")!= 0){%>
                                        <div style="color: red;font-weight: 700;font-size: 15px; flex: 0 0 50%; text-decoration: line-through;"><%=decimalFormat.format(rsHotPro.getDouble("UnitPrice"))%></div>
                                        <div style="color: #0d0d0d;font-weight: 700;font-size: 15px; flex: 0 0 50%"><%=decimalFormat.format(rsHotPro.getDouble("UnitPrice")*(100-rsHotPro.getInt("UnitDiscount"))/100)%></div>
                                        <%} else {%>
                                        <div style="font-weight: 700;
                                             font-size: 15px;
                                             flex: -2 0 43%;
                                             margin-left: 146px;
                                             margin-top: -26px;"><%=decimalFormat.format(rsHotPro.getDouble("UnitPrice"))%></div>
                                        <%}%>
                                    </div>
                                </div>
                            </div>

                            <%}%>
                        </div>
                    </div>
                    <div class="card" style="margin-top: 85px;
                         margin-left: 23px;">
                        <div class="card-heading">
                            <a data-toggle="collapse" data-target="#collapseOne" href="ProductListURL" style="    color: #111111;
                               font-size: 16px;
                               font-weight: 700;
                               text-transform: uppercase;
                               display: block;
                               margin-bottom:20px;">Danh mục</a>
                        </div>
                        <%String TotalRate_raw = (String)request.getAttribute("TotalRate");
                        int TotalRate=0;
                        if(TotalRate_raw==null || TotalRate_raw.equals("")) {
                            TotalRate = 0;
                           } else {
                           TotalRate = Integer.parseInt(TotalRate_raw);
                            }
                        int CategoryID = 0;
                            String CategoryID_raw = (String)request.getAttribute("categoryID");
                            if(CategoryID_raw == null || CategoryID_raw.equals("")) {
                            CategoryID = 0;
                            } else {
                            CategoryID = Integer.parseInt(CategoryID_raw);
                            }
                            ResultSet rsCategory = (ResultSet)request.getAttribute("CategoryResult");
                        %>
                        <div id="collapseOne" class="collapse show" data-parent="#accordionExample">
                            <div class="card-body">
                                <div class="shop__sidebar__categories">
                                    <ul class="nice-scroll">
                                        <li><a style="color: #f7a749;" href="ProductListURL">Tất cả sản phẩm</a></li>
                                            <%String type = (String)request.getAttribute("type");
                                            if(type==null || type.equals("")) {
                                            type = "";
                                                }
                                                double maxP = daoP.getMaxUnitPrice();
                                                double minP =daoP.getMinUnitPrice();
                                            %>
                                        <li class="unique-li" style="<%=type.equals("showSale")?"background: #0091ff2b; width:190px;":""%>"><a style=" color: #f7a749;" href="ProductListURL?service=filter&TotalRate=<%=TotalRate%>&type=showSale&CategoryID=${categoryID}&filterChoice=p.CreateDate%20desc&inputMinPrice=<%=minP%>&inputMaxPrice=<%=maxP%>&index=1">Đang giảm giá</a></li>
                                            <%while(rsCategory.next()) {%>
                                        <li><a href="ProductListURL?service=filter&type=<%=type%>&CategoryID=<%=rsCategory.getInt(1)%>&TotalRate=<%=TotalRate%>&filterChoice=p.CreateDate%20desc&inputMinPrice=<%=minP%>&inputMaxPrice=<%=maxP%>&index=1"><%=rsCategory.getString(2)%></a></li>
                                            <%}%>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="row">
                        <div class=" cart">
                            <table style="font-weight: normal; width: 100%;border-collapse: collapse;">
                                <thead>
                                    <tr style="border-bottom: 1px solid #00000029;">
                                        <td style="text-align: center;font-weight: bolder;font-size: 15px;padding-bottom: 30px;">Ảnh Sản Phẩm</td>
                                        <td style="text-align: center;font-weight: bolder;font-size: 15px;padding-bottom: 30px;">Tên Sản Phẩm</td>
                                        <td style="text-align: center;font-weight: bolder;font-size: 15px;padding-bottom: 30px;width: 100px;">Số Lượng</td>
                                        <td style="text-align: center;font-weight: bolder;font-size: 15px;padding-bottom: 30px;width: 105px;">Giá Tiền</td>
                                        <td style="text-align: center;font-weight: bolder;font-size: 15px;padding-bottom: 30px;">Thành Tiền</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                     try {
                                     int count = 0;
                                     if(!rs.next()){
                                            message = "Không có sản phẩm nào được chọn";
                                        }%>

                                    <%do {
                                        count++;
                                    double unitPrice = rs.getDouble("UnitPrice");
                                    double totalunitprice = unitPrice*rs.getInt("Quantity");
                                    totalprice += rs.getInt("Quantity")*unitPrice;
                                    %>
                                    <tr style="border-bottom: 1px solid #00000029;">

                                        <td class="col"><img class="img-fluid" style="width: 112px;
                                                             height: 112px;padding: 11px;"src="<%=rs.getString("ProductURL")%>"></td>

                                        <td class="col"><%=rs.getString("ProductName")%></td>
                                        <td class="col">
                                            <div style="    display: flex;
                                                 margin-left: 10px;
                                                 margin-bottom: -10px;">
                                                <div class="value-button" style="width: 25px;height: 14px;padding: 4px 0;" onclick="decreaseValue(this);updateTotalPrice();" value="Decrease Value"><i class="fa-solid fa-minus" style="font-size: 11px;"></i></div>
                                                <input id="number" data-count="<%=count%>" style="width: 25px;height: 20px;" type="number" value="<%=rs.getInt("Quantity")%>" min="1" onchange="changeValue(this);updateTotalPrice();"/>
                                                <div class="value-button" style="width: 25px;height: 14px;padding: 4px 0;" onclick="increaseValue(this);updateTotalPrice();" value="Increase Value"><i class="fa-solid fa-plus" style="font-size: 11px;"></i></div><br/>
                                            </div>
                                        </td>
                                        <td class="col"><%=decimalFormat.format(unitPrice)%>đ</td>
                                        <td class="col gett" id="priceDisplay<%=count%>" data-unit-price="<%=unitPrice%>"><%=decimalFormat.format(totalunitprice)%>đ</td>
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
                            <div class="summary">
                                <div style="display: flex;margin-bottom: 10px;margin-top: 80px;">
                                    <div style="flex: 0 0 59%;padding-left: 15px;font-size: 15px;padding-top: 6px;">
                                        <%
                                            if(message == ""){
                                        %>
                                        <a href="CartURL?service=deleteAllCart"><i class="fa fa-trash"></i>&nbsp;Xóa tất cả</a>
                                        <%} else{%>
                                        <p style="background: #e7b559;
                                           width: 246px;
                                           height: 22px;
                                           padding: 5px 42px;
                                           border-radius: 5px;
                                           color: #342e2e;
                                           font-weight: 500;
                                           margin-top: -36px;
                                           margin-left: 276px;"><%=message%></p>
                                        <%}%>
                                    </div>
                                    <%
                                          HttpSession session2 = request.getSession();
                                        User user = (User) session2.getAttribute("account");
                                        int userID = user.getUserID();
                                        DAOCart dao = new DAOCart();
                                    ResultSet rsCheckCart = dao.getData("select * from Cart where UserID = "+userID);
                                    if(!rsCheckCart.isBeforeFirst()){%>
                                    <%}else{%>
                                    <div style="flex: 0 0 42%; display: flex;">
                                        <div style="font-size: 15px;padding-top: 6px;flex:  0 0 62%">Tổng đơn hàng:<span style="margin-left:10px" id="realTotal"></span></div>
                                        <a style="float: right;" href="contactURL?service=showContact">
                                            <button class="btn">Thanh Toán</button>
                                        </a>
                                    </div>
                                    <%}%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="btn-back">
                        <a href="HomePageURL"><button>Trở về</button></a>
                    </div>
                </div>


                <script type="text/javascript">
                    function formatPriceToVND(price) {
                        let formattedPrice = price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                        formattedPrice += "đ";
                        return formattedPrice;
                    }

                    function changeValue(element) {
                        var inputElement = element.parentElement.querySelector('input');
                        var value = parseInt(inputElement.value, 10);
                        value = isNaN(value) ? 1 : value;
                        value <= 1 ? value = 1 : value;
                        inputElement.value = value;
                        updatePriceDisplayPlus(inputElement);
                    }
                    function increaseValue(element) {
                        var inputElement = element.parentElement.querySelector('input');
                        var value = parseInt(inputElement.value, 10);
                        value = isNaN(value) ? 0 : value;
                        value++;
                        inputElement.value = value;
                        updatePriceDisplayPlus(inputElement);
                    }

                    function decreaseValue(element) {
                        var inputElement = element.parentElement.querySelector('input');
                        var value = parseInt(inputElement.value, 10);
                        value = isNaN(value) ? 1 : value;
                        value <= 1 ? value = 1 : value--;
                        inputElement.value = value;
                        updatePriceDisplayPlus(inputElement);
                    }

                    function updatePriceDisplayPlus(inputElement) {
                        var count = inputElement.getAttribute('data-count');
                        var priceDisplayElement = document.getElementById('priceDisplay' + count);
                        var unitPrice = parseFloat(priceDisplayElement.getAttribute('data-unit-price'));
                        var newPrice = parseFloat(inputElement.value) * unitPrice;
                        priceDisplayElement.innerText = formatPriceToVND(newPrice);
                    }
                    function updatePriceDisplayNeg(inputElement) {
                        var count = inputElement.getAttribute('data-count');
                        var priceDisplayElement = document.getElementById('priceDisplay' + count);
                        var unitPrice = parseFloat(priceDisplayElement.getAttribute('data-unit-price'));
                        var quantity = parseFloat(inputElement.value);
                        var newPrice = unitPrice / quantity;
                        priceDisplayElement.innerText = formatPriceToVND(newPrice);
                    }
                    function updateTotalPrice() {
                        var count1 = document.getElementsByClassName("gett");
                        var result = 0;
                        for (let i = 0; i < count1.length; i++) {
                            result += (parseInt(count1[i].innerHTML.slice(0, -1).replaceAll(",", "")));
                        }
                        var rs = document.getElementById("realTotal");
                        rs.innerText = formatPriceToVND(result);
                    }
                    updateTotalPrice();
                </script>
            </section>
        </div>
    </body>
</html>
