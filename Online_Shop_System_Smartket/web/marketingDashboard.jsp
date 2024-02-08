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
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
                        <img src="img/logo/logo2.png">
                    </div>
                    <div class="sidebar-brand-text mx-3">Name</div>
                </a>
                <hr class="sidebar-divider wee-0">
                <li class="nav-item active">
                    <a class="nav-link" href="index.html">
                        <i class="fas fa-fw fa-tachometer-alt"></i>
                        <span>Bảng thống kê</span></a>
                </li>
                <hr class="sidebar-divider">
                <div class="sidebar-heading">
                    Tính năng
                </div>
                <li class="nav-item">
                    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseBootstrap"
                       aria-expanded="true" aria-controls="collapseBootstrap">
                        <i class="far fa-fw fa-window-maximize"></i>
                        <span>Bootstrap UI</span>
                    </a>
                    <div id="collapseBootstrap" class="collapse" aria-labelledby="headingBootstrap" data-parent="#accordionSidebar">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <h6 class="collapse-header">Bootstrap UI</h6>
                            <a class="collapse-item" href="alerts.html">Alerts</a>
                            <a class="collapse-item" href="buttons.html">Buttons</a>
                            <a class="collapse-item" href="dropdowns.html">Dropdowns</a>
                            <a class="collapse-item" href="modals.html">Modals</a>
                            <a class="collapse-item" href="popovers.html">Popovers</a>
                            <a class="collapse-item" href="progress-bar.html">Progress Bars</a>
                        </div>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseForm" aria-expanded="true"
                       aria-controls="collapseForm">
                        <i class="fab fa-fw fa-wpforms"></i>
                        <span>Forms</span>
                    </a>
                    <div id="collapseForm" class="collapse" aria-labelledby="headingForm" data-parent="#accordionSidebar">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <h6 class="collapse-header">Forms</h6>
                            <a class="collapse-item" href="form_basics.html">Form Basics</a>
                            <a class="collapse-item" href="form_advanceds.html">Form Advanceds</a>
                        </div>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTable" aria-expanded="true"
                       aria-controls="collapseTable">
                        <i class="fas fa-fw fa-table"></i>
                        <span>Tables</span>
                    </a>
                    <div id="collapseTable" class="collapse" aria-labelledby="headingTable" data-parent="#accordionSidebar">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <h6 class="collapse-header">Tables</h6>
                            <a class="collapse-item" href="simple-tables.html">Simple Tables</a>
                            <a class="collapse-item" href="datatables.html">DataTables</a>
                        </div>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ui-colors.html">
                        <i class="fas fa-fw fa-palette"></i>
                        <span>UI Colors</span>
                    </a>
                </li>
                <hr class="sidebar-divider">
                <div class="sidebar-heading">
                    Examples
                </div>
                <li class="nav-item">
                    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePage" aria-expanded="true"
                       aria-controls="collapsePage">
                        <i class="fas fa-fw fa-columns"></i>
                        <span>Pages</span>
                    </a>
                    <div id="collapsePage" class="collapse" aria-labelledby="headingPage" data-parent="#accordionSidebar">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <h6 class="collapse-header">Example Pages</h6>
                            <a class="collapse-item" href="login.html">Login</a>
                            <a class="collapse-item" href="register.html">Register</a>
                            <a class="collapse-item" href="404.html">404 Page</a>
                            <a class="collapse-item" href="blank.html">Blank Page</a>
                        </div>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="charts.html">
                        <i class="fas fa-fw fa-chart-area"></i>
                        <span>Charts</span>
                    </a>
                </li>
                <hr class="sidebar-divider">
                <div class="version" id="version-ruangadmin"></div>
            </ul>
            <!-- Sidebar -->
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <!-- TopBar -->
                    <nav class="navbar navbar-expand navbar-light bg-navbar topbar mb-4 static-top">
                        <button id="sidebarToggleTop" class="btn btn-link rounded-circle mr-3">
                            <i class="fa fa-bars"></i>
                        </button>
                        <ul class="navbar-nav ml-auto">
                            <li class="nav-item dropdown no-arrow">
                                <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown"
                                   aria-haspopup="true" aria-expanded="false">
                                    <i class="fas fa-search fa-fw"></i>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                                     aria-labelledby="searchDropdown">
                                    <form class="navbar-search">
                                        <div class="input-group">
                                            <input type="text" class="form-control bg-light border-1 small" placeholder="What do you want to look for?"
                                                   aria-label="Search" aria-describedby="basic-addon2" style="border-color: #3f51b5;">
                                            <div class="input-group-append">
                                                <button class="btn btn-primary" type="button">
                                                    <i class="fas fa-search fa-sm"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </li>
                            <li class="nav-item dropdown no-arrow mx-1">
                                <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown"
                                   aria-haspopup="true" aria-expanded="false">
                                    <i class="fas fa-bell fa-fw"></i>
                                    <span class="badge badge-danger badge-counter">3+</span>
                                </a>
                                <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                     aria-labelledby="alertsDropdown">
                                    <h6 class="dropdown-header">
                                        Alerts Center
                                    </h6>
                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                        <div class="mr-3">
                                            <div class="icon-circle bg-primary">
                                                <i class="fas fa-file-alt text-white"></i>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="small text-gray-500">December 12, 2019</div>
                                            <span class="font-weight-bold">A new monthly report is ready to download!</span>
                                        </div>
                                    </a>
                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                        <div class="mr-3">
                                            <div class="icon-circle bg-success">
                                                <i class="fas fa-donate text-white"></i>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="small text-gray-500">December 7, 2019</div>
                                            $290.29 has been deposited into your account!
                                        </div>
                                    </a>
                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                        <div class="mr-3">
                                            <div class="icon-circle bg-warning">
                                                <i class="fas fa-exclamation-triangle text-white"></i>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="small text-gray-500">December 2, 2019</div>
                                            Spending Alert: We've noticed unusually high spending for your account.
                                        </div>
                                    </a>
                                    <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
                                </div>
                            </li>
                            <li class="nav-item dropdown no-arrow mx-1">
                                <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown"
                                   aria-haspopup="true" aria-expanded="false">
                                    <i class="fas fa-envelope fa-fw"></i>
                                    <span class="badge badge-warning badge-counter">2</span>
                                </a>
                                <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                     aria-labelledby="messagesDropdown">
                                    <h6 class="dropdown-header">
                                        Message Center
                                    </h6>
                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                        <div class="dropdown-list-image mr-3">
                                            <img class="rounded-circle" src="img/man.png" style="max-width: 60px" alt="">
                                            <div class="status-indicator bg-success"></div>
                                        </div>
                                        <div class="font-weight-bold">
                                            <div class="text-truncate">Hi there! I am wondering if you can help me with a problem I've been
                                                having.</div>
                                            <div class="small text-gray-500">Udin Cilok · 58m</div>
                                        </div>
                                    </a>
                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                        <div class="dropdown-list-image mr-3">
                                            <img class="rounded-circle" src="img/girl.png" style="max-width: 60px" alt="">
                                            <div class="status-indicator bg-default"></div>
                                        </div>
                                        <div>
                                            <div class="text-truncate">Am I a good boy? The reason I ask is because someone told me that people
                                                say this to all dogs, even if they aren't good...</div>
                                            <div class="small text-gray-500">Jaenab · 2w</div>
                                        </div>
                                    </a>
                                    <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a>
                                </div>
                            </li>
                            <li class="nav-item dropdown no-arrow mx-1">
                                <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown"
                                   aria-haspopup="true" aria-expanded="false">
                                    <i class="fas fa-tasks fa-fw"></i>
                                    <span class="badge badge-success badge-counter">3</span>
                                </a>
                                <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                     aria-labelledby="messagesDropdown">
                                    <h6 class="dropdown-header">
                                        Task
                                    </h6>
                                    <a class="dropdown-item align-items-center" href="#">
                                        <div class="mb-3">
                                            <div class="small text-gray-500">Design Button
                                                <div class="small float-right"><b>50%</b></div>
                                            </div>
                                            <div class="progress" style="height: 12px;">
                                                <div class="progress-bar bg-success" role="progressbar" style="width: 50%" aria-valuenow="50"
                                                     aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                    </a>
                                    <a class="dropdown-item align-items-center" href="#">
                                        <div class="mb-3">
                                            <div class="small text-gray-500">Make Beautiful Transitions
                                                <div class="small float-right"><b>30%</b></div>
                                            </div>
                                            <div class="progress" style="height: 12px;">
                                                <div class="progress-bar bg-warning" role="progressbar" style="width: 30%" aria-valuenow="30"
                                                     aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                    </a>
                                    <a class="dropdown-item align-items-center" href="#">
                                        <div class="mb-3">
                                            <div class="small text-gray-500">Create Pie Chart
                                                <div class="small float-right"><b>75%</b></div>
                                            </div>
                                            <div class="progress" style="height: 12px;">
                                                <div class="progress-bar bg-danger" role="progressbar" style="width: 75%" aria-valuenow="75"
                                                     aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                    </a>
                                    <a class="dropdown-item text-center small text-gray-500" href="#">View All Taks</a>
                                </div>
                            </li>
                            <div class="topbar-divider d-none d-sm-block"></div>
                            <li class="nav-item dropdown no-arrow">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown"
                                   aria-haspopup="true" aria-expanded="false">
                                    <img class="img-profile rounded-circle" src="images/user/default_avatar.jpg" style="max-width: 60px">
                                    <span class="ml-2 d-none d-lg-inline text-white small">Maman Ketoprak</span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Profile
                                    </a>
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Settings
                                    </a>
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Activity Log
                                    </a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="javascript:void(0);" data-toggle="modal" data-target="#logoutModal">
                                        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Logout
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </nav>
                    <!-- Topbar -->

                    <!-- Container Fluid-->
                    <div class="container-fluid" id="container-wrapper">
                        <div class="d-sm-flex align-items-center justify-content-between mb-4">
                            <h1 class="h3 mb-0 text-gray-800">Bảng thống kê</h1>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="./">Trang chủ</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Bảng thống kê</li>
                            </ol>
                        </div>

                        <div class="row mb-3">
                            <!-- Earnings (Monthly) Card Example -->
                            <div class="col-xl-3 col-md-6 mb-4">
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
                                                if(!rsCountTrendBlog.isBeforeFirst()){%>
                                                <div class="mt-2 mb-0 text-muted text-xs">
                                                    <span class="text-success mr-2">Không có bài viết nào</span></br>
                                                    <span>trong tuần này</span>
                                                </div>
                                                <%}
                                                if(rsCountTrendBlog.next()){%>
                                                <div class="mt-2 mb-0 text-muted text-xs">
                                                    <span class="text-success mr-2"><i class="fa fa-arrow-up"></i>&nbsp;<%=rsCountTrendBlog.getInt(1)%>&nbsp;bài viết</span></br>
                                                    <span>trong tuần này</span>
                                                </div>
                                                <%}%>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-calendar fa-2x text-primary"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Earnings (Annual) Card Example -->
                            <div class="col-xl-3 col-md-6 mb-4">
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
                                                if(!rsProductTrend.isBeforeFirst()){%>
                                                <div class="mt-2 mb-0 text-muted text-xs">
                                                    <span class="text-warning mr-2">Không có sản phẩm nào</span></br>
                                                    <span>Trong tuần này</span>
                                                </div>
                                                <%}if(rsProductTrend.next()){%>
                                                <div class="mt-2 mb-0 text-muted text-xs">
                                                    <span class="text-success mr-2"><i class="fas fa-arrow-up">&nbsp;<%=rsProductTrend.getInt(1)%>&nbsp;sản phẩm mới</i></span></br>
                                                    <span>Trong tuần này</span>
                                                </div>
                                                <%}%>

                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-shopping-cart fa-2x text-success"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- New User Card Example -->
                            <div class="col-xl-3 col-md-6 mb-4">
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
                                                if(!rsUserTrend.isBeforeFirst()){%>
                                                <div class="mt-2 mb-0 text-muted text-xs">
                                                    <span class="text-warning mr-2">Không có khách hàng nào</span></br>
                                                    <span>Trong tuần này</span>
                                                </div>
                                                <%}if(rsUserTrend.next()){%>
                                                <div class="mt-2 mb-0 text-muted text-xs">
                                                    <span class="text-success mr-2"><i class="fas fa-arrow-up">&nbsp;<%=rsUserTrend.getInt(1)%>&nbsp;khách hàng mới</i></span></br>
                                                    <span>Trong tuần này</span>
                                                </div>
                                                <%}%>

                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-users fa-2x text-info"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Pending Requests Card Example -->
                            <div class="col-xl-3 col-md-6 mb-4">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="text-xs font-weight-bold text-uppercase mb-1">Phản hồi</div>
                                            <%
                                            ResultSet rsUserCount = (ResultSet)request.getAttribute("rsUserCount");
                                            if(rsUserCount.next()) {%>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"><%=rsUserCount.getInt(1)%>&nbsp;phản hồi mới</div>
                                            <%}
                                            ResultSet rsUserTrend = daoUser.getData("select count(UserID) from User where CreateDate between (curdate() - interval 6 day) and  curdate() and UserStatus = 1 and RoleID = 1;");
                                            if(!rsUserTrend.isBeforeFirst()){%>
                                            <div class="mt-2 mb-0 text-muted text-xs">
                                                <span class="text-warning mr-2">Không có phản hồi nào</span></br>
                                                <span>Trong tuần này</span>
                                            </div>
                                            <%}if(rsUserTrend.next()){%>
                                            <div class="mt-2 mb-0 text-muted text-xs">
                                                <span class="text-success mr-2"><i class="fas fa-arrow-up">&nbsp;<%=rsUserTrend.getInt(1)%>&nbsp;phản hồi mới</i></span></br>
                                                <span>Trong tuần này</span>
                                            </div>
                                            <%}%>

                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-comments fa-2x text-warning"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Area Chart -->
                        <div class="col-xl-8 col-lg-7">
                            <div class="card mb-4">
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <div class="m-0 font-weight-bold text-primary">Thống kê sản phẩm từng tuần</div>
                                    <%
                                    String formatWeekFrom = (String)request.getAttribute("formatWeekFrom");
                                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    Date currentDate = new Date();
                                    String curDate = dateFormat.format(currentDate);
                                    %>
                                    <span style="margin-right: -12px;">từ</span>
                                    <form action="MarketingDashBoardURL" method="GET">
                                        <input id="dateInputFrom" class="date-chooser" type="date" name="weekFrom" value="<%=(formatWeekFrom==null || formatWeekFrom.equals(""))?curDate:formatWeekFrom%>" onchange="autoUpdateWeekTo(this.value);this.form.submit();"/>
                                        <span>đến</span>
                                        <input id="dateInputTo" class="date-chooser" type="date" name="weekTo" disabled/>
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
                                    <div class="dropdown no-arrow">
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="mb-3">
                                        <div class="small text-gray-500">Oblong T-Shirt
                                            <div class="small float-right"><b>600 of 800 Items</b></div>
                                        </div>
                                        <div class="progress" style="height: 12px;">
                                            <div class="progress-bar bg-warning" role="progressbar" style="width: 80%" aria-valuenow="80"
                                                 aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <div class="small text-gray-500">Gundam 90'Editions
                                            <div class="small float-right"><b>500 of 800 Items</b></div>
                                        </div>
                                        <div class="progress" style="height: 12px;">
                                            <div class="progress-bar bg-success" role="progressbar" style="width: 70%" aria-valuenow="70"
                                                 aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <div class="small text-gray-500">Rounded Hat
                                            <div class="small float-right"><b>455 of 800 Items</b></div>
                                        </div>
                                        <div class="progress" style="height: 12px;">
                                            <div class="progress-bar bg-danger" role="progressbar" style="width: 55%" aria-valuenow="55"
                                                 aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <div class="small text-gray-500">Indomie Goreng
                                            <div class="small float-right"><b>400 of 800 Items</b></div>
                                        </div>
                                        <div class="progress" style="height: 12px;">
                                            <div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="50"
                                                 aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <div class="small text-gray-500">Remote Control Car Racing
                                            <div class="small float-right"><b>200 of 800 Items</b></div>
                                        </div>
                                        <div class="progress" style="height: 12px;">
                                            <div class="progress-bar bg-success" role="progressbar" style="width: 30%" aria-valuenow="30"
                                                 aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer text-center">
                                    <a class="m-0 small text-primary card-link" href="#">View More <i
                                            class="fas fa-chevron-right"></i></a>
                                </div>
                            </div>
                        </div>
                        <!-- Invoice Example -->
                        <div class="col-xl-8 col-lg-7 mb-4">
                            <div class="card">
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">Khách hàng mới</h6>
                                    <form action="marketingDashBoardURL" method="GET">
                                        <input class="date-chooser" type="date" name="userWeekFrom"/>
                                    </form>
                                    <form action="marketingDashBoardURL" method="GET">
                                        <span>den</span>
                                        <input class="date-chooser" type="date" name="userWeekTo"/>
                                    </form>
                                    <a class="m-0 float-right btn btn-danger btn-sm" href="#">Quản lí ngay
                                        <i class="fas fa-chevron-right" style="margin-left: 8px;"></i></a>
                                </div>
                                <div class="table-responsive">
                                    <table class="table align-items-center table-flush">
                                        <thead class="thead-light">
                                            <tr>
                                                <th>ID</th>
                                                <th>Ten</th>
                                                <th>Email</th>
                                                <th style="padding-right: 0px;">Trạng thái</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td class="id-style"><a href="#">RA0449</a></td>
                                                <td>Udin Wayang</td>
                                                <td>Nasi Padang</td>
                                                <td><span class="badge badge-success">Delivered</span></td>
                                                <td><a style="width: 62px;" href="#" class="btn btn-sm btn-primary">Chi tiết</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href="#">RA5324</a></td>
                                                <td>Jaenab Bajigur</td>
                                                <td>Gundam 90' Edition</td>
                                                <td><span class="badge badge-warning">Shipping</span></td>
                                                <td><a href="#" class="btn btn-sm btn-primary">Detail</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href="#">RA8568</a></td>
                                                <td>Rivat Mahesa</td>
                                                <td>Oblong T-Shirt</td>
                                                <td><span class="badge badge-danger">Pending</span></td>
                                                <td><a href="#" class="btn btn-sm btn-primary">Detail</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href="#">RA1453</a></td>
                                                <td>Indri Junanda</td>
                                                <td>Hat Rounded</td>
                                                <td><span class="badge badge-info">Processing</span></td>
                                                <td><a href="#" class="btn btn-sm btn-primary">Detail</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href="#">RA1998</a></td>
                                                <td>Udin Cilok</td>
                                                <td>Baby Powder</td>
                                                <td><span class="badge badge-success">Delivered</span></td>
                                                <td><a href="#" class="btn btn-sm btn-primary">Detail</a></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="card-footer"></div>
                            </div>
                        </div>
                        <!-- Message From Customer-->
                        <div class="col-xl-4 col-lg-5 ">
                            <div class="card">
                                <div class="card-header py-4 bg-primary d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-light">Phản hồi mới</h6>
                                </div>
                                <div>
                                    <div class="customer-message align-items-center">
                                        <a class="font-weight-bold" href="#">
                                            <div class="text-truncate message-title">Hi there! I am wondering if you can help me with a
                                                problem I've been having.</div>
                                            <div class="small text-gray-500 message-time font-weight-bold">Udin Cilok · 58m</div>
                                        </a>
                                    </div>
                                    <div class="customer-message align-items-center">
                                        <a href="#">
                                            <div class="text-truncate message-title">But I must explain to you how all this mistaken idea
                                            </div>
                                            <div class="small text-gray-500 message-time">Nana Haminah · 58m</div>
                                        </a>
                                    </div>
                                    <div class="customer-message align-items-center">
                                        <a class="font-weight-bold" href="#">
                                            <div class="text-truncate message-title">Lorem ipsum dolor sit amet, consectetur adipiscing elit
                                            </div>
                                            <div class="small text-gray-500 message-time font-weight-bold">Jajang Cincau · 25m</div>
                                        </a>
                                    </div>
                                    <div class="customer-message align-items-center">
                                        <a class="font-weight-bold" href="#">
                                            <div class="text-truncate message-title">At vero eos et accusamus et iusto odio dignissimos
                                                ducimus qui blanditiis
                                            </div>
                                            <div class="small text-gray-500 message-time font-weight-bold">Udin Wayang · 54m</div>
                                        </a>
                                    </div>
                                    <div class="card-footer text-center">
                                        <a class="m-0 small text-primary card-link" href="#">Xem them   <i
                                                class="fas fa-chevron-right"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Row-->
                    <!-- Modal Logout -->
                    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabelLogout"
                         aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabelLogout">Ohh No!</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <p>Are you sure you want to logout?</p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Cancel</button>
                                    <a href="login.html" class="btn btn-primary">Logout</a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!---Container Fluid-->
            </div>
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