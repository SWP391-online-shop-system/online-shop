<%-- 
    Document   : header
    Created on : Jan 10, 2024, 9:11:45 PM
    Author     : admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                <a href="#"><i class="fa-solid fa-user"></i><span>Đăng nhập</span></a>
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
                        <li><a href="cart">Giỏ hàng của tôi</a></li>
                        <li><a href="#">Đơn hàng của tôi</a></li>
                    </ul>
                </li>
                <li><a href="#">Blog</a></li>
                <li><a href="profileUser.jsp">Tài khoản</a></li>
            </ul>
        </div>
        <div class="header-content-right-menu">
            <ul>
                <li class="margin-unit"><a href="#" title="Đơn hàng của tôi"><i class="fa-solid fa-file-invoice-dollar"></i></i></a></li>
                <li><a href="cart" title="Giỏ hàng của tôi"><i class="fa-solid fa-cart-shopping"></i></a></li>
            </ul>
        </div>
    </div>
</div>
