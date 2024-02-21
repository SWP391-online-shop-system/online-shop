<%-- 
    Document   : marketing_dashboard
    Created on : Feb 1, 2024, 10:24:26 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.DAOBlog"%>
<%@page import="model.DAOProduct"%>
<%@page import="model.DAOUser"%>
<%@page import="model.DAOFeedBack"%>
<%@page import="view.Product"%>
<%@page import="view.User"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <link href="images/logo/logo.png" rel="icon">
        <title>Trang marketing</title>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/css_marketing_dashboard/marketing_dashboard_style.css" rel="stylesheet">

    </head>

    <body id="page-top">
        <%
        DAOBlog daoBlog = new DAOBlog();
        DAOProduct daoPro = new DAOProduct();
        DAOUser daoUser = new DAOUser();
        DAOFeedBack daoFeedBack = new DAOFeedBack();
        %>
        <div id="wrapper">
            <!-- Sidebar -->
            <ul class="navbar-nav sidebar sidebar-light accordion" id="accordionSidebar">
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
                    <div class="sidebar-brand-icon">
                        <img style="height: 91px;
                             width: 133px;
                             margin-bottom: -18px;" src="images/logo/logo.png">
                    </div>
                </a>
                <div style="position: sticky; top: 30px;">
                    <hr class="sidebar-divider wee-0" style="margin: 0px;">
                    <li class="nav-item active">
                        <a class="nav-link" href="index.html">
                            <i class="fas fa-fw fa-tachometer-alt"></i>
                            <span>Thống kê</span></a>
                    </li>
                    <hr class="sidebar-divider">
                    <div class="sidebar-heading">
                        Quản lí
                    </div>
                    <li class="nav-item">
                        <a class="nav-link" href="ui-colors.html">
                            <i class="fas fa-calendar fa-2x text-primary"></i>
                            <span>Bài đăng</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ui-colors.html">
                            <i class="fas fa-shopping-cart fa-2x text-success"></i>
                            <span>Sản phẩm</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ui-colors.html">
                            <i class="fas fa-users fa-2x text-info"></i>
                            <span>Khách hàng</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ui-colors.html">
                            <i class="fas fa-comments fa-2x text-info"></i>
                            <span>Phản hồi</span>
                        </a>
                    </li>
                    <hr class="sidebar-divider">
                </div>
            </ul>
            <!-- Sidebar -->
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <!-- TopBar -->
                    <nav class="navbar navbar-expand navbar-light bg-navbar topbar mb-4 static-top">
                        <div style="font-weight: 700;color: white;font-size: 37px;letter-spacing: 2px;font-family: Nunito,-apple-system,BlinkMacSystemFont"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";">Trang marketing</div>
                        <ul class="navbar-nav ml-auto">
                            <div class="topbar-divider d-none d-sm-block"></div>
                            <li class="nav-item dropdown no-arrow">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown"
                                   aria-haspopup="true" aria-expanded="false">
                                    <img class="img-profile rounded-circle" src="images/user/${sessionScope.account.userImage}" style="max-width: 60px">
                                    <span class="ml-2 d-none d-lg-inline text-white small">${sessionScope.account.firstName}&nbsp;${sessionScope.account.lastName}</span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Hồ sơ
                                    </a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="logout">
                                        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Đăng xuất
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </nav>
                    <!-- Topbar -->

                    <!-- Container Fluid-->
                    <div class="container-fluid" id="container-wrapper">
                        <div class="d-sm-flex align-items-center justify-content-between mb-4">
                            <h1 class="h3 mb-0 text-gray-800">Thống kê</h1>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="./">Trang chủ</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Thống kê</li>
                            </ol>
                        </div>

                        <div class="row mb-3">
                            <!-- Earnings (Monthly) Card Example -->
                            <div class="col-xl-3 col-md-6 mb-4">
                                <a href="1" style="text-decoration: none;">
                                    <div class="card h-100">
                                        <div class="card-body">
                                            <div class="row align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-uppercase mb-1">Bài đăng</div>
                                                    <%
                                                    ResultSet rsBlogCount = (ResultSet)request.getAttribute("rsBlogCount");
                                                    if(rsBlogCount.next()){%>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800"><%=rsBlogCount.getInt(1)%>&nbsp;bài viết</div>
                                                    <%}
                                                    ResultSet rsCountTrendBlog = daoBlog.getData("select count(BlogID) from Blog where CreateTime between (curdate() - interval 6 day) and  curdate()");
                                                    if(rsCountTrendBlog.next()){
                                                    if(rsCountTrendBlog.getInt(1)==0){%>
                                                    <div class="mt-2 mb-0 text-muted text-xs">
                                                        <span class="text-warning mr-2">Không có bài viết nào</span></br>
                                                        <span>trong tuần này</span>
                                                    </div>
                                                    <%}else{%>
                                                    <div class="mt-2 mb-0 text-muted text-xs">
                                                        <span class="text-success mr-2"><i class="fa fa-arrow-up"></i>&nbsp;<%=rsCountTrendBlog.getInt(1)%>&nbsp;bài viết</span></br>
                                                        <span>trong tuần này</span>
                                                    </div>
                                                    <%}}%>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-calendar fa-2x text-primary"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <!-- Earnings (Annual) Card Example -->
                            <div class="col-xl-3 col-md-6 mb-4">
                                <a href="2" style="text-decoration: none;">
                                    <div class="card h-100">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-uppercase mb-1">Sản phẩm</div>
                                                    <%
                                                    ResultSet rsProductCount = (ResultSet)request.getAttribute("rsProductCount");
                                                    if(rsProductCount.next()) {%>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800"><%=rsProductCount.getInt(1)%>&nbsp;sản phẩm</div>
                                                    <%}
                                                    ResultSet rsProductTrend = daoPro.getData("select count(ProductID) from Product where CreateDate between (curdate() - interval 6 day) and  curdate();");
                                                    if(rsProductTrend.next()){
                                                    if(rsProductTrend.getInt(1) == 0){%>
                                                    <div class="mt-2 mb-0 text-muted text-xs">
                                                        <span class="text-warning mr-2">Không có sản phẩm nào</span></br>
                                                        <span>Trong tuần này</span>
                                                    </div>
                                                    <%}else{%>
                                                    <div class="mt-2 mb-0 text-muted text-xs">
                                                        <span class="text-success mr-2"><i class="fas fa-arrow-up">&nbsp;<%=rsProductTrend.getInt(1)%>&nbsp;sản phẩm mới</i></span></br>
                                                        <span>Trong tuần này</span>
                                                    </div>
                                                    <%}}%>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-shopping-cart fa-2x text-success"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <!-- New User Card Example -->
                            <div class="col-xl-3 col-md-6 mb-4">
                                <a href="3" style="text-decoration: none;">
                                    <div class="card h-100">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-uppercase mb-1">Khách hàng</div>
                                                    <%
                                                    ResultSet rsUserCount = (ResultSet)request.getAttribute("rsUserCount");
                                                    if(rsUserCount.next()) {%>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800"><%=rsUserCount.getInt(1)%>&nbsp;khách hàng</div>
                                                    <%}
                                                    ResultSet rsUserTrend = daoUser.getData("select count(UserID) from User where CreateDate between (curdate() - interval 6 day) and  curdate() and UserStatus = 1 and RoleID = 1;");
                                                    if(rsUserTrend.next()){
                                                    if(rsUserTrend.getInt(1) == 0) {%>
                                                    <div class="mt-2 mb-0 text-muted text-xs">
                                                        <span class="text-warning mr-2">Không có khách hàng nào</span></br>
                                                        <span>Trong tuần này</span>
                                                    </div>
                                                    <%} else {%>
                                                    <div class="mt-2 mb-0 text-muted text-xs">
                                                        <span class="text-success mr-2"><i class="fas fa-arrow-up">&nbsp;<%=rsUserTrend.getInt(1)%>&nbsp;khách hàng mới</i></span></br>
                                                        <span>Trong tuần này</span>
                                                    </div>
                                                    <%}}%>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-users fa-2x text-info"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <!-- Pending Requests Card Example -->
                            <div class="col-xl-3 col-md-6 mb-4">
                                <a href="4" style="text-decoration: none;">
                                    <div class="card h-100">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-uppercase mb-1">Phản hồi</div>
                                                    <%
                                                    ResultSet rsFeedBackCount = (ResultSet)request.getAttribute("rsFeedBackCount");
                                                    if(rsFeedBackCount.next()) {%>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800"><%=rsFeedBackCount.getInt(1)%>&nbsp;Phản hồi</div>
                                                    <%}
                                                    ResultSet rsFeedBackTrend = daoFeedBack.getData("select count(FeedBackID) from FeedBack where FeedBackDate between (curdate() - interval 6 day) and  now()");
                                                    if(rsFeedBackTrend.next()){
                                                    if(rsFeedBackTrend.getInt(1) == 0) {%>
                                                    <div class="mt-2 mb-0 text-muted text-xs">
                                                        <span class="text-warning mr-2">Không có phản hồi nào</span></br>
                                                        <span>Trong tuần này</span>
                                                    </div>
                                                    <%} else {%>
                                                    <div class="mt-2 mb-0 text-muted text-xs">
                                                        <span class="text-success mr-2"><i class="fas fa-arrow-up">&nbsp;<%=rsFeedBackTrend.getInt(1)%>&nbsp;Phản hồi mới</i></span></br>
                                                        <span>Trong tuần này</span>
                                                    </div>
                                                    <%}}%>

                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-comments fa-2x text-info"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>

                        <!-- Area Chart -->
                        <div style="display: flex;">
                            <div class="col-xl-8 col-lg-7">
                                <div class="card mb-4">
                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <div class="m-0 font-weight-bold text-primary">Thống kê sản phẩm từng tuần</div>
                                        <%
                                        String formatWeekFrom = (String)request.getAttribute("formatWeekFrom");
                                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                        Date currentDate = new Date();
                                        String curDate = dateFormat.format(currentDate);
                                        
                                       String formatUserWeekFrom = (String)request.getAttribute("formatUserWeekFrom");
                                       SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
                                       Date currentDate1 = new Date();
                                       String curDate1 = dateFormat1.format(currentDate1);
                                        %>
                                        <span  class="m-0 text-primary" style="margin-right: -12px;" >từ</span>
                                        <form action="MarketingDashBoardURL" method="GET">
                                            <input style="background-color: #1ab365!important;" id="dateInputFrom" class="date-chooser" type="date" name="weekFrom" value="<%=(formatWeekFrom==null || formatWeekFrom.equals(""))?curDate:formatWeekFrom%>" onchange="autoUpdateWeekTo(this.value);this.form.submit();"/>
                                            <span  class="m-0 text-primary">đến</span>
                                            <input style="background-color: #1ab365!important;" id="dateInputTo" class="date-chooser" type="date" name="weekTo" disabled/>                                           
                                            <input type="hidden" name="userWeekFrom" value="<%=(formatUserWeekFrom==null || formatUserWeekFrom.equals(""))?curDate1:formatUserWeekFrom%>"/>
                                        </form>
                                        <%
                                        ResultSet rsProductSold = (ResultSet)request.getAttribute("rsProductSold");
                                        int countDate=0;
                                        while(rsProductSold.next()) {
                                        System.out.println("rsProductSold = "+rsProductSold.getInt(2)+" at day "+rsProductSold.getString(1));
                                        countDate++;
                                        %>
                                        <div id="DataSold<%=countDate%>" style="display: none;"><%=rsProductSold.getInt(2)%></div>
                                        <%}%>
                                        <div id="dateList" style="display: none;"></div>
                                        <div class="dropdown no-arrow">
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="chart-area">
                                            <canvas id="myAreaChart"></canvas>
                                            <script>
                                                window.addEventListener('load', function () {
                                                    drawChart();
                                                });
                                            </script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Pie Chart -->
                            <div class="col-xl-4 col-lg-5">
                                <div class="card mb-4">
                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="m-0 font-weight-bold text-primary">Sản phẩm đã bán</h6>
                                        <div class="dropdown no-arrow"></div>
                                    </div>
                                    <%
                                    int percent = 0;
                                    ResultSet rsSellProduct = (ResultSet)request.getAttribute("rsSellProduct");
                                    if(!rsSellProduct.isBeforeFirst()){%>
                                    <div>Chưa có sản phẩm nào được mua</div>
                                    <%}else {
                                    while(rsSellProduct.next()){
                                    percent = (int) ((double) rsSellProduct.getInt(2) / rsSellProduct.getInt(3) * 100);
                                    System.out.println("percent of "+rsSellProduct.getString(1) +" = "+percent);
                                    %>
                                    <div class="card-body" style="padding:8px;">
                                        <div class="mb-3">
                                            <div class="small text-gray-500" style="font-weight: 500;"><%=rsSellProduct.getString(1)%>
                                                <div class="small float-right"><b><%=rsSellProduct.getInt(2)%>/<%=rsSellProduct.getInt(3)%>&nbsp;đã bán</b></div>
                                            </div>
                                            <div class="progress" style="height: 12px;">
                                                <div class="progress-bar bg-success" role="progressbar" style="width: <%=percent%>%" aria-valuenow="<%=percent%>"
                                                     aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <%}}%>

                                    <div class="card-footer text-center">
                                        <a class="m-0 small text-primary card-link" href="#">Quản lí ngay <i
                                                class="fas fa-chevron-right"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Invoice Example -->
                        <div style="display: flex;">
                            <div class="col-xl-8 col-lg-7 mb-4">
                                <div class="card">
                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="m-0 font-weight-bold text-primary">Khách hàng mới</h6>
                                        <span  class="m-0 text-primary">từ</span>
                                        <form action="MarketingDashBoardURL" method="GET">
                                            <input style="background-color: #1ab365!important;" id="dateUserInputFrom" class="date-chooser" type="date" name="userWeekFrom" value="<%=(formatUserWeekFrom==null || formatUserWeekFrom.equals(""))?curDate1:formatUserWeekFrom%>" onchange="autoUpdateWeekToUser(this.value);

                                                    this.form.submit();"/>
                                            <span class="m-0 text-primary">đến</span>
                                            <input style="background-color: #1ab365!important;"class="date-chooser" type="date" name="userWeekTo" disabled/>
                                            <input type="hidden" name="weekFrom" value="<%=(formatWeekFrom==null || formatWeekFrom.equals(""))?curDate:formatWeekFrom%>"  />
                                        </form>
                                        <a class="m-0 float-right btn btn-danger btn-sm" href="#">Quản lí ngay
                                            <i class="fas fa-chevron-right" style="margin-left: 8px;"></i></a>
                                    </div>
                                    <div class="table-responsive">
                                        <%
                                        ResultSet rsUserList = (ResultSet)request.getAttribute("rsUserList");
                                        if(!rsUserList.isBeforeFirst()) {%>
                                        <div style="color:orange;text-align: center;">Không có khách hàng mới trong tuần này</div>
                                        <%} else{%>
                                        <table class="table align-items-center table-flush">
                                            <thead class="thead-light">
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Tên</th>
                                                    <th>Email</th>
                                                    <th style="padding-right: 0px;">Trạng thái</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%while(rsUserList.next()){%>
                                                <tr>
                                                    <td class="id-style"><a href="#"><%=rsUserList.getInt(1)%></a></td>
                                                    <td><%=rsUserList.getString(2)+" "+rsUserList.getString(3)%></td>
                                                    <td><%=rsUserList.getString(10)%></td>
                                                    <td><%=daoUser.convertStatus(rsUserList.getInt(12))%></td>
                                                </tr>
                                                <%}}%>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="card-footer"></div>
                                </div>
                            </div>
                            <!-- Message From Customer-->
                            <div class="col-xl-4 col-lg-5 ">
                                <div class="card">
                                    <div class="card-header py-4 bg-primary d-flex flex-row align-items-center justify-content-between" style="background-color: #1ab365!important;">
                                        <h6 class="m-0 font-weight-bold text-light" style="color: #ffffff!important;">Phản hồi mới</h6>
                                    </div>
                                    <%
                                    ResultSet rsNewFeedBack = (ResultSet)request.getAttribute("rsNewFeedBack");
                                    if(!rsNewFeedBack.isBeforeFirst()) {%>
                                    <div>Chưa có phản hồi nào</div>
                                    <%}else{
                                        while(rsNewFeedBack.next()){%>
                                    <div class="customer-message align-items-center">
                                        <a href="#" style="font-weight: 500;" >
                                            <div class="text-truncate message-title"><%=rsNewFeedBack.getString(5)%>
                                            </div>
                                            <div class="small text-gray-500 message-time" style="font-weight: 500"><%=rsNewFeedBack.getString(4)%>&nbsp;·&nbsp;<%=rsNewFeedBack.getString(7)%></div></br>
                                            <%
                                            int star = (int)rsNewFeedBack.getInt(6);
                                            Product pro = new Product();
                                             String totalRate = pro.convertStar(star);
                                            %>
                                            <div style="   color: #f8f850;font-size: 12px;margin-top: -22px;margin-left: 20px;"><%=totalRate%></div>
                                        </a>
                                    </div>
                                    <%}}%>
                                    <div>
                                        <div class="card-footer text-center">
                                            <a class="m-0 small text-primary card-link" href="#">Quản lí ngay
                                                <i class="fas fa-chevron-right"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Row-->
                </div>
                <!---Container Fluid-->
            </div>
        </div>

        <!-- Scroll to top -->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
        <script src="js_marketing/ruang-admin.min.js"></script>
        <script src="vendor/chart.js/Chart.min.js"></script>
        <script src="js_marketing/demo/chart-area-demo.js"></script>  
    </body>

</html>