<%-- 
    Document   : logHistory
    Created on : Mar 22, 2024, 11:28:37 AM
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
<html>
    <head>
        <title>Log</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        <link rel="stylesheet" href="css/logStyle.css"/>
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
    <body>
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
                    <li class="nav-item">
                        <a class="nav-link" href="userlist">
                            <i class="fas fa-user fa-2x text-primary"></i>
                            <span>Người dùng</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="settinglist">
                            <span>Cài đặt</span>
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
                                    <a class="dropdown-item" href="adminLogHistoryURL">
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
                        <div class="timeline">
                            <ul>
                                <%ResultSet rsLog = (ResultSet)request.getAttribute("log");
                                DAOUser dao = new DAOUser();
                                User user = new User();
                                while(rsLog.next()){
                                user = dao.getUserByUserID(rsLog.getInt("UpdateBy"));
                                %>
                                <li>
                                    <span><%=rsLog.getString("updateAt")%></span>
                                    <div class="content">
                                        <h3><%=user.getFirstName() + " " + user.getLastName()%></h3>
                                        <p>
                                            <%=rsLog.getString("purpose")%>
                                        </p>
                                    </div>
                                </li>
                                <%}%>
                            </ul>
                        </div>

                        </body>
                        </html>
