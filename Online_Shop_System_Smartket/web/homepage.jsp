<%-- 
    Document   : homepage
    Created on : Jan 10, 2024, 9:01:08 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.*" %>
<%@page import="java.util.Vector" %>
<%@page import="view.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.DecimalFormat" %>
<!DOCTYPE html> 
<html>
    <head>
        <link rel="stylesheet" href="css/login.css"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
        <link rel="stylesheet" href="css/css_productList/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="vendor/bootstrap/scss/_buttons.scss" type="text/css">
        <link rel="stylesheet" href="css/css_productList/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/magnific-popup.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/nice-select.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/style.css" type="text/css">
        <link rel="stylesheet" href="css/css_homepage/homestyle.css"/>
        <link rel="stylesheet" href="css/css_footer/footer.css"/>
        <link rel="stylesheet" href="css/css_header/header.css"/>
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">
        <style>
            cahtml,
            h1,
            h2,
            h3,
            h4,
            h5,
            h6 {
                margin: 0;
                color: #111111;
                font-weight: 400;
                font-family: none;
            }
            body{
                margin: 5px -5px;
            }
            #styleBtn{
                z-index: 99;
                background: white;
                width: 215px;
                margin-left: -43px;
                height: 430px;
                margin-top: 18px;
            }
            .content-title4:after{
                content: " ";
                position: absolute;
                border: 1px solid #f5f5f5;
                bottom: 11px;
                left: -340px;
                width: 124%;
                height: 0;
                z-index: -2;
            }
            a:hover{
                color:black;
            }
            .header-title-right{
                flex: 0 0 50%;
                max-width: 50%;
                box-sizing: border-box;
                padding-top:22px;
                text-align: right;
            }
            .forgot-pass:hover{
                cursor: pointer;
            }


            .btnhi{
                color: #fff;
                background-color: #007bff;
                border-color: #007bff;
                display: inline-block;
                font-weight: 400;
                color: #212529;
                text-align: center;
                vertical-align: middle;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;
                background-color: transparent;
                border: 1px solid transparent;
                padding: 0.375rem 0.75rem;
                font-size: 1rem;
                line-height: 1.5;
                border-radius: 0.25rem;
                transition: color .15s ease-in-out, background-color .15s ease-in-out, border-color .15s ease-in-out, box-shadow .15s ease-in-out;
            }
        </style>
    </head>
    <body>
        <%DecimalFormat df = new DecimalFormat("###,###");
            df.setMaximumFractionDigits(8);%>
        <div class="header">
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <div class="header-title">
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
                                    String message = (String)request.getAttribute("message");
                                    String messagesu = (String)request.getAttribute("messageSignUp");
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
                                    <a href="ChangeuserinfoURL?UserID=${sessionScope.account.userID}"><img style="width: 30px;
                                                                                                           height: 30px;
                                                                                                           margin-right: -10px;
                                                                                                           margin-bottom: 7px;
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
                                            <h2><b>Đăng nhập</b></h2>

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
                                            <p class="text-danger" style="
                                               color: red;
                                               font-size: 15px;
                                               text-align: left;"><%=(message == null) ? "" : message%></p>
                                            <div class="form-element">
                                                <button type="submit" value="login" >Đăng nhập</button>
                                            </div>
                                            <div class="form-element">
                                                <button id="showSignup" onclick="togglePopup('signupPopup')">Đăng kí</button>
                                            </div>

                                        </div>
                                        <div class="form-element">
                                            <a style="color: blue;" class="forgot-pass" data-toggle="modal" data-target="#exampleModal"
                                               id="#myBtn">Quên mật khẩu?</a>
                                        </div>
                                    </div>

                    </div>
                    </form>
                    <!-- start modals -->
                    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Quên mật khẩu</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <p>You Content</p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btnhi btn-outline-primary" data-dismiss="modal" style="border: 1px solid #007bff;">Close</button>
                                    <button type="button" class="btnhi btn-primary"style="border: 1px solid #007bff;">Save changes</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- end modals -->
                    <!-- Registration Pop-up Form -->
                    <form action="signupURL" method="post">
                        <input type="hidden" name="service" value="signupRegister">
                        <input type="hidden" name="timestamp" value="<%= System.currentTimeMillis() %>">
                        <div class="popup ${requestScope.activeSignUp}" id="signupPopup">
                            <div class="close-btn" onclick="togglePopup('signupPopup')">x</div>
                            <div class="form">
                                <h2><b>Đăng ký</b></h2>
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
                                   font-size: 15px;
                                   text-align: left;"><%=(messagesu == null) ? "" : messagesu%></p>
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
        <div class="header-content">
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
                            <c:if test="${sessionScope.account.phoneNumber == null ||
                                          sessionScope.account.dateOfBirth == null ||
                                          sessionScope.account.gender == null ||
                                          sessionScope.account.address == null}">
                            <li title="Cập nhật hồ sơ của bạn!"><div style="background: red;width: 10px;height: 10px;border-radius: 50%;position: absolute;left: 102px;
                                                                     top: -2px;"></div><a href="ChangeuserinfoURL?UserID=${sessionScope.account.userID}">Tài khoản</a></li>
                                </c:if>
                                <c:if test="${sessionScope.account.phoneNumber != null &&
                                              sessionScope.account.dateOfBirth != null &&
                                              sessionScope.account.gender != null &&
                                              sessionScope.account.address != null}">
                            <li><a href="ChangeuserinfoURL?UserID=${sessionScope.account.userID}">Tài khoản</a></li>
                            </c:if>
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
                                ResultSet rs = dao.getData("SELECT count(*) as count FROM Cart AS c JOIN Product AS p ON c.ProductID = p.ProductID where userID = "+userID+"");
                                while(rs.next()){
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
                                  line-height: normal;"><%=rs.getInt(1)%></span>
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
    <section class="menu-section">  
        <div class="menu-section-title">
            <div class="menu-section-content">
                <div class="menu-section-content-categories">
                    <div class="menu-section-content-categories-unit" style="box-sizing: unset;">
                        <i class="fa-solid fa-list"></i>
                        <label for="touch" style="margin-bottom: -3px;"><span class="content-title1" style="padding-left: 16px;">DANH MỤC CHÍNH</span>               
                            <i class="fa-solid fa-angle-down" style="float: right;margin-top: -21px;margin-right: -33px;font-size: 19px;"></i></label>  
                        <input type="checkbox" id="touch"> 

                        <ul class="sider-menu" style="box-sizing: unset;
                            font-family: none;
                            margin-top: 9px;">
                            <li onclick="scrollToNew()">Sản phẩm mới nhất</li> 
                            <li onclick="scrollToFeature()">Sản phẩm nổi bật</li> 
                            <li onclick="scrollToBlog()">Bài viết xu hướng</li> 
                        </ul>
                        <span class="menu-section-drop-list"><i></i></span>
                    </div>
                </div>
                <div class="menu-section-content-search">
                    <div class="menu-section-content-search-form">
                        <%double inputMinPrice = (double)request.getAttribute("inputMinPrice");
                          double inputMaxPrice = (double)request.getAttribute("inputMaxPrice");
                        %>
                        <form action="searchPageURL" method="GET">
                            <input name="keyWord" type="text" placeholder="Bạn cần tìm gì?"/>
                            <input type="hidden" name="type" value=""/>
                            <input type="hidden" name="TotalRate" value="0"/>
                            <input type="hidden" name="filterChoice" value="createDate desc"/>
                            <input type="hidden" name="inputMinPrice" value="<%=inputMinPrice%>"/>
                            <input type="hidden" name="inputMaxPrice" value="<%=inputMaxPrice%>"/>
                            <button type="submit" class="site-btn">Tìm kiếm</button>
                        </form>
                    </div>
                    <div class="menu-section-content-search-phone"style="font-family: none;">
                        <div class="search-phone-icon">
                            <i style="padding-top: 17px" class="fa-solid fa-phone"></i>
                        </div>
                        <div class="search-phone-content" style="padding-top: 29px;">
                            <div>+84 99.999.999</div>
                            <span>Hỗ trợ người dùng</span>
                        </div>
                    </div>
                    <div class="menu-section-slider">
                        <div class="slider">
                            <div class="slides">
                                <input type="radio" name="radio-btn" id="radio1">
                                <input type="radio" name="radio-btn" id="radio2">
                                <input type="radio" name="radio-btn" id="radio3">
                                <input type="radio" name="radio-btn" id="radio4">
                                <%ResultSet rsSlider = (ResultSet)request.getAttribute("rsSlider");
                                int count = 0;
                                while(rsSlider.next()) {
                                count++;
                                if(count == 1) {
                                %>
                                <div class="slide first">
                                    <a href="<%=rsSlider.getString(2)%>"><img src="images/slider/<%=rsSlider.getString(1)%>" alt="alt"/></a>
                                </div>
                                <%} else {%>
                                <div class="slide">
                                    <a href="<%=rsSlider.getString(2)%>"><img src="images/slider/<%=rsSlider.getString(1)%>" alt="alt"/></a>
                                </div>
                                <%}}%>
                                <!-- slide end -->
                                <!--auto-->
                                <div class="navigation-auto">
                                    <div class="auto-btn1"></div>
                                    <div class="auto-btn2"></div>
                                    <div class="auto-btn3"></div>
                                    <div class="auto-btn4"></div>
                                </div>
                            </div>
                            <div class="navigation-manual">
                                <label for="radio1" class="manual-btn manual1"></label>
                                <label for="radio2" class="manual-btn manual2"></label>
                                <label for="radio3" class="manual-btn manual3"></label>
                                <label for="radio4" class="manual-btn manual4"></label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="menu-section-feature">
                <div class="menu-section-feature-content">
                    <div class="menu-section-content-categories-1">
                        <div class="menu-section-content-categories-unit-1" style="    box-sizing: unset;">
                            <i class="fa-solid fa-list"></i>
                            <label for="touch-1"><span class="content-title-2" style="padding-left: 13px;">TẤT CẢ DANH MỤC</span>
                                <i class="fa-solid fa-angle-down" style="float: right;margin-top: -21px;margin-right: -33px;font-size: 19px;"></i></label>               
                            <input type="checkbox" id="touch-1" checked> 
                            <ul class="sider-menu-1" style="font-family: none;
                                margin-top: -3px;
                                box-sizing: unset;
                                margin-left: 1px;
                                height: auto;">
                                <%
                                DAOCategories daoCate = new DAOCategories();
                                 DAOProduct dao = new DAOProduct();
                                Vector<Categories> CateList = daoCate.getCategories("select * from Categories where CategoryStatus = 0;");
                                for(Categories cate: CateList){%>
                                <li><a href="ProductListURL?service=ShowCategory&CategoryID=<%=cate.getCategoryID()%>&index=1"><%=cate.getCategoryName()%></a></li> 
                                    <%}%>
                            </ul>
                        </div>
                    </div>
                    <div class="feature-content" id="newProduct">
                        <div class="content-title"style="margin-top: 110px;">SẢN PHẨM MỚI NHẤT</div>
                        <div class="product-card-content">
                            <%
                            ResultSet rsNewProduct = (ResultSet)request.getAttribute("rsNewProduct");
                            while(rsNewProduct.next()) {%>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg" style="height: 250px;">
                                        <a href="ProductDetailURL?ProductID=<%=rsNewProduct.getInt(1)%>">
                                            <img src="<%=rsNewProduct.getString(13)%>" alt="alt"/>
                                        </a>
                                        <%if(rsNewProduct.getInt("UnitDiscount")!=0) {%>
                                        <div class="sale-cotification">Sale</div>
                                        <%}%>
                                        <%ResultSet rsNewestProduct = dao.getData("select * from product as p join productImage as pi "
                                           + "on p.ProductID = pi.ProductID "
                                           + "where pi.ProductURL = pi.ProductURLShow and p.ProductStatus = 0 "
                                           + "order by p.CreateDate desc limit 6");
                                             while(rsNewestProduct.next()) {
                                                if(rsNewProduct.getString("CreateDate").substring(0,10).equals(rsNewProduct.getString("CreateDate").substring(0,10))){%>
                                        <div class="sale-cotification">Mới</div>
                                        <%}}%>
                                    </div>
                                    <div class="product__item__text"style="text-align: center;">
                                        <h6><%=rsNewProduct.getString("ProductName")%></h6>
                                        <%User testus = (User)session.getAttribute("account");
                                            if(testus==null) {%>
                                        <a onclick="alertOpenCart();" class="add-cart"style="">+ Thêm vào giỏ</a><a style="margin-left: 166px;" href="#">Mua ngay</a>
                                        <%}else{%>
                                        <a href="" onclick="addToCart(<%=rsNewProduct.getInt(1)%>)" class="add-cart"style="margin-left: 29px;">+ Thêm vào giỏ</a><a style="margin-left: 166px;" href="#">Mua ngay</a>
                                        <%}%>
                                        <div style="display: flex;">
                                            <div class="rating">
                                                <%int star = (int)rsNewProduct.getInt("totalRate");
                                                  Product pro2 = new Product();
                                                  String totalRate = pro2.convertStar(star);
                                                %>
                                                <%=totalRate%>
                                            </div>
                                        </div>
                                        <div style="display: flex;">
                                            <%if(rsNewProduct.getInt("UnitDiscount")!= 0){%>
                                            <div style="color: red;font-weight: 700;font-size: 15px; flex: 0 0 50%; text-decoration: line-through;"><%=df.format(rsNewProduct.getDouble("UnitPrice"))%>đ</div>
                                            <div style="color: #0d0d0d;font-weight: 700;font-size: 15px; flex: 0 0 50%"><%=df.format(rsNewProduct.getDouble("UnitPrice")*(100-rsNewProduct.getInt("UnitDiscount"))/100)%>đ</div>
                                            <%} else {%>
                                            <div style="font-weight: 700;
                                                 font-size: 15px;
                                                 flex: -2 0 43%;
                                                 margin-left: 169px;
                                                 margin-top: -26px;"><%=df.format(rsNewProduct.getDouble("UnitPrice"))%>đ</div>
                                            <%}%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%}%>
                        </div>
                    </div>
                    <!--HOTTEST PRODUCT-->
                    <div class="newest-product-section" id="featureProduct">
                        <div class="content-title4" style="margin-left: 424px;margin-bottom: 13px;">SẢN PHẨM NỔI BẬT</div>
                        <section class="product" style="padding: 0;
                                 margin: 0;"> 
                            <button class="pre-btn" id="styleBtn"><img src="images/slider/arrow.png" alt=""style="width: 15px;height: 22px;margin-top: 44px;"></button>
                            <button class="nxt-btn" id="styleBtn"style="margin-right: -40px;"><img src="images/slider/arrow.png" alt="" style="width: 15px;height: 22px;margin-top: -37px;margin-left: -112px;"></button>
                            <div class="product-container"style="height: 380px;">
                                <%
                                       
                            ResultSet rsFeatureProduct = dao.getData("select * from product as p join productImage as pi "
                                    + "on p.ProductID = pi.ProductID "
                                    + "where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow "
                                    + "order by p.TotalRate desc limit 6");
                            while(rsFeatureProduct.next()) {%>
                                <div class="col-lg-4 col-md-6 col-sm-6">
                                    <div class="product__item">
                                        <div class="product__item__pic set-bg" style="height: 250px;">
                                            <a href="ProductDetailURL?ProductID=<%=rsFeatureProduct.getInt("ProductID")%>">
                                                <img src="<%=rsFeatureProduct.getString("ProductURLShow")%>" alt="alt"/>
                                            </a>
                                            <%if(rsFeatureProduct.getInt("UnitDiscount")!=0) {%>
                                            <div class="sale-cotification">Sale</div>
                                            <%}%>
                                        </div>
                                        <div class="product__item__text"style="text-align: center;">
                                            <h6><%=rsFeatureProduct.getString("ProductName")%></h6>
                                            <c:if test="${sessionScope.account==null}">
                                                <a onclick="alertOpenCart();" class="add-cart"style="">+ Thêm vào giỏ</a><a style="margin-left: 136px;" href="#">Mua ngay</a>
                                            </c:if>
                                            <c:if test="${sessionScope.account!=null}">
                                                <a href="#" onclick="addToCart(<%=rsFeatureProduct.getInt(1)%>)" class="add-cart" class="add-cart"style="">+ Thêm vào giỏ</a><a style="margin-left: 136px;" href="#">Mua ngay</a>
                                            </c:if>
                                            <div style="display: flex;">
                                                <div class="rating">
                                                    <%int star = (int)rsFeatureProduct.getInt("totalRate");
                                                      Product pro2 = new Product();
                                                      String totalRate = pro2.convertStar(star);
                                                    %>
                                                    <%=totalRate%>
                                                </div>
                                            </div>
                                            <div style="display: flex;">
                                                <%if(rsFeatureProduct.getInt("UnitDiscount")!= 0){%>
                                                <div style="color: red;font-weight: 700;font-size: 15px; flex: 0 0 50%; text-decoration: line-through;"><%=df.format(rsFeatureProduct.getDouble("UnitPrice"))%>đ</div>
                                                <div style="color: #0d0d0d;font-weight: 700;font-size: 15px; flex: 0 0 50%"><%=df.format(rsFeatureProduct.getDouble("UnitPrice")*(100-rsFeatureProduct.getInt("UnitDiscount"))/100)%>đ</div>
                                                <%} else {%>
                                                <div style="font-weight: 700;
                                                     font-size: 15px;
                                                     flex: -2 0 43%;
                                                     margin-left: 119px;
                                                     margin-top: -26px;"><%=df.format(rsFeatureProduct.getDouble("UnitPrice"))%>đ</div>
                                                <%}%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%}%>
                            </div>
                        </section>
                    </div>
                </div>
                <div class="menu-blog-section">
                    <div class="content-title5" style="margin-bottom: 26px;margin-top: 50px;">Bài viết xu hướng</div>
                    <div class="card-container"style="box-sizing: unset;
                         font-family: none;">
                        <div class="side-bar-lastest-post">
                            <div class="content-title6">Bài viết mới</div>
                            <%
                            DAOBlog daoBlog = new DAOBlog();
                            ResultSet rsNewBlog = (ResultSet)request.getAttribute("rsNewBlog");
                            if(rsNewBlog.next()) {
                            %>
                            <div class="card1"style="height: 324px;">
                                <a href="blogdetail?bid=<%=rsNewBlog.getInt(1)%>">
                                    <div class="card__header1">
                                        <img src="images/blog/<%=rsNewBlog.getString(6)%>" alt="card__image" class="card__image1" width="600">
                                    </div>
                                    <div class="card__body1">
                                        <div><i style="margin-right: 5px;" class="fa-regular fa-calendar"></i><span><%=rsNewBlog.getString(11).substring(0,10)%></span></div>
                                        <h4><%=rsNewBlog.getString(7)%></h4>
                                    </div>
                                    <div class="card__footer1">
                                        <div class="user1">
                                            <img src="images/blog_author/<%=rsNewBlog.getString(5)%>" alt="user__image" class="user__image1">
                                            <div class="user__info1"style="padding-top: 16px;">
                                                <h5><%=rsNewBlog.getString(3)%></h5>
                                                <small></small>
                                            </div>
                                        </div>
                                    </div>
                            </div>
                            </a>
                            <%}%>
                        </div>
                        <%
                         ResultSet rsFeatureBlog = (ResultSet)request.getAttribute("rsFeatureBlog");
                         while(rsFeatureBlog.next()) {
                        %>
                        <a href="blogdetail?bid=<%=rsFeatureBlog.getInt(1)%>">
                            <div class="card card-3"style="border: none;">
                                <div class="card-img"><img src="images/blog/<%=rsFeatureBlog.getString(6)%>" alt="alt"/></div>
                                <div class="card-info">
                                    <div class="card-about">
                                        <a href="blogdetail?bid=<%=rsFeatureBlog.getInt(1)%>" class="card-tag tag-deals"><i class="fa fa-star" aria-hidden="true"></i><%=rsFeatureBlog.getInt(9)%></a>
                                        <div class="card-time"><i style="margin-right: 3px;" class="fa-regular fa-calendar"></i><%=rsFeatureBlog.getString(11).substring(0,10)%></div>
                                    </div>
                                    <h1 class="card-title" style="height: 93px;"><a href="blogdetail?bid=<%=rsFeatureBlog.getInt(1)%>" style="font-size: 19px;" href="hi"><%=rsFeatureBlog.getString(7)%></a></h1>
                                    <div class="user1">
                                        <img src="images/blog_author/<%=rsFeatureBlog.getString(5)%>" alt="user__image" class="user__image1">
                                        <div class="user__info1"style="padding-top: 16px;">
                                            <h5 style="font-size: 16px;"><%=rsFeatureBlog.getString(3)%></h5>
                                            <small></small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>
                        <%}%>
                    </div>
                </div>
                <a href="blog"><div class="more-detail_1" style="box-sizing: unset;
                                    font-size: 14px;
                                    border-radius: 5px;
                                    padding-top: 5px;">Xem thêm</div></a>
            </div>
    </section>
    <footer class="footer_1">
        <div class="container_1" style="height: 270px;padding-top: 28px;">
            <div class="row_1">
                <div class="col_1" id="company">
                    <img style="width: 176px;
                         margin-bottom: -19px;
                         margin-top: 10px;height: 136px;" src="images/logo/logo.png" alt="" class="logo_1">
                    <p style="font-family: poppins;font-size: 15px;color: white;">
                        công ty Smartket Việt Nam, 54 Liễu Giai, quận Ba Đình, Hà Nội 
                    </p>
                    <div class="social_1">
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
                    </div>
                </div>


                <div class="col_1" id="services">
                    <h3 class="footer_title_1">Dịch vụ</h3>
                    <div class="links_1">
                        <a href="#">Tuyển dụng</a>
                        <a href="#">Quảng cáo</a>
                        <a href="#">Chính sách</a>
                    </div>
                </div>

                <div class="col_1" id="useful-links" style="margin-left: 50px;margin-right: 50px;">
                    <h3 class="footer_title_1">Đường dẫn</h3>
                    <div class="links_1">
                        <a href="#">Về chúng tôi</a>
                        <a href="#">Danh mục</a>
                        <a href="#">Tin tức</a>
                        <a href="#">Hỗ trợ</a>
                    </div>
                </div>

                <div class="col_1" id="contact">
                    <h3 class="footer_title_1">Liên hệ</h3>
                    <div class="contact-details_1">
                        <i class="fa-regular fa-envelope"></i>
                        <p style="color: white;">Smartket@gmail.com</p>
                    </div>
                    <div class="contact-details_1">
                        <i class="fa fa-phone"></i>
                        <p style="color: white;">+84 99.999.999</p>
                    </div>
                </div>
            </div>

            <div class="row_1">
                <div class="form_1" style="margin-top: -56px;">
                    <form action="">
                        <input class="email-input_1" style="height: 40px;" type="text" placeholder="Email here...">
                        <button class="email-button_1" style="height: 43px;padding-top: 10px;"><i class="fa fa-paper-plane"></i></button>
                    </form>
                </div>
            </div>
        </div>
    </footer>
</body>
<script src="js/script.js"></script>
<script type="text/javascript">
                                                    var counter = 1;
                                                    setInterval(function () {
                                                        document.getElementById('radio' + counter).checked = true;
                                                        counter++;
                                                        console.log(counter);
                                                        if (counter == 5) {
                                                            counter = 1;
                                                        }
                                                    }, 5000);
                                                    function alertOpenCart() {
                                                        alert('Đăng nhập để xem giỏ hàng của bạn');
                                                    }
                                                    window.onload = function () {
                                                        // Lấy giá trị của tham số section từ URL
                                                        var sectionId = '<%=request.getParameter("section") %>';

                                                        // Nếu sectionId không rỗng, thì cuộn đến phần có id tương ứng
                                                        if (sectionId) {
                                                            var targetSection = document.getElementById(sectionId);
                                                            if (targetSection) {
                                                                targetSection.scrollIntoView({behavior: 'smooth'});
                                                            }
                                                        }
                                                    };

                                                    function scrollToNew() {
                                                        // Calculate the middle of the page
                                                        const middle = window.innerHeight + 90;
                                                        // Scroll to the middle of the page
                                                        window.scrollTo({
                                                            top: middle,
                                                            behavior: 'smooth' // Optional: Add smooth scrolling effect
                                                        });
                                                    }
                                                    function scrollToFeature() {
                                                        // Calculate the middle of the page
                                                        const middle = window.innerHeight * 2.3;

                                                        // Scroll to the middle of the page
                                                        window.scrollTo({
                                                            top: middle,
                                                            behavior: 'smooth' // Optional: Add smooth scrolling effect
                                                        });
                                                    }
                                                    function scrollToBlog() {
                                                        // Calculate the middle of the page
                                                        const middle = window.innerHeight * 3;

                                                        // Scroll to the middle of the page
                                                        window.scrollTo({
                                                            top: middle,
                                                            behavior: 'smooth' // Optional: Add smooth scrolling effect
                                                        });
                                                    }
</script>
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="js_marketing/ruang-admin.min.js"></script>
<script src="js/price.js"></script>
</html>
