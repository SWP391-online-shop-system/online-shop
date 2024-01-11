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
                <!DOCTYPE html>
                <html lang="en">
                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Login Pop-up </title>
                        <link rel="stylesheet" href="css/login.css"/>
                    </head>
                    <body>
                        <button id="show-login">Đăng nhập</button>
                        <!-- Login Pop-up Form -->
                        <div class="popup" id="loginPopup">
                            <div class="close-btn" onclick="togglePopup('loginPopup')">x</div>
                            <div class="form">
                                <h2>Log in</h2>
                                <div class="form-element">
                                    <label for="email">Email</label>
                                    <input type="text" id="email" placeholder="Enter email">
                                </div>
                                <div class="form-element">
                                    <label for="password">Password</label>
                                    <input type="password" id="password" placeholder="Enter password">
                                </div>
                                <div class="form-element">
                                    <button type="submit" value="Login">Login</button>
                                </div>
                                <div class="form-element">
                                    <button id="showSignup" onclick="togglePopup('signupPopup')">Register</button>
                                </div>
                                <div class="form-element">
                                    <a href="#">Forgot password?</a>
                                </div>
                            </div>
                        </div>
                        <!-- Registration Pop-up Form -->
                        <div class="popup" id="signupPopup">
                            <div class="close-btn" onclick="togglePopup('signupPopup')">x</div>
                            <div class="form">
                                <h2>Register</h2>
                                <div class="form-element">
                                    <label for="registerEmail">Full name</label>
                                    <input type="text" id="registerFullname" placeholder="Enter full name">
                                </div>
                                <div class="form-element">
                                    <label for="registerEmail">Gender</label>
                                    <select name="Gender">
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                    </select>
                                </div>
                                <div class="form-element">
                                    <label for="registerEmail">Email</label>
                                    <input type="text" id="registerEmail" placeholder="Enter email">
                                </div>
                                <div class="form-element">
                                    <label for="registerPassword">Password</label>
                                    <input type="password" id="registerPassword" placeholder="Enter password">
                                </div>
                                <div class="form-element">
                                    <label for="registerEmail">Mobile</label>
                                    <input type="text" id="registerMobile" placeholder="Enter phone number">
                                </div>
                                <div class="form-element">
                                    <label for="registerEmail">Address</label>
                                    <input type="text" id="registerAddress" placeholder="Enter Address">
                                </div>
                                <div class="form-element">
                                    <button type="submit" value="Register">Register</button>
                                </div>
                            </div>
                        </div>
                    </body>
                    <script src="js/login.js">
                        
                    </script>
                </html>
            </div>
        </div>
    </div>
    <div class="header-content">
        <div class="header-content-logo">
            <a href="#"><img src="images/logo/logo.png"alt="404"/></a>
        </div>
        <div class="header-content-menu">
            <ul>
                <li class="active"><a href="#">Trang chủ</a></li>
                <li><a href="#">Mua hàng</a></li>
                <li>
                    <a href="#">Trang</a>
                    <ul class="header-content-menu-drop-down">
                        <li><a href="#">Giỏ hàng của tôi</a></li>
                        <li><a href="#">Đơn hàng của tôi</a></li>
                        <li><a href="#">Voucher của tôi</a></li>
                    </ul>
                </li>
                <li><a href="#">Blog</a></li>
                <li><a href="#">Tài khoản</a></li>
            </ul>
        </div>
        <div class="header-content-right-menu">
            <ul>
                <li> <a href="#" title="Voucher của tôi"><i class="fa-solid fa-ticket"></i></a></li>
                <li class="margin-unit"><a href="#" title="Đơn hàng của tôi"><i class="fa-solid fa-file-invoice-dollar"></i></i></a></li>
                <li><a href="#" title="Giỏ hàng của tôi"><i class="fa-solid fa-cart-shopping"></i></a></li>
            </ul>
        </div>
    </div>
</div>
