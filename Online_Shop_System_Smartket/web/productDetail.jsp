<%-- 
    Document   : productDetail
    Created on : Feb 19, 2024, 9:39:41 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="view.User" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.DAOCart, view.Cart,view.User" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.DAOProduct"%>
<%@page import="view.Product"%>
<%@page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>product full detail - Bootdey.com</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/css_productDetail/style.css"/>
        <link rel="stylesheet" href="css/css_header/header.css"/>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" />
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>

    </head>
    <body>
        <%DecimalFormat df = new DecimalFormat("###,###");
            df.setMaximumFractionDigits(8);%>
        <!-- start header -->
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
                <div class="header-content-menu" style="padding: 67px 0px;">
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
                                <li><a href="#">Đơn hàng của tôi</a></li>
                            </ul>
                        </li>
                        <li><a href="blog">Blog</a></li>
                            <c:if test="${sessionScope.account != null}">
                            <li><a href="profileUser.jsp">Tài khoản</a></li>
                        </c:if>            </ul>
                </div>
                <div class="header-content-right-menu"style="padding: 21px 0px;">
                    <ul>
                        <li class="margin-unit"><a href="#" title="Đơn hàng của tôi"><i class="fa-solid fa-file-invoice-dollar"></i></i></a></li>
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
                                <span class="count-cart" style="margin-right: -11px;
                                      background-color: #ff0000;
                                      color: #ffffff;
                                      border-radius: 50%;
                                      padding: 0px 5px;
                                      font-size: 17px;"><%=rs.getInt(1)%></span>
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
        <!-- end header -->
        <div class="container">
            <div class="product-content product-wrap clearfix product-deatil">
                <div class="row">
                    <%
                    DAOProduct dao = new DAOProduct();
                    ResultSet rsDetail = (ResultSet)request.getAttribute("rsDetail");
                    Product newPro  = new Product();
                    List<String> listUrls = new ArrayList<>();
                    int countNode = -1;
                    %>
                    <div class="col-md-5 col-sm-12 col-xs-12">
                        <div class="product-image">
                            <div id="myCarousel-2" class="carousel slide">
                                <ol class="carousel-indicators">
                                    <%
                                    while(rsDetail.next()){
                                    newPro = dao.getProductById(rsDetail.getInt("ProductID"));
                                    listUrls.add(rsDetail.getString(13));
                                    countNode++;
                                    if(countNode==0){%>
                                    <li data-target="#myCarousel-2" data-slide-to="0" class="active"></li>
                                        <%}else{%>
                                    <li data-target="#myCarousel-2" data-slide-to="<%=countNode%>" class></li>
                                        <%}}%>
                                </ol>
                                <div class="carousel-inner">
                                    <%for (int i = 0; i < listUrls.size(); i++) {
                                    if (i == 0) { %>
                                    <div class="item active">
                                        <img src="<%=listUrls.get(i)%>" class="img-responsive" alt style="height: 335px;width: 253px;margin-left: 98px;"/>
                                    </div>
                                    <% } else { %>
                                    <div class="item">
                                        <img src="<%=listUrls.get(i)%>" class="img-responsive" alt style="height: 335px;width: 253px;margin-left: 98px;"/>
                                    </div>
                                    <%}}%>
                                </div>
                                <a class="left carousel-control" href="#myCarousel-2" data-slide="prev"> <span class="glyphicon glyphicon-chevron-left"></span> </a>
                                <a class="right carousel-control" href="#myCarousel-2" data-slide="next"> <span class="glyphicon glyphicon-chevron-right"></span> </a>
                            </div>
                        </div>
                        <div class="row">
                            <div style="text-align: center;margin-top: 23px;">
                                <a href="javascript:void(0);" class="btn btn-success btn-lg">Mua ngay</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-md-offset-1 col-sm-12 col-xs-12">
                        <h2 class="name">
                            <%=newPro.getProductName()%>
                            <small></small>
                            <%  int totalRate = 0;
                                String resultRate = "";
                                int rateCount = 0;
                                int UserRateCount = 0;
                                String description = newPro.getProductDescription().replace("@@LINEBREAK@@", "</br>");
                                System.out.println("des in jsp = "+description);
                                double realPrice =(newPro.getUnitPrice() *(100 - newPro.getUnitDiscount()) / 100) ;
                                ResultSet rsRate = (ResultSet)request.getAttribute("rsRate");
                                 if(rsRate.next()){
                                 totalRate = (int)rsRate.getDouble(2);  
                                 rateCount = (int)rsRate.getInt(3);
                                 UserRateCount = (int)rsRate.getInt(4);
                                }
                                resultRate = newPro.convertStar(totalRate);
                            %>
                            <span style="font-size: 15px; color: orange"><%=resultRate%></span>
                            <span class="fa fa-2x"><h5 style="font-size: 14px; font-family: fangsong">(<%=rateCount%>) đánh giá</h5></span>
                            <a href="javascript:void(0);" style="text-decoration: none;color: #337ab7;" ><%=UserRateCount%> Khách hàng đã đánh giá</a>
                        </h2>
                        <hr/>
                        <h3 class="price-container">
                            <%
                            if(newPro.getUnitDiscount() == 0){%>
                            <%=df.format(realPrice)%>đ
                            <%} else {%>
                            <%=df.format(realPrice)%>đ
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <span style="color: red; text-decoration: line-through"><%=df.format(newPro.getUnitPrice())%>đ</span>
                            <%}%>
                        </h3>
                        <hr/>
                        <div class="description description-tabs">
                            <ul id="myTab" class="nav nav-pills">
                                <li class="active"><a href="#more-information" data-toggle="tab" class="no-margin">Mô tả sản phẩm</a></li>
                                <li class><a href="#reviews" data-toggle="tab">Đánh giá</a></li>
                            </ul>
                            <div id="myTabContent" class="tab-content">
                                <div class="tab-pane fade active in" id="more-information">
                                    <br/>
                                    <strong><%=newPro.getProductName()%></strong>
                                    <div style="white-space: pre-line;">
                                        <%=description%>
                                    </div>

                                </div>
                                <div class="tab-pane fade" id="reviews">
                                    <br/>
                                    <div class="chat-body no-padding profile-message">
                                        <ul>
                                            <%
                                            ResultSet rsFeedBack = (ResultSet)request.getAttribute("rsFeedBack");
                                            if(!rsFeedBack.isBeforeFirst()){%>
                                            <div style="font-size: 14px;color: white;margin-left: -27px;padding: 5px 10px; background: #e9ad78;width: 260px;border-radius: 7px;">Chưa có đánh giá cho sản phẩm này</div>
                                            <%}else{
                                        while(rsFeedBack.next()){%>
                                            <li class="message">
                                                <img src="images/user/<%=rsFeedBack.getString(1)%>" class="online" />
                                                <span class="message-text">
                                                    <a href="javascript:void(0);" class="username">
                                                        <%=rsFeedBack.getString(2)%>
                                                    </a>
                                                    <%
                                                    int rateFeedBack = rsFeedBack.getInt(3);
                                                    Product proo = new Product();
                                                    String rss =proo.convertStar(rateFeedBack);
                                                    %>
                                                    <span style="color: yellow; font-size: 11px;"><%=rss%></span>
                                                    <br/>
                                                    <span><%=rsFeedBack.getString(4)%></span>
                                                </span>
                                                <ul class="list-inline font-xs" style="margin-bottom: 50px;">
                                                    <li style="float:left">
                                                        <small class="text-muted pull-right ultra-light"><%=rsFeedBack.getString(5)%> </small>
                                                    </li>
                                                </ul>
                                            </li>
                                            <%}}%>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr/>
                    </div>
                </div>
            </div>

        </div>
        <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
        <script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <script type="text/javascript">

        </script>
    </body>
</html>