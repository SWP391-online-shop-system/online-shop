<%-- 
    Document   : customerlist
    Created on : Jan 31, 2024, 3:38:58 PM
    Author     : trant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="view.*"%>
<%@page import="model.*"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Đơn hàng</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/css_marketing_dashboard/marketing_dashboard_style.css" rel="stylesheet">
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">
        <style>
            .statusForm{
                padding-top: 7px;
                z-index: 99;
                margin-right: -30px;
                margin-left: 11px;
                flex: 0 0 20%;
            }
            .fromdateInput{
                padding-top: 6px;
                z-index: 99;
                margin-right: 10px;
                margin-left: 3px;
                flex: 0 0 20%;
                font-size: 14px;
                height: 32px;
                width: 123px;
                margin-top: 6px;
                padding-left: 6px;
            }

        </style>
    </head>
    <body id="page-top">
        <%
            HttpSession sessionMessage = request.getSession();
            String message =(String)sessionMessage.getAttribute("message");
            DAOStatus daoStatus = new DAOStatus();
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
                        <a class="nav-link" href="AdminDashBoardURL">
                            <i class="fas fa-fw fa-tachometer-alt"></i>
                            <span>Thống kê</span></a>
                    </li>
                    <hr class="sidebar-divider">
                    <li class="nav-item">
                        <a class="nav-link" href="adminOrderTrackURL">
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
                        <div style="font-weight: 700;color: white;font-size: 37px;letter-spacing: 2px;font-family: Nunito,-apple-system,BlinkMacSystemFont"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";">Trang admin</div>
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
                            <h1 class="h3 mb-0 text-gray-800">Danh Sách Đơn hàng</h1>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="./">Trang Chủ</a></li>
                                <li class="breadcrumb-item active">Danh Sách đơn hàng</li>
                            </ol>
                        </div>

                        <!-- Row -->
                        <div class="row">
                            <!-- DataTable with Hover -->
                            <div class="col-lg-12">
                                <div class="card mb-4">                                 
                                    <div class="table-responsive p-3">
                                        <table class="table align-items-center table-flush table-hover" id="dataTableHover" style="font-size: 14px;">
                                            <div style="display: flex;
                                                 margin-left: 157px;
                                                 margin-bottom: -30px;">
                                                <%  DAOUser daoU = new DAOUser();
                                                    DAOOrder daoOrd = new DAOOrder();
                                                    DAOProduct daoP = new DAOProduct();
                                                    User user = new User();
                                                    Product product = new Product();
                                                    String status1 = (String)request.getAttribute("status");
                                                    int realStatus = 0;
                                                    if(status1.equals("all")){
                                                    realStatus = 0;
                                                    } else {
                                                    realStatus = Integer.parseInt(status1);
                                                    }
                                                    String orderFrom = (String)request.getAttribute("orderFrom");
                                                    String orderTo = (String)request.getAttribute("orderTo");
                                                    ResultSet rsOrder= (ResultSet)request.getAttribute("rsOrder");%>
                                                <form action="adminOrderTrackURL" method="get">
                                                    <div class="filter-group" style="display:flex;align-items: center;">
                                                        <div class="statusForm">Trạng thái đơn</div>
                                                        <%ResultSet rsStatus = daoOrd.getData("select * from Status");%>
                                                        <select class="form-control" name="status" onchange="this.form.submit()" 
                                                                style="padding-top: 6px;
                                                                z-index: 99;
                                                                margin-right: 10px;
                                                                margin-left: 22px;
                                                                flex: 0 0 20%;
                                                                font-size: 14px;
                                                                height: 32px;
                                                                width: 134px;
                                                                margin-top: 8px;">                                                            
                                                            <option value="all"<%=realStatus == 0?"selected":""%>>Tất cả</option>
                                                            <%while(rsStatus.next()){%>
                                                            <option value="<%=rsStatus.getInt("StatusID")%>"<%=realStatus == rsStatus.getInt("StatusID")?"selected":""%>><%=rsStatus.getString("StatusName")%></option>                                                          
                                                            <%}%>
                                                        </select>
                                                        <div style="padding-top: 9px;
                                                             margin-right: 8px;">Từ</div>
                                                        <input class="form-control fromdateInput" type="date" name="orderFrom" value="<%=orderFrom%>" onchange="this.form.submit();"/>
                                                        <div style="padding-top: 9px;
                                                             margin-right: 8px;">Đến</div>
                                                        <input class="form-control fromdateInput" type="date" name="orderTo" value="<%=orderTo%>" onchange="this.form.submit();"/>
                                                    </div>                                                   
                                                </form>
                                            </div>
                                            <thead class="thead-light">
                                                <tr>
                                                    <th style="text-align: center; width: 0">ID</th>
                                                    <th style="text-align: center;width: 125.898px;">Người mua</th>
                                                    <th style="text-align: center;width: 188.727px">Tổng tiền</th>
                                                    <th style="text-align: center; width: 200.125px">Ngày đặt hàng</th>
                                                    <th style="text-align: center;width: 183.6458px;">Ngày giao hàng</th>						
                                                    <th style="text-align: center;
                                                        width: 101.1562px;">Trạng thái</th>						
                                                    <th style="text-align: center;width: 98px">Phụ trách</th>
                                                </tr>
                                            </thead>

                                            <tbody>
                                                <%while(rsOrder.next()) {
                                                User OrderUser = daoU.getUserByUserID(rsOrder.getInt("UserID"));
                                                Status status = daoStatus.getStatusByID(rsOrder.getInt("StatusID"));
                                                User OrderSale = daoU.getUserByUserID(rsOrder.getInt("SaleID"));
                                                %>
                                                <tr style="text-align: center; cursor: pointer" onclick="">
                                                    <td><%=rsOrder.getInt("OrderID")%></td>
                                                    <td><%=OrderUser.getFirstName()+" "+OrderUser.getLastName()%></td>
                                                    <td><%=rsOrder.getDouble("TotalPrice")%></td>
                                                    <td><%=rsOrder.getString("OrderDate")%></td>
                                                    <td><%=rsOrder.getString("ShippedDate")==null?"Chưa cập nhật":rsOrder.getString("ShippedDate").substring(0,10)%></td>                        
                                                    <td><%=status.getStatusName()%></td>                        
                                                    <td><%=OrderSale.getFirstName()+" "+OrderSale.getLastName()%></td>
                                                </tr>
                                                <%}%>
                                            </tbody>
                                        </table>
                                    </div>                                    
                                </div>
                            </div>
                        </div>
                        <!--Row-->
                    </div>      
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
        <script src="vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>
        <script src="js_marketing/feedbacklist.js"></script>

        <!-- Page level custom scripts -->
    </body>
</html>
