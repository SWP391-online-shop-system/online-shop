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
<%@page import="java.text.DecimalFormat,java.util.Arrays" %>
<%@page import="view.*" %>
<%@page import="model.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity= "sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"> 
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity= "sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous">
        </script> 
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="css/cartstyle.css"/>
        <link rel="stylesheet" href="css/css_header/header.css"/>
        <link rel="stylesheet" href="css/css_productList/style.css"/>
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <title>Đơn Hàng</title>
        <style>
            body{
                margin: 5px -5px;
            }
            a{
                color: black;
                text-decoration: none !important;
            }
            .btn-back{
                margin-left: 1.25rem;
                padding: 7px 15px;
                background: #5bbc5b;
                border: none;
                border-radius: 3px;
                color: white;
                font-size: 14px;
                transition: all 0.5s;
            }
            .btn-back:hover{
                cursor: pointer;
                transform: scale(0.95);
            }

            .resend {
                font-size: 12px;
            }
            #notCheckout:hover{
                background: gray;
            }
            #notCheckout{
                background: gray;
            }
        </style>
    </head>
    <body>
        <%
            HttpSession session3 = request.getSession();
            User user1 = (User) session3.getAttribute("account");
            String firstName = user1.getFirstName();
            String lastName = user1.getLastName();
           ResultSet rs = (ResultSet)request.getAttribute("data");
           String message ="";
           DecimalFormat decimalFormat = new DecimalFormat("#,###.#");
           double totalprice = 0;
           String[] productIdBuy = (String[])request.getAttribute("productToBuy");
        %>
        <div class="header" style="margin-top: 21px;">
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <div class="header-title" style="margin-top: -16px;">
                <div class="header-title-left">
                    <ul>
                        <li>
                            <div class="header-email">
                                <i class="fa-regular fa-envelope"></i>
                                <span class="header-email-title">SmartketFPT@gmail.com</span>
                            </div>
                        </li>
                        <li>
                            <div class="header-support">
                                <div><a href="#">Hỗ trợ</a></div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="header-title-right">
                    <div class="header-title-right-social">
                        <div><a href="#" title="Trang Facebook chúng tôi"><i class="fa-brands fa-facebook"></i></a></div>
                        <div><a href="#" title="Trang Twitter của chúng tôi"><i class="fa-brands fa-x-twitter"></i></a></div>
                    </div>
                    <div class="header-title-right-about">
                        <a href="#">Về chúng tôi</a>
                    </div>
                    <div class="header-title-right-login">
                        <!DOCTYPE html>
                        <html lang="en">
                            <head>
                                <meta charset="UTF-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                <title>Smarket</title>
                                <link rel="stylesheet" href="css/login.css"/>
                            </head>
                            <body> 
                                <%
                                    String message1 = (String)request.getAttribute("message");
                                    String messagesu1 = (String)request.getAttribute("messageSignUp");
                                    String msg1 = (String)request.getAttribute("msg1");
                                %>
                                <c:if test="${sessionScope.account.roleID == 5}">
                                    <a href="#"style="margin-right: 50px;">ADMIN</a>

                                </c:if>
                                <c:if test="${sessionScope.account.roleID == 4}">
                                    <a href="#">SALE MANAGER</a>


                                </c:if>
                                <c:if test="${sessionScope.account.roleID == 3}">
                                    <a href="#">SALE</a>


                                </c:if>
                                <c:if test="${sessionScope.account.roleID == 2}">
                                    <a href="#">Marketing</a>
                                </c:if>
                                <c:if test="${sessionScope.account != null}">
                                    <a href="logout">Đăng xuất</a>
                                    <a href="profileUser.jsp"><img style="width: 30px;
                                                                   height: 30px;
                                                                   margin-right: -10px;
                                                                   margin-bottom: -8px;
                                                                   margin-left: 7px;
                                                                   border-radius: 50%;" class="styling1" src="images/user/default_avatar.jpg" alt="Admin Image"></a>
                                    </c:if>
                                    <c:if test="${sessionScope.account == null}">
                                    <button href="#" style="border: none; font-size:16px; font-family: math;" id="show-login">Đăng nhập</button>
                                </c:if>
                                <!-- Login Pop-up Form -->
                                <form action="loginURL" method="post">
                                    <div class="popup ${requestScope.activeLogin}" id="loginPopup">
                                        <div class="close-btn" onclick="togglePopup('loginPopup')">x</div>
                                        <div class="form">
                                            <h2>Đăng nhập</h2>
                                            <p class="text-danger" style="
                                               color: red;
                                               font-size: 20px;
                                               font-weight: 700;
                                               text-align: left;"><%=(message1 == null) ? "" : message1%></p>
                                            <div class="form-element">
                                                <label for="email">Email</label>
                                                <input type="email" id="email" name="email" placeholder="Nhập email" required 
                                                       oninvalid="this.setCustomValidity('Vui lòng điền thông tin này và bao gồm @')" 
                                                       oninput="setCustomValidity('')">
                                            </div>
                                            <div class="form-element">
                                                <label for="password">Mật khẩu</label>
                                                <input type="password" id="pass" name="pass" placeholder="Nhập mật khẩu" required 
                                                       oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                                       oninput="setCustomValidity('')">
                                            </div>
                                            <div class="form-element">
                                                <button type="submit" value="login" >Đăng nhập</button>
                                            </div>
                                            <div class="form-element">
                                                <button id="showSignup" onclick="togglePopup('signupPopup')">Đăng kí</button>
                                            </div>
                                            <div class="form-element">
                                                <a href="#">Quên mật khẩu?</a>
                                            </div>
                                        </div>
                                    </div>
                                </form>

                                <!-- Registration Pop-up Form -->
                                <form action="signupURL" method="post">
                                    <input type="hidden" name="service" value="signupRegister">
                                    <div class="popup ${requestScope.activeSignUp}" id="signupPopup">
                                        <div class="close-btn" onclick="togglePopup('signupPopup')">x</div>
                                        <div class="form">
                                            <h2>Đăng kí</h2>
                                            <%User u = (User)request.getAttribute("lastUser");
                                    if(u == null) {%>
                                            <div class="form-element">
                                                <label for="registerEmail">Họ</label>
                                                <input type="text" name="rFName" placeholder="Nhập họ" required 
                                                       pattern="[A-Za-zÀ-ỹ ]+" oninvalid="this.setCustomValidity('Vui lòng điền thông tin này, Không bao gồm số và kí tự đặc biệt')" 
                                                       oninput="setCustomValidity('')" >
                                            </div>
                                            <div class="form-element">
                                                <label for="registerEmail">Tên</label>
                                                <input type="text" name="rLName" placeholder="Nhập Tên" required
                                                       pattern="[A-Za-zÀ-ỹ ]+" oninvalid="this.setCustomValidity('Vui lòng điền thông tin này, Không bao gồm số và kí tự đặc biệt')" 
                                                       oninput="setCustomValidity('')" >
                                            </div>
                                            <div class="form-element" style="margin-top: 28px;">
                                                <label for="registerEmail">Email</label>
                                                <input type="email" name="remail" placeholder="Nhập email"required
                                                       oninvalid="this.setCustomValidity('Vui lòng điền thông tin này và bao gồm @')" 
                                                       oninput="setCustomValidity('')" >
                                            </div>
                                            <div class="form-element">
                                                <label for="registerPassword">Mật khẩu</label>
                                                <input type="password" name="rpass" placeholder="Nhập mật khẩu" required
                                                       minlength="6" title="Mật khẩu phải chứa từ 6 đến 8 ký tự" 
                                                       oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                                       oninput="setCustomValidity('')">
                                            </div>
                                            <div class="form-element">
                                                <label for="registerPassword">Nhập lại mật khẩu</label>
                                                <input type="password" name="rrepass" placeholder="Nhập lại mật khẩu" required
                                                       title="Mật khẩu phải chứa từ 6 đến 8 ký tự" 
                                                       oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                                       oninput="setCustomValidity('')">
                                            </div>
                                            <%} else {%>
                                            <div class="form-element">
                                                <label for="registerEmail">Họ</label>
                                                <input type="text" name="rFName" placeholder="Nhập họ" required 
                                                       pattern="[A-Za-zÀ-ỹ ]+" oninvalid="this.setCustomValidity('Vui lòng điền thông tin này, Không bao gồm số và kí tự đặc biệt')" 
                                                       oninput="setCustomValidity('')" value="<%=u.getLastName()%>">
                                            </div>
                                            <div class="form-element">
                                                <label for="registerEmail">Tên</label>
                                                <input type="text" name="rLName" placeholder="Nhập Tên" required
                                                       pattern="[A-Za-zÀ-ỹ ]+" oninvalid="this.setCustomValidity('Vui lòng điền thông tin này, Không bao gồm số và kí tự đặc biệt')" 
                                                       oninput="setCustomValidity('')" value="<%=u.getFirstName()%>">
                                            </div>
                                            <div class="form-element" style="margin-top: 28px;">
                                                <label for="registerEmail">Email</label>
                                                <input type="email" name="remail" placeholder="Nhập email"required
                                                       oninvalid="this.setCustomValidity('Vui lòng điền thông tin này và bao gồm @')" 
                                                       oninput="setCustomValidity('')" value="<%=u.getEmail()%>">
                                            </div>
                                            <div class="form-element">
                                                <label for="registerPassword">Mật khẩu</label>
                                                <input type="password" name="rpass" placeholder="Nhập mật khẩu" required
                                                       minlength="6" title="Mật khẩu phải chứa từ 6 đến 8 ký tự" 
                                                       oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                                       oninput="setCustomValidity('')"value="<%=u.getPassword()%>">
                                            </div>
                                            <div class="form-element">
                                                <label for="registerPassword">Nhập lại mật khẩu</label>
                                                <input type="password" name="rrepass" placeholder="Nhập lại mật khẩu" required
                                                       title="Mật khẩu phải chứa từ 6 đến 8 ký tự" 
                                                       oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                                       oninput="setCustomValidity('')"value="<%=u.getRePassword()%>">
                                            </div>
                                            <%}%>
                                            <p class="text-danger" style="
                                               color: red;
                                               font-size: 20px;
                                               font-weight: 700;
                                               text-align: left;"><%=(messagesu1 == null) ? "" : messagesu1%></p>
                                            <div class="form-element">
                                                <button type="submit" >Đăng kí</button>
                                            </div>
                                            Ðã có tài khoản?<a id="loginAfterRegister" href="#">Đăng nhập ngay</a>
                                        </div>
                                    </div>
                                </form>
                            </body>
                            <script src="js/login.js">

                            </script>
                        </html>
                    </div>
                </div>
            </div>  
            <div class="header-content" style="margin-bottom: 20px;">
                <div class="header-content-logo">
                    <a href="HomePageURL"><img src="images/logo/logo.png"alt="404"/></a>
                </div>
                <div class="header-content-menu">
                    <ul>
                        <li class="active"><a href="HomePageURL">Trang chủ</a></li>
                        <li><a href="ProductListURL?service=ShowAllProduct">Mua hàng</a></li>
                        <li>
                            <a href="#">Trang</a>
                            <ul class="header-content-menu-drop-down">
                                <c:if test="${sessionScope.account == null}">
                                    <li><a href="loginURL" onclick="alertOpenCart()">Giỏ hàng của tôi</a></li>
                                    </c:if>
                                    <c:if test="${sessionScope.account != null}">
                                    <li><a href="CartURL">Giỏ hàng của tôi</a></li>
                                    </c:if>
                                <li><a href="MyOrderURL">Đơn hàng của tôi</a></li>
                            </ul>
                        </li>
                        <li><a href="blog">Blog</a></li>
                            <c:if test="${sessionScope.account != null}">
                            <li><a href="profileUser.jsp">Tài khoản</a></li>
                            </c:if>            
                    </ul>
                </div>
                <div class="header-content-right-menu">
                    <ul>
                        <li class="margin-unit"><a href="MyOrderURL" title="Đơn hàng của tôi"><i class="fa-solid fa-file-invoice-dollar"></i></i></a></li>
                            <c:if test="${sessionScope.account == null}">
                            <li><a href="loginURL" onclick="alertOpenCart()"title="Giỏ hàng của tôi"><i class="fa-solid fa-cart-shopping"></i></a></li>
                                </c:if>
                                <c:if test="${sessionScope.account != null}">
                            <li>
                                <%
                                    HttpSession session2 = request.getSession();
                                    User user = (User) session2.getAttribute("account");
                                    int userID = user.getUserID();
                                    DAOCart dao = new DAOCart();
                                    
                                    ResultSet rs1 = dao.getData("SELECT count(*) as count FROM Cart AS c JOIN Product AS p ON c.ProductID = p.ProductID where userID = "+userID+"");
                                    while(rs1.next()){
                                %>
                                <span class="count-cart" style="position: absolute;
                                      margin-left: 17px;
                                      background-color: #ff0000;
                                      color: #ffffff;
                                      border-radius: 50%;
                                      padding: 0px 4px;
                                      font-size: 15px;
                                      z-index: 9;
                                      top: 11px;
                                      left: 3px;
                                      font-family: none;
                                      line-height: normal;"><%=rs1.getInt(1)%></span>
                                <%
                                    }
                                %>
                                <a href="CartURL" title="Giỏ hàng của tôi"><i class="fa-solid fa-cart-shopping"></i></a>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
        <script>
            function alertOpenCart() {
                alert('Đăng nhập để xem giỏ hàng của bạn');
            }
        </script>
        <section style="display: flex">
            <div style="width: 264px;
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
                     margin-left: 23px;    width: 93%;">
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
            <div style="    flex: 73%;">
                <div style="    background: linear-gradient(90deg, #addd0000 10.66%, #16af0073 50.03%, #00932e00 92.34%, rgb(0 255 148 / 35%) 191.41%, rgb(255 59 212 / 0%) 191.43%);
                     margin: 0 0px 15px 0;
                     text-align: center;
                     border-radius: 6px;
                     padding: 10px;    margin-top: -58px;">
                    <p style="    font-size: 20px;
                       text-transform: uppercase;
                       color: #000000;
                       letter-spacing: 4px;
                       /* font-weight: 600; */
                       margin: 0;">Đơn&nbsp; Hàng</p>
                </div>
                <div class="card" style="    height: fit-content;
                     width: 94%;
                     margin: 0 0 0 28px;">
                    <!--<form action="contactURL" method="post">-->
                    <div class="modal fade" id="DS"> 
                        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" id="modal1" style="max-width: 59%;"> 
                            <div class="modal-content"> 
                                <div class="modal-header"> 
                                    <h5 class="modal-title" id="DSLabel"> 
                                        Địa chỉ giao hàng
                                    </h5> 
                                    <button type="button" class="btn-close"
                                            data-bs-dismiss="modal"> 
                                    </button>
                                </div> 
                                <div class="modal-body">
                                    <!--<input type="hidden" name="service" value="saveAdd"/>-->
                                    <%
                                                       ResultSet rsAddress = (ResultSet)request.getAttribute("rsAddress");
                                                       if(!rsAddress.isBeforeFirst()){%>
                                    <div style="    text-align: center;
                                         background-color: orange;
                                         width: 29%;
                                         border-radius: 4px;
                                         /* letter-spacing: 1px; */
                                         margin: auto;
                                         color: black;">Bạn chưa có địa chỉ nào</div>
                                    <%}
                                    else {
                                        while(rsAddress.next()){      
                                    %>
                                    <div class="card" style="margin: 0;width: 100%;margin-bottom: 8px;">
                                        <div class="p-3">
                                            <div class="d-flex flex-row align-items-center new-content" >
                                                <i><img src="images/logo/iconLocation.png" alt="" style="width: 30px;height: 26px;"/></i>
                                                <div class="d-flex flex-column ms-3" style="flex:1">
                                                    <h6 class="fw-bold">Người nhận: <%=rsAddress.getString("Name")%>&nbsp;|&nbsp;
                                                        <%=rsAddress.getBoolean("Gender")?"Nam":"Nữ"%></h6>
                                                    <span>
                                                        Số điện thoại: <%=rsAddress.getString("Phone")%><br/>
                                                        Email: <%=rsAddress.getString("Email")%><br/>
                                                        Địa chỉ: <%=rsAddress.getString("CityDistrictWard")%><br/>
                                                        <%=rsAddress.getString("AddDetail")%>
                                                    </span>
                                                </div>
                                                <!--                                                       data-bs-target="#update" -->
                                                <div class="">
                                                    <a onclick="showOneAdd(this)"
                                                       data-bs-toggle="modal" 
                                                       data-bs-dismiss="modal" style="cursor: pointer;padding: 0">Chỉnh sửa</a><br/>
                                                    <label>Đặt mặc định <input type="radio" value="<%=rsAddress.getInt(1)%>" class="defaultAdd" name="addId" <%if(rsAddress.getString("Status").equals("1")){%>checked<%}%>/></label>
                                                    <br/><a style="cursor: pointer;padding: 0" onclick="deleteAdd(this)"><i class="fa fa-trash"></i> Xóa</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%}}%>
                                </div> 
                                <div class="modal-footer" style="justify-content: flex-start;"> 
                                    <div>
                                        <a class="btn-success" href="#addnew"
                                           data-bs-toggle="modal" data-bs-dismiss="modal" style="text-decoration: none;padding: 4px 11px 4px 11px;"> 
                                            Thêm địa chỉ mới 
                                        </a>
                                    </div>
                                    <button class="btn-success" onclick="saveAdd()">Lưu</button>
                                </div> 
                            </div> 
                        </div> 
                    </div>
                    <!--</form>-->
                    <!--<form id="formAddnew">-->
                    <div class="modal fade" id="addnew"
                         aria-hidden="true" aria-labelledby="DSLabel2"
                         tabindex="-1">
                        <div class="modal-dialog modal-dialog-centered
                             modal-dialog-scrollable" id="modal2"> 
                            <div class="modal-content" style="    width: 147%;"> 
                                <div class="modal-header"> 
                                    <h5 class="modal-title" id="AlgoLabel"> 
                                        Tạo địa chỉ mới 
                                    </h5> 
                                    <button type="button" class="btn-close"
                                            data-bs-dismiss="modal" aria-label="Close"> 
                                    </button> 
                                </div> 
                                <div class="modal-body p-3"> 
                                    <div class="form-group">
                                        <label>Tên người nhận</label>
                                        <input name="name" type="text" required autofocus class="form-control" id="newName" aria-describedby="emailHelp"
                                               placeholder="Nhập tên..." pattern="[A-Za-zÀ-ỹ ]+" oninvalid="this.setCustomValidity('Vui lòng điền thông tin này, Không bao gồm số và kí tự đặc biệt')" 
                                               oninput="setCustomValidity('')" >
                                    </div>
                                    <div class="form-group">
                                        <label>Số điện thoại người nhận</label>
                                        <input name="phone" type="number" required class="form-control" 
                                               minlength="6" maxlength="10"
                                               pattern="[0-9 ]+" oninvalid="this.setCustomValidity('Vui lòng điền thông tin này, Không bao gồm chữ cái và kí tự đặc biệt')" 
                                               oninput="setCustomValidity(''); validateInput(this)"
                                               id="newPhone" placeholder="Nhập số điện thoại...">
                                    </div>
                                    <div class="form-group">
                                        <label>Email</label>
                                        <input name="email" type="email" required class="form-control" id="newEmail" placeholder="Nhập email..."
                                               oninvalid="this.setCustomValidity('Vui lòng điền thông tin này và bao gồm @')" 
                                               oninput="setCustomValidity(''); validateInput(this)">
                                    </div>
                                    <div class="form-element" style="display: flex;">
                                        <label>Giới tính</label>
                                        <div style="display:flex; flex: 40%; margin-left: 11px">
                                            <div class="custom-control custom-radio" style="margin-right: 15px;">
                                                <input type="radio" id="customRadio3" name="newGender" class="custom-control-input" value="male" required>
                                                <label class="custom-control-label" for="customRadio3">Nam</label>
                                            </div>
                                            <div class="custom-control custom-radio">
                                                <input type="radio" id="customRadio4" name="newGender" class="custom-control-input" value="female" required>
                                                <label class="custom-control-label" for="customRadio4">Nữ</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Địa Chỉ Người Nhận
                                        </label><br/>
                                        <select name="city" id="city"  style="width: 31%;" required>
                                            <option value="" id="newCity"  selected>Tỉnh thành</option>           
                                        </select>
                                        <select name="district" id="district"  style="width: 31%;" required>
                                            <option value="" id="newDistrict"  selected>Quận huyện</option>
                                        </select>
                                        <select name="ward" id="ward"  style="width: 31%" required>
                                            <option value="" id="newWard"  selected>Phường xã</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Địa chỉ cụ thể (số nhà, tên đường)</label>
                                        <textarea name="addressdetail"  class="form-control" id="newAddressDetail" required></textarea>
                                    </div>
                                </div> 
                                <div class="modal-footer"> 
                                    <div>
                                        <a style="color: white" class="btn btn-success" data-bs-target="#DS"
                                           data-bs-toggle="modal" data-bs-dismiss="modal"> 
                                            Hủy 
                                        </a>
                                        <!--                                        <button class="btn btn-success" 
                                                                                        data-bs-toggle="modal" 
                                                                                        data-bs-target="#DS"
                                                                                   data-bs-toggle="modal" data-bs-dismiss="modal"                                               
                                                                                        onclick="addNewAdd()"> 
                                                                                    Lưu
                                                                                </button>-->
                                        <button type="submit" class="btn btn-success" data-bs-target="#DS"
                                                data-bs-toggle="modal" data-bs-dismiss="modal" onclick="addNewAdd()"> 
                                            Lưu
                                        </button>
                                    </div>
                                </div> 
                            </div> 
                        </div>
                    </div>
                    <!--</form>-->
                    <!-- update modal-------------------------------------------- -->
                    <!--<form id="formUpdate" action="contactURL" method="post">-->
                    <div class="modal fade" id="update"
                         aria-hidden="true" aria-labelledby="DSLabel2"
                         tabindex="-1">
                        <input type="hidden" name="service" value="updateAdd"/>
                        <div class="modal-dialog modal-dialog-centered
                             modal-dialog-scrollable"> 
                            <div class="modal-content" style="    width: 147%;"> 
                                <div class="modal-header"> 
                                    <h5 class="modal-title" id="AlgoLabel"> 
                                        Cập nhật địa chỉ
                                    </h5> 
                                    <button type="button" class="btn-close"
                                            data-bs-dismiss="modal" aria-label="Close"> 
                                    </button> 
                                </div> 
                                <div class="modal-body p-3" id="updateContent">           

                                    <!--                                    <div class="form-group">
                                                                            <label>Tên người nhận</label>
                                                                            <input name="name" type="text" value="" required autofocus class="form-control" id="updateName" aria-describedby="emailHelp"
                                                                                   placeholder="Nhập tên...">
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label>Số điện thoại người nhận</label>
                                                                            <input name="phone" type="number" value="" required class="form-control" id="updatePhone" placeholder="Nhập số điện thoại...">
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label>Email</label>
                                                                            <input name="email" value="" required class="form-control" id="updateEmail" placeholder="Nhập email...">
                                                                        </div>
                                                                        <div class="form-element" style="display: flex;">
                                                                            <label>Giới tính</label>
                                                                            <div style="display:flex; flex: 40%; margin-left: 11px">
                                                                                <div class="custom-control custom-radio" style="margin-right: 15px;">
                                                                                    <input type="radio" id="updateMale" name="updategender" class="custom-control-input" value="male" required>
                                                                                    <label class="custom-control-label" for="updateMale">Nam</label>
                                                                                </div>
                                                                                <div class="custom-control custom-radio">
                                                                                    <input type="radio" id="updateFeMale" name="updategender" class="custom-control-input" value="female" required>
                                                                                    <label class="custom-control-label" for="updateFeMale">Nữ</label>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label>Địa Chỉ Người Nhận
                                                                            </label><br/>
                                                                            <select name="city" id="city1"  style="width: 31%;" required>
                                                                                <option  selected>Tỉnh thành</option>           
                                                                            </select>
                                                                            <select name="district" id="district1"  style="width: 31%;" required>
                                                                                <option  selected>Quận huyện</option>
                                                                            </select>
                                                                            <select name="ward" id="ward1"  style="width: 31%" required>
                                                                                <option  selected>Phường xã</option>
                                                                            </select>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label>Địa chỉ cụ thể (số nhà, tên đường)</label>
                                                                            <textarea name="addressdetail"  required class="form-control" id="updateAddressDetail"></textarea>
                                                                        </div>-->
                                </div>
                                <div class="modal-footer"> 
                                    <div>
                                        <a class="btn btn-success" 
                                           data-bs-target="#DS"
                                           data-bs-toggle="modal" 
                                           data-bs-dismiss="modal"> 
                                            Hủy 
                                        </a>
                                        <button onclick="updateAddress()"
                                                class="btn btn-success"
                                                data-bs-target="#DS"
                                                data-bs-toggle="modal" 
                                                data-bs-dismiss="modal" 
                                                type="submit"> 
                                            Lưu 
                                        </button>
                                    </div>
                                </div> 
                            </div> 
                        </div>
                    </div> 
                    <!--</form>-->
                    <div class="cart-contact" >
                        <form action="CartCompletion" method="post">
                            <div><strong>Thông tin đơn hàng</strong></div>
                            <div class="card-body">
                                <div class="table-responsive-sm">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <td style="width: 6%;"></td>
                                                <td style="">Sản phẩm</td>
                                                <td style="text-align: center;">Số lượng</td>
                                                <td>Giá tiền</td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                          int quantityProduct = 0;
                                          try {
                                              while (rs.next()){
                                              if(Arrays.asList(productIdBuy).contains(String.valueOf(rs.getInt("ProductID")))){
                                               double unitPrice = rs.getDouble("UnitPrice")*(100- rs.getInt("UnitDiscount"))/100;
                                               double totalunitprice = unitPrice*rs.getInt("Quantity");
                                               totalprice += totalunitprice;
                                               quantityProduct++;
                                            %>
                                            <tr>
                                                <td>

                                                    <img class="img-fluid" style="width: 66px;"src="<%=rs.getString("ProductURL")%>">
                                                </td>
                                                <td>                                        
                                                    <%=rs.getString("ProductName")%>
                                                </td>
                                                <td style="text-align: center;">
                                                    <%=rs.getInt("Quantity")%>
                                                </td>
                                                <td style="border-right: none;">
                                                    <%=decimalFormat.format(rs.getInt("Quantity")*(rs.getDouble("UnitPrice") * (100 - rs.getInt("UnitDiscount")) / 100 ))%>đ
                                                </td>
                                            </tr>
                                            <%}}
                                                rs.close(); 
                                                } catch (SQLException e) {
                                                 e.printStackTrace();
                                                }
                                            %>                                      
                                        </tbody>
                                    </table>
                                </div>
                                <div class="row">
                                    <div class="col-lg-7" style="    margin-left: 5%;">
                                        <%ResultSet rsDefaultAdd = (ResultSet)request.getAttribute("rsDefaultAdd");
                                            int checkAdd = 0;
                                            try {
                                                if(!rsDefaultAdd.isBeforeFirst()){%>
                                        <p>Chưa chọn địa chỉ nào</p>
                                        <%} else {
    checkAdd = 1;
                                                while(rsDefaultAdd.next()){
                                        %>
                                        <h6 class="mb-3"><strong>Địa chỉ nhận hàng:</strong></h6>
                                        <div><%=rsDefaultAdd.getString("CityDistrictWard")%></div>
                                        <div><%=rsDefaultAdd.getString("AddDetail")%></div>
                                        <div>Nguời Nhận: <%=rsDefaultAdd.getString("Name")%></div>
                                        <div>Email: <%=rsDefaultAdd.getString("Email")%></div>
                                        <div>Số điện thoại: <%=rsDefaultAdd.getString("Phone")%></div>
                                        <input type="hidden" name="addId" value="<%=rsDefaultAdd.getInt(1)%>"/>
                                        <%          }
                                                }
                                            } catch (SQLException ex) {
                                            }%>
                                        <a class="btn btn-success" href="#DS" 
                                           data-bs-toggle="modal" data-bs-dismiss="modal" > 
                                            Chỉnh sửa địa chỉ
                                        </a>
                                    </div>
                                    <div class="col-lg-4 col-sm-5 ml-auto">
                                        <table class="table table-clear">
                                            <tbody>
                                                <tr>
                                                    <td class="left"><strong>Tổng đơn hàng</strong></td>
                                                    <td class="right"><strong><%=decimalFormat.format(totalprice)%>đ</strong></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <div class="pull-right">
                                            <a href="CartURL" class="btn btn-success" style="height: fit-content;color: white;width: 128px; margin: 0">Hủy đặt hàng</a>
                                            <button type="submit" class="btn-back" <%if(checkAdd == 0){%>id="notCheckout"  disabled style="cursor: not-allowed;" title="Bạn cần chọn địa chỉ"<%}%>>Đặt Hàng</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="totalPrice" value="<%=totalprice%>"/>
                            <input type="hidden" name="quantityProduct" value="<%=quantityProduct%>"/>
                        </form>
                    </div>
                </div>
            </div>
        </section>
        <!-- Form Basic -->

        <script>
            $(document).ready(function () {
                // Kiểm tra nếu URL có chứa tham số modal=show
                var urlParams = new URLSearchParams(window.location.search);
                if (urlParams.has('update') && urlParams.get('update') === 'show') {
                    // Hiển thị modal
                    $('#DS').modal('show');
                }
            });
        </script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
        <script src="js/cartcontact.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    </body>
</html>