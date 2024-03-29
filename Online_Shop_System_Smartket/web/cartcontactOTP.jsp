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
<%@page import="view.*" %>
<%@page import="model.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/cartstyle.css"/>
        <link rel="stylesheet" href="css/css_header/header.css"/>
        <link rel="stylesheet" href="css/css_productList/style.css"/>
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/ruang-admin.min.css" rel="stylesheet">
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <title>Giỏ Hàng</title>
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
            .otp-field {
                flex-direction: row;
                column-gap: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .otp-field input {
                height: 45px;
                width: 42px;
                border-radius: 6px;
                outline: none;
                font-size: 1.125rem;
                text-align: center;
                border: 1px solid #ddd;
            }
            .otp-field input:focus {
                box-shadow: 0 1px 0 rgba(0, 0, 0, 0.1);
            }
            .otp-field input::-webkit-inner-spin-button,
            .otp-field input::-webkit-outer-spin-button {
                display: none;
            }

            .resend {
                font-size: 12px;
            }
        </style>
    </head>
    <body>
        <%
            HttpSession session3 = request.getSession();
            User user1 = (User) session3.getAttribute("account");
//           ResultSet rs = (ResultSet)request.getAttribute("data");
           String message ="";
           DecimalFormat decimalFormat = new DecimalFormat("#,###.#");
           double totalprice = 0;
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
            <div class="card" style="align-items: center">
                <div class="cart" style="flex: 0">
                    <div class="row justify-content-center">
                        <div class="card bg-white mb-5 mt-5 border-0" style="box-shadow: 0 12px 15px rgba(0, 0, 0, 0.02);">
                            <div class="card-body p-5 text-center">
                                <h4>Mã của bạn đã được gửi đến email đăng kí nhận hàng</h4>
                                <p>Vui lòng điền mã OTP để xác nhận</p>

                                <div class="otp-field mb-4">
                                    <input type="number" id="otp1"/>
                                    <input type="number" id="otp2" disabled />
                                    <input type="number" id="otp3" disabled />
                                    <input type="number" id="otp4" disabled />
                                    <input type="number" id="otp5" disabled />
                                    <input type="number" id="otp6" disabled />
                                </div>
                                <button class="btn btn-primary" style="cursor: pointer" onclick="verifyOTP()">Xác nhận</button>
                                <p class="resend text-muted mb-0">
                                    Bạn không nhận được mã? <a href="CartcontactOTPVerify?service=reSendOTP">Gửi lại mã</a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Form Basic -->

        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
        <script src="js/ruang-admin.min.js"></script>
        <script src="js/verify.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    </body>
</html>