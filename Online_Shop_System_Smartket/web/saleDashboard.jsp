<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.*"%>
<%@page import="view.User"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page import="java.text.DecimalFormat" %>
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
        <title>Trang sale</title>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/css_marketing_dashboard/marketing_dashboard_style.css" rel="stylesheet">
    </style>
</head>

<body id="page-top">
    <%
        HttpSession session = request.getSession();
            User user = (User) session.getAttribute("account");
            DecimalFormat df = new DecimalFormat("###,###");
            df.setMaximumFractionDigits(8);
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
                <%if (user.getRoleID() == 4) {%>
                <li class="nav-item">
                    <a class="nav-link" href="saleManagerOrderListURL">
                        <i class="fas fa-shopping-basket fa-2x text-primary"></i>
                        <span>Danh sách đơn hàng</span>
                    </a>
                </li>
                <%}%>
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
                <div class="container-fluid" id="container-wrapper" style="margin-bottom: 20px">
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">Thống kê</h1>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="./">Trang chủ</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Thống kê</li>
                        </ol>
                    </div>
                    <div style="display: flex;">
                        <div class="col-xl-8 col-lg-7">
                            <div class="card mb-4">
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <div class="m-0 font-weight-bold text-primary">Thống kê đơn hàng từng tuần</div>
                                    <%
                                    String formatWeekFrom = (String)request.getAttribute("formatWeekFrom");
                                    String formatOrderWeekFrom = (String)request.getAttribute("formatOrderWeekFrom");                                      
                                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    Date currentDate = new Date();
                                    String curDate = dateFormat.format(currentDate);                                        
                                    %>
                                    <span  class="m-0 text-primary" style="margin-right: -12px;" >từ</span>
                                    <form action="MarketingDashBoardURL" method="GET">
                                        <input style="background-color: #1ab365!important;" id="dateInputFrom" class="date-chooser" type="date" name="weekFrom" value="<%=(formatWeekFrom==null || formatWeekFrom.equals(""))?curDate:formatWeekFrom%>" onchange="autoUpdateWeekTo(this.value); updateWeek();"/>
                                        <span  class="m-0 text-primary">đến</span>
                                        <input style="background-color: #1ab365!important;" id="dateInputTo" class="date-chooser" type="date" name="weekTo" disabled/>            
                                        <input type="hidden" name="orderFrom" value="<%=(formatOrderWeekFrom==null || formatOrderWeekFrom.equals(""))?curDate:formatOrderWeekFrom%>"/>
                                    </form>
                                    <%
                                    ResultSet rsProductSold = (ResultSet)request.getAttribute("rsProductSold");
                                    int countDate=0;
                                    while(rsProductSold.next()) {
                                    log(getInitParameter("rsProductSold = "+rsProductSold.getInt(2)+" at day "+rsProductSold.getString(1)));
                                    countDate++;
                                    %>
                                    <div id="DataSold<%=countDate%>" style="display: none;"><%=rsProductSold.getInt(2)%></div>
                                    <%}%>
                                    <div id="dateList" style="display: none;"></div>
                                    <div class="dropdown no-arrow">
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="chart-bar">
                                        <canvas id="myBarChart"></canvas>
                                        <script>
                                            window.addEventListener('load', function () {
                                                drawChartSale();
                                            });
                                            function updateWeek() {
                                                var orderFrom = document.getElementById("dateInputFromOrder").value;
                                                var weekFrom = document.getElementById("dateInputFrom").value;
                                                console.log(weekFrom);
                                                $.ajax({
                                                    url: "saleDashBoardURL",
                                                    type: 'GET',
                                                    data: {weekFrom: weekFrom, orderFrom: orderFrom},
                                                    success: function (data) {
                                                        // Update specific element in the JSP with the new data
                                                        $("#page-top").html(data);
                                                        drawChartSale();
                                                    },
                                                    error: function (xhr, status, error) {
                                                    }
                                                });
                                            }
                                        </script>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-lg-5">
                            <div class="card mb-4">
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">Đơn hàng đã hoàn thành</h6>
                                    <div class="dropdown no-arrow"></div>
                                </div>

                                <%
                                    int percent = 0;
                                    int totalOrder = 0;
                                 ResultSet rsTotalOrderCount = (ResultSet)request.getAttribute("rsTotalOrderCount");
                                 while(rsTotalOrderCount.next()){
                                        totalOrder =  rsTotalOrderCount.getInt(1);
                                    }
                                 ResultSet rsOrderSuccessCount = (ResultSet)request.getAttribute("rsOrderSuccessCount");
                                if(!rsOrderSuccessCount.isBeforeFirst()){%>
                                <div>Chưa có đơn hàng nào thành công</div>
                                <%} else {%>
                                <div class="card-body" style="padding:8px;">
                                    <div class="mb-3">
                                        <%   while(rsOrderSuccessCount.next()){
                                           percent = (int)((double)rsOrderSuccessCount.getInt(1) / totalOrder * 100);
                                           
                                        %>
                                        <div class="small text-gray-500" style="font-weight: 500;margin-left: 10px;"><%=rsOrderSuccessCount.getInt(1)%>&nbsp;Đơn hàng / <%=totalOrder%>&nbsp;Đơn hàng
                                            <div class="small float-right"><b></b></div>
                                        </div>
                                        <div class="progress" style="height: 12px;">
                                            <div class="progress-bar bg-success" role="progressbar" style="width: <%=percent%>%" aria-valuenow="10"
                                                 aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                        <%}}%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Invoice Example -->
                    <div>
                        <div class="card" style="padding-bottom: 24px;">

                            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h6 class="m-0 font-weight-bold text-primary">Đơn hàng được giao</h6>         
                                <!--<form action="MarketingDashBoardURL" method="GET">-->
                                <div>
                                    <span  class="m-0 text-primary">từ</span>
                                    <input style="background-color: #1ab365!important;" id="dateInputFromOrder" class="date-chooser" type="date" name="orderWeekFrom" value="<%=(formatOrderWeekFrom==null || formatOrderWeekFrom.equals(""))?curDate:formatOrderWeekFrom%>" onchange="autoUpdateWeekOrder(this.value); updateWeek();"/>
                                    <span  class="m-0 text-primary">đến</span>
                                    <input style="background-color: #1ab365!important;" class="date-chooser" type="date" name="orderWeekTo" disabled/>
                                    <input type="hidden" name="weekFrom" value="<%=(formatWeekFrom==null || formatWeekFrom.equals(""))?curDate:formatWeekFrom%>"/>
                                </div>
                                <!--</form>-->
                            </div>
                            <div class="table-responsive">
                                <%
                                ResultSet rsOrderList = (ResultSet)request.getAttribute("rsOrderList");
                                if(!rsOrderList.isBeforeFirst()) {%>
                                <div style="color:orange;text-align: center;">Không có đơn hàng trong tuần này</div>
                                <%} else{%>
                                <table class="table align-items-center table-flush" style="text-align: center;">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên khách hàng</th>
                                            <th>Giá đơn hàng</th>
                                            <th>Ngày đặt hàng</th>
                                            <th>Ngày giao hàng</th>
                                            <th>Trạng thái đơn hàng</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%while(rsOrderList.next()){%>
                                        <tr>
                                            <td class="id-style"><a href="#"><%=rsOrderList.getInt(1)%></a></td>
                                            <td><%=rsOrderList.getString("FirstName")+" "+rsOrderList.getString("LastName")%></td>
                                            <td><%=df.format(rsOrderList.getDouble("TotalPrice"))%> đ</td>
                                            <td><%=rsOrderList.getString("OrderDate")%></td>
                                            <% if(rsOrderList.getString("ShippedDate")== null){%>
                                            <td>Đang cập nhật</td>
                                            <%} else{%>
                                            <td><%=rsOrderList.getString("ShippedDate")%></td>
                                            <%}%>
                                            <td><%=rsOrderList.getString("StatusName")%></td>
                                        </tr>
                                        <%}}%>
                                    </tbody>
                                </table>
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
    <script src="vendor/chartbar/chart-bar-demo.js"></script>
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="js/ruang-admin.min.js"></script>
    <!-- Page level plugins -->
    <script src="vendor/chart.js/Chart.min.js"></script>
    <!-- Page level custom scripts -->

</body>

</html>