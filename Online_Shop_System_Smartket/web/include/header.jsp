<%-- 
    Document   : header
    Created on : Jan 10, 2024, 9:11:45 PM
    Author     : admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<div class="header">
    <div class="header-title">
        <div class="header-title-left">
            <ul>
                <li>
                    <div class="header-email">
                        <i class="fa-regular fa-envelope"></i>
                        <span class="header-email-title">SmartketServices@gmail.com</span>
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
                        %>
                        <c:if test="${sessionScope.account.roleID == 5}">
                            <a href="#">ADMIN</a>
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
                            Hello ${sessionScope.account.email}
                            <a href="logout">Đăng xuất</a>
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
                                       text-align: left;"><%=(message == null) ? "" : message%></p>
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
                                        <button type="submit" >Đăng nhập</button>
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
                                    <div class="form-element">
                                        <label for="registerEmail">Họ</label>
                                        <input type="text" name="rFName" placeholder="Nhập họ" required 
                                               oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                               oninput="setCustomValidity('')">
                                    </div>
                                    <div class="form-element">
                                        <label for="registerEmail">Tên</label>
                                        <input type="text" name="rLName" placeholder="Nhập Tên" required
                                               oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                               oninput="setCustomValidity('')">
                                    </div>
                                    <div class="form-element" style="margin-top: 28px;">
                                        <label for="registerEmail">Email</label>
                                        <input type="email" name="remail" placeholder="Nhập email"required
                                               oninvalid="this.setCustomValidity('Vui lòng điền thông tin này và bao gồm @')" 
                                               oninput="setCustomValidity('')">
                                    </div>
                                    <div class="form-element">
                                        <label for="registerPassword">Mật khẩu</label>
                                        <input type="password" name="rpass" placeholder="Nhập mật khẩu" required
                                               oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                               oninput="setCustomValidity('')">
                                    </div>
                                    <div class="form-element">
                                        <label for="registerPassword">Nhập lại mật khẩu</label>
                                        <input type="password" name="rrepass" placeholder="Nhập lại mật khẩu" required
                                               oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                               oninput="setCustomValidity('')">
                                    </div>
                                    <p class="text-danger" style="
                                       color: red;
                                       font-size: 20px;
                                       font-weight: 700;
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
                <li><a href="ProductListURL">Mua hàng</a></li>
                <li>
                    <a href="#">Trang</a>
                    <ul class="header-content-menu-drop-down">
                        <li><a href="CartURL">Giỏ hàng của tôi</a></li>
                        <li><a href="#">Đơn hàng của tôi</a></li>
                    </ul>
                </li>
                <li><a href="blog">Blog</a></li>
                <li><a href="profileUser.jsp">Tài khoản</a></li>
            </ul>
        </div>
        <div class="header-content-right-menu">
            <ul>
                <li class="margin-unit"><a href="#" title="Đơn hàng của tôi"><i class="fa-solid fa-file-invoice-dollar"></i></i></a></li>
                    <c:if test="${sessionScope.account == null}">
                    <li><a href="loginURL" onclick="alertOpenCart()" title="Giỏ hàng của tôi"><i class="fa-solid fa-cart-shopping"></i></a></li>
                        </c:if>
                        <c:if test="${sessionScope.account != null}">
                    <li><a href="CartURL" title="Giỏ hàng của tôi"><i class="fa-solid fa-cart-shopping"></i></a></li>
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
