<%-- 
    Document   : marketing_dashboard
    Created on : Feb 1, 2024, 10:24:26 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.*"%>
<%@page import="view.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <link href="images/logo/logo.png" rel="icon">
        <title>Trang Admin</title>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/css_marketing_dashboard/marketing_dashboard_style.css" rel="stylesheet">
        <style>
            .trans{
                transition: all 0.5s;
            }
            .trans:hover{
                transform: scale(1.1);
            }
            .select-opt{
                width: 153px;
                margin-left: 18px;
                padding-top: 0px;
                height: 28px;
                position: relative;
                top: 2px;
                border-radius: 4px;
                font-size: 14px;
                padding-left: 4px;
                background: #f4fff9;
                border: 1px solid green;
            }
            .card .table td, .card .table th {

            }
        </style>
    </head>
    <body id="page-top">
        <%DecimalFormat df = new DecimalFormat("###,###");
         df.setMaximumFractionDigits(8);
         DAOProduct daoPro = new DAOProduct();
         DAOUser daoUser = new DAOUser();
         DAOOrder daoOrd = new DAOOrder();
         DAORole daoRole = new DAORole();
         ResultSet rsOrderProcessCount = (ResultSet)request.getAttribute("rsOrderProcessCount");
         ResultSet rsOrderShippingCount = (ResultSet)request.getAttribute("rsOrderShippingCount");
         ResultSet rsOrderSuccessCount = (ResultSet)request.getAttribute("rsOrderSuccessCount");
         ResultSet rsOrderFailedCount = (ResultSet)request.getAttribute("rsOrderFailedCount");
         ResultSet rsTotalPrice =(ResultSet)request.getAttribute("rsTotalPrice");
         ResultSet rsCountTrendOrderProcess = daoOrd.getData("select count(OrderID) from `Order` where StatusID = 1 and OrderDate between (curdate() - interval 6 day) and  now();");
         ResultSet rsCountTrendOrderShipping = daoOrd.getData("select count(OrderID) from `Order` where StatusID = 3 and OrderDate between (curdate() - interval 6 day) and  now();");
         ResultSet rsCountTrendOrderSuccess = daoOrd.getData("select count(OrderID) from `Order` where StatusID = 4 and OrderDate between (curdate() - interval 6 day) and  now();");
         ResultSet rsCountTrendOrderFailed = daoOrd.getData("select count(OrderID) from `Order` where StatusID = 5 and OrderDate between (curdate() - interval 6 day) and  now()");
         ResultSet rsFilterOrder =(ResultSet)request.getAttribute("rsFilterOrder");
        %>
        <div id="wrapper">
            <!-- Sidebar -->
            <ul class="navbar-nav sidebar sidebar-light accordion" id="accordionSidebar">
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="MarketingDashBoardURL">
                    <div class="sidebar-brand-icon">
                        <img style="height: 91px;
                             width: 133px;
                             margin-bottom: -18px;" src="images/logo/logo.png">
                    </div>
                </a>
                <div style="position: sticky; top: 30px;">
                    <hr class="sidebar-divider wee-0" style="margin: 0px;">
                    <li class="nav-item active">
                        <a class="nav-link" href="MarketingDashBoardURL">
                            <i class="fas fa-fw fa-tachometer-alt"></i>
                            <span>Thống kê</span></a>
                    </li>
                    <hr class="sidebar-divider">
                    <li class="nav-item">
                        <a class="nav-link" href="adminOrderTrackURL?status=all&orderFrom=&orderTo=">
                            <i class="fas fa-calendar fa-2x text-primary"></i>
                            <span>Đơn hàng</span>
                        </a>
                    </li>
                </div>
            </ul>
            <!-- Sidebar -->
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <!-- TopBar -->
                    <nav class="navbar navbar-expand navbar-light bg-navbar topbar mb-4 static-top">
                        <div style="font-weight: 700;color: white;font-size: 37px;letter-spacing: 2px;font-family: Nunito,-apple-system,BlinkMacSystemFont"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";">Trang Admin</div>
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
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Cài đặt
                                    </a>
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Lịch sử thay đổi
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
                            <div class="col-xl-3 col-md-6 mb-4 trans">
                                <a href="adminOrderTrackURL?status=1&orderFrom=&orderTo=" style="text-decoration: none;">
                                    <div class="card h-100" style="background: #fff8ee;">
                                        <div class="card-body">
                                            <div class="row align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-uppercase mb-1">Đơn chờ xác nhận</div>
                                                    <%
                                                    if(rsOrderProcessCount.next()){%>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800" style="font-size: 17px;"><%=rsOrderProcessCount.getInt(1)%>&nbsp;đơn hàng</div>
                                                    <%}
                                                    if(rsCountTrendOrderProcess.next()){
                                                    if(rsCountTrendOrderProcess.getInt(1)==0){%>
                                                    <div class="mt-2 mb-0 text-muted text-xs">
                                                        <span class="text-warning mr-2">Không có đơn hàng nào</span></br>
                                                        <span>trong tuần này</span>
                                                    </div>
                                                    <%}else{%>
                                                    <div class="mt-2 mb-0 text-muted text-xs">
                                                        <span class="text-success mr-2"><i class="fa fa-arrow-up"></i>&nbsp;<%=rsCountTrendOrderProcess.getInt(1)%>&nbsp;đơn hàng</span></br>
                                                        <span>trong tuần này</span>
                                                    </div>
                                                    <%}}%>
                                                </div>
                                                <div class="col-auto">
                                                    <img src="images/logo/orderStatus1.png" style="width: 109px;height: 109px;position: absolute;top: -70px;left: -67px;"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <!-- Earnings (Annual) Card Example -->
                            <div class="col-xl-3 col-md-6 mb-4 trans">
                                <a href="adminOrderTrackURL?status=3&orderFrom=&orderTo=" style="text-decoration: none;">
                                    <div class="card h-100" style="background: #e6ecff;">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-uppercase mb-1">Đơn đang giao</div>
                                                    <%
                                                    if(rsOrderShippingCount.next()) {%>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800" style="font-size: 17px;"><%=rsOrderShippingCount.getInt(1)%>&nbsp;đơn hàng</div>
                                                    <%}
                                                    if(rsCountTrendOrderShipping.next()){
                                                    if(rsCountTrendOrderShipping.getInt(1) == 0){%>
                                                    <div class="mt-2 mb-0 text-muted text-xs">
                                                        <span class="text-warning mr-2">Không có đơn hàng nào</span></br>
                                                        <span>Trong tuần này</span>
                                                    </div>
                                                    <%}else{%>
                                                    <div class="mt-2 mb-0 text-muted text-xs">
                                                        <span class="text-success mr-2"><i class="fas fa-arrow-up">&nbsp;<%=rsCountTrendOrderShipping.getInt(1)%>&nbsp;đơn hàng</i></span></br>
                                                        <span>Trong tuần này</span>
                                                    </div>
                                                    <%}}%>
                                                </div>
                                                <div class="col-auto">
                                                    <img src="images/logo/orderStatus3.png" style="width: 75px;height: 75px;position: absolute;top: -56px;left: -69px;"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <!-- New User Card Example -->
                            <div class="col-xl-3 col-md-6 mb-4 trans">
                                <a href="adminOrderTrackURL?status=4&orderFrom=&orderTo=" style="text-decoration: none;">
                                    <div class="card h-100" style="background: #d9ffda;">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-uppercase mb-1">Đơn thành công</div>
                                                    <%
                                                    if(rsOrderSuccessCount.next()) {%>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800" style="font-size: 17px;"><%=rsOrderSuccessCount.getInt(1)%>&nbsp;đơn hàng</div>
                                                    <%}
                                                    if(rsCountTrendOrderSuccess.next()){
                                                    if(rsCountTrendOrderSuccess.getInt(1) == 0) {%>
                                                    <div class="mt-2 mb-0 text-muted text-xs">
                                                        <span class="text-warning mr-2">Không có đơn hàng nào</span></br>
                                                        <span>Trong tuần này</span>
                                                    </div>
                                                    <%} else {%>
                                                    <div class="mt-2 mb-0 text-muted text-xs">
                                                        <span class="text-success mr-2"><i class="fas fa-arrow-up">&nbsp;<%=rsCountTrendOrderSuccess.getInt(1)%>&nbsp;đơn hàng</i></span></br>
                                                        <span>Trong tuần này</span>
                                                    </div>
                                                    <%}}%>
                                                </div>
                                                <div class="col-auto">
                                                    <img src="images/logo/orderStatus4.png" style="width: 109px;height: 109px;position: absolute;top: -70px;right: -35px;"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <!-- Pending Requests Card Example -->
                            <div class="col-xl-3 col-md-6 mb-4 trans">
                                <a href="adminOrderTrackURL?status=5&orderFrom=&orderTo=" style="text-decoration: none;">
                                    <div class="card h-100" style="background: #fff1f1;">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-uppercase mb-1">Đơn bị hủy</div>
                                                    <%
                                                    if(rsOrderFailedCount.next()) {%>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800" style="font-size: 17px;"><%=rsOrderFailedCount.getInt(1)%>&nbsp;Đơn hàng</div>
                                                    <%}
                                                    if(rsCountTrendOrderFailed.next()){
                                                    if(rsCountTrendOrderFailed.getInt(1) == 0) {%>
                                                    <div class="mt-2 mb-0 text-muted text-xs">
                                                        <span class="text-warning mr-2">Không có đơn hàng nào</span></br>
                                                        <span>Trong tuần này</span>
                                                    </div>
                                                    <%} else {%>
                                                    <div class="mt-2 mb-0 text-muted text-xs">
                                                        <span class="text-success mr-2"><i class="fas fa-arrow-up">&nbsp;<%=rsCountTrendOrderFailed.getInt(1)%>&nbsp;Đơn hàng</i></span></br>
                                                        <span>Trong tuần này</span>
                                                    </div>
                                                    <%}}%>
                                                </div>
                                                <div class="col-auto">
                                                    <img src="images/logo/orderStatus5.png" style="width: 109px;height: 109px;position: absolute;top: -70px;right: -33px;"/>
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
                                        <div class="m-0 font-weight-bold text-primary">Thống kê doanh thu từng tuần</div>
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
                                        <form action="adminDashBoard" method="GET">
                                            <input style="background-color: #1ab365!important;" id="dateInputFrom" class="date-chooser" type="date" name="weekFrom" value="<%=(formatWeekFrom==null || formatWeekFrom.equals(""))?curDate:formatWeekFrom%>" onchange="autoUpdateWeekTo(this.value); updateWeek();"/>
                                            <span  class="m-0 text-primary">đến</span>
                                            <input style="background-color: #1ab365!important;" id="dateInputTo" class="date-chooser" type="date" name="weekTo" disabled/>                                           
                                            <input type="hidden" name="userWeekFrom" value="<%=(formatUserWeekFrom==null || formatUserWeekFrom.equals(""))?curDate1:formatUserWeekFrom%>"/>
                                            <input type="hidden" name="filterValue" value=""/>
                                        </form>

                                        <%
                                        ResultSet rsProductSold = (ResultSet)request.getAttribute("rsProductSold");
                                        int countDate=0;
                                        while(rsProductSold.next()) {
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

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Pie Chart -->
                            <div class="col-xl-4 col-lg-5" style="height: 424px; overflow-y: scroll;">
                                <div class="card mb-4">
                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="m-0 font-weight-bold text-primary">Doanh thu tổng: 
                                            <span>
                                                <%if(rsTotalPrice.next()){%>
                                                <%=df.format(rsTotalPrice.getInt(1))%>đ
                                                <%}%>
                                            </span>
                                        </h6>
                                        <div class="dropdown no-arrow"></div>
                                    </div>
                                    <%
                                    int percent = 0;
                                    ResultSet rsSellProduct = (ResultSet)request.getAttribute("rsSellProduct");
                                    if(!rsSellProduct.isBeforeFirst()){%>
                                    <div>Chưa có sản phẩm nào được mua</div>
                                    <%}else {
                                    while(rsSellProduct.next()){
                                    percent = (int) ((double) rsSellProduct.getInt("sold") / rsSellProduct.getInt("stock") * 100);
                                    %>
                                    <div class="card-body" style="padding:8px;">
                                        <div class="mb-3">
                                            <div class="small text-gray-500" style="font-weight: 500;<%=rsSellProduct.getBoolean(4)?"color: red !important;":"color: #92b492 !important;"%>"
                                                 <%=rsSellProduct.getBoolean(4)?"title=\"Đã vô hiệu hóa\"":"title=\"Đang hoạt động\""%>><%=rsSellProduct.getString("CategoryName")%>
                                                <div class="small float-right"><b><%=rsSellProduct.getInt("sold")%>/<%=rsSellProduct.getInt("stock")%>&nbsp;đã bán</b></div>
                                            </div>
                                            <div class="progress" style="height: 12px;">
                                                <div class="progress-bar bg-success" role="progressbar" style="width: <%=percent%>%" aria-valuenow="<%=percent%>"
                                                     aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <%}}%>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Invoice Example -->
                    <div style="display: flex;">
                        <div class="col-xl-8 col-lg-7 mb-4">
                            <div class="card" style="height: 534px;">
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">Nguời dùng</h6>
                                    <span  class="m-0 text-primary">từ</span>
                                    <form action="AdminDashBoardURLA" method="GET">
                                        <input style="background-color: #1ab365!important;" id="dateUserInputFrom" class="date-chooser" type="date" name="userWeekFrom" value="<%=(formatUserWeekFrom==null || formatUserWeekFrom.equals(""))?curDate1:formatUserWeekFrom%>" 
                                               onchange="autoUpdateWeekToUser(this.value);updateWeek();"/>
                                        <span class="m-0 text-primary">đến</span>
                                        <input style="background-color: #1ab365!important;"class="date-chooser" type="date" name="userWeekTo" disabled/>
                                        <input type="hidden" name="weekFrom" value="<%=(formatWeekFrom==null || formatWeekFrom.equals(""))?curDate:formatWeekFrom%>"  />
                                        <%String filter = (String)request.getAttribute("filterValue");%>
                                        <select id="ft" class="select-opt" name="filterValue" onchange="updateWeek();">
                                            <option value="filterAll" <%=filter.equals("filterAll")?"selected":""%>>Tất cả</option>
                                            <option value="newlyRegister" <%=filter.equals("newlyRegister")?"selected":""%>>Mới đăng ký</option>
                                            <option value="newlyBought" <%=filter.equals("newlyBought")?"selected":""%>>Mới đặt hàng</option>
                                        </select>
                                    </form>
                                </div>
                                <div class="table-responsive">
                                    <%
                                    ResultSet rsUserList = (ResultSet)request.getAttribute("rsUserList");
                                    if(!rsUserList.isBeforeFirst()) {%>
                                    <div style="color:orange;text-align: center;">Không có khách hàng mới trong tuần này</div>
                                    <%} else{%>
                                    <table class="table align-items-center table-flush" style="font-size: 14px;">
                                        <thead class="thead-light">
                                            <tr style="position: sticky;top: 0px;">
                                                <th>ID</th>
                                                <th>Tên</th>
                                                <th style=" padding-left: 0px;
                                                    padding-right: 0px;">Email</th>
                                                <th style="
                                                    padding-right: 0px;">Trạng thái</th>
                                                <th style=" padding-left: 0px;
                                                    padding-right: 0px;">Chức vụ</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%while(rsUserList.next()){
                                            Role role = daoRole.getRoleById(rsUserList.getInt("RoleID"));
                                            %>
                                            <tr style="<%if(rsUserList.getInt("RoleID")==4||rsUserList.getInt("RoleID")==3||rsUserList.getInt("RoleID")==2){%>
                                                background: #d9ffea;font-weight: 700;
                                                <%}%>"">
                                                <td class="id-style"><a href="#"><%=rsUserList.getInt(1)%></a></td>
                                                <td><%=rsUserList.getString(2)+" "+rsUserList.getString(3)%></td>
                                                <td style=" padding-left: 0px;
                                                    padding-right: 0px;"><%=rsUserList.getString(10)%></td>
                                                <td><%=daoUser.convertStatus(rsUserList.getInt(12))%></td>
                                                <td style="padding-left: 0px;padding-right: 7px;"><%=role.getRoleName()%></td>
                                            </tr>
                                            <%}%>
                                        </tbody>
                                    </table>
                                </div>
                                <div>
                                    <div class="card-footer text-center" style="font-size: 18px;height: 37px;">
                                        <a class="m-0 small text-primary card-link" href="FeedBackListURL">Quản lí ngay
                                            <i class="fas fa-chevron-right"></i></a>
                                    </div>
                                    <%}%>
                                </div>
                                <div class="card-footer"></div>
                            </div>
                        </div>
                        <!-- Message From Customer-->
                        <div class="col-xl-4 col-lg-5 ">
                            <div class="card">
                                <%ResultSet rsTotalRate = daoOrd.getData("select c.*, avg(p.TotalRate) as rate from Product as p "
                                            + "join Categories as c on p.CategoryID = c.CategoryID group by c.CategoryID;");
                                ResultSet rsTotalRate2 = daoOrd.getData("select c.*, avg(p.TotalRate) as rate from Product as p "
                                            + "join Categories as c on p.CategoryID = c.CategoryID group by c.CategoryID;");
                                            double rate = 0;
                                            int countAvg = 0;
                                    while(rsTotalRate.next()){
                                        countAvg++;
                                        rate += (double)rsTotalRate.getInt("rate"); 
                                        }%>
                                <div class="card-header py-4 bg-primary d-flex flex-row align-items-center justify-content-between" style="background-color: #1ab365!important;padding: 0 25px;">
                                    <h6 class="m-0 font-weight-bold text-light" style="color: #ffffff!important; text-align: center;font-size: 17px;">Tổng số nhận xét phản hồi: <span style="color: yellow;padding-left: 3px;"><%=(double)(rate/countAvg)%></span><i class="fa fa-star" aria-hidden="true" style="color:yellow;padding-left: 2px;  "></i></h6>
                                </div>
                                <%
                                if(!rsTotalRate2.isBeforeFirst()) {%>
                                <div>Chưa có phản hồi nào</div>
                                <%}else{
                                        while(rsTotalRate2.next()){%>
                                <div class="customer-message align-items-center">
                                    <a style="font-weight: 500;" >
                                        <div class="text-truncate message-title"><%=rsTotalRate2.getString(2)%>
                                        </div>
                                        <%
                                        int star = (int)rsTotalRate2.getInt(5);
                                        Product pro = new Product();
                                         String totalRate = pro.convertStar(star);
                                        %>
                                        <div style="color: #e9c300;
                                             font-size: 12px;
                                             margin-top: -22px;
                                             margin-left: 244px;"><%=totalRate%></div>
                                    </a>
                                </div>
                                <%}}%>
                                <div>
                                    <div class="card-footer text-center">
                                        <a class="m-0 small text-primary card-link" href="FeedBackListURL">Quản lí ngay
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
    <script>
        window.addEventListener('load', function () {
            drawChart();
        });
        function updateWeek() {
            var weekFrom = document.getElementById("dateInputFrom").value;
            var userWeekFrom = document.getElementById("dateUserInputFrom").value;
            var filter = document.getElementById("ft").value;
            console.log("chart = " + weekFrom + " and user = " + userWeekFrom + " and filter = " + filter);
            $.ajax({
                url: "AdminDashBoardURL",
                type: 'GET',
                data: {weekFrom: weekFrom, userWeekFrom: userWeekFrom, filterValue: filter},
                success: function (data) {
                    // Update specific element in the JSP with the new data
                    $("#page-top").html(data);
                    drawChart();
                },
                error: function (xhr, status, error) {

                }
            });
        }
    </script>
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