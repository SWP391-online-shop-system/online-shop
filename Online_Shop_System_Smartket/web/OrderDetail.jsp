<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="view.*" %>
<%@page import="model.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.sql.ResultSet, java.sql.SQLException"%>
<%@page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <link href="images/logo/logo.png" rel="icon">
        <title>Danh sách Order</title>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/orderList.css" rel="stylesheet" type="text/css">
        <link href="css/css_saleProductList/orderlist.css" rel="stylesheet">
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <style>
            /* Basic styling for the order details */
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }
            .order-container {
                display: flex; /* Display as flex container */
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ddd;
            }
            .order-section {
                flex: 1; /* Distribute available space equally */
                margin-right: 20px; /* Add spacing between sections */
            }
            .order-header {
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 20px;
            }
            .product-item {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
            }
            .product-thumbnail {
                width: 50px;
                height: 50px;
                margin-right: 10px;
            }
            /* Add more styles as needed */
        </style>
    </head>
    <body id="page-top">
        <%
        ResultSet rs = (ResultSet)request.getAttribute("data");
        ResultSet rs1 = (ResultSet)request.getAttribute("data1");
        ResultSet rs2 = (ResultSet)request.getAttribute("data2");
        ResultSet rs3 = (ResultSet)request.getAttribute("data3");
        %>
        <div class="container">
            <% String message = (String)request.getParameter("message");
            String errorMessage = (String) request.getAttribute("errorMessage");
            %>
            <% if (message != null && !message.isEmpty()) { %>
            <div class="alert alert-info" role="alert">
                <%= message %>
            </div>
            <% } %>
            <%DecimalFormat df = new DecimalFormat("###,###");
            df.setMaximumFractionDigits(8);%>
            <%if (errorMessage != null) {%>
            <div class="alert alert-info" role="alert">
                <%= errorMessage %>
            </div>
            <%}%>
        </div>
        <div id="wrapper">
            <!-- Sidebar -->
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <nav class="navbar navbar-expand navbar-light bg-navbar topbar mb-4 static-top">
                        <div style="font-weight: 700;color: white;font-size: 37px;letter-spacing: 2px;font-family: Nunito,-apple-system,BlinkMacSystemFont"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";">Trang Sale</div>
                        <ul class="navbar-nav ml-auto">
                            <div class="topbar-divider d-none d-sm-block"></div>
                            <li class="nav-item dropdown no-arrow">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown"
                                   aria-haspopup="true" aria-expanded="false">
                                    <img class="img-profile rounded-circle" src="images/user/${sessionScope.account.userImage}" style="max-width: 60px">
                                    <span class="ml-2 d-none d-lg-inline text-white small">${sessionScope.account.firstName}&nbsp;${sessionScope.account.lastName}</span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                                    <a class="dropdown-item" href="#" >
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
                    <div class="container-fluid" id="container-wrapper">
                        <div class="d-sm-flex align-items-center justify-content-between mb-4">
                            <h1 class="h3 mb-0 text-gray-800">Chi tiết sản phẩm</h1>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="OrderListURL">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Chi tiết sản phẩm</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
        </div>     
        <div style="font-size: 20px;
             font-weight: bold;
             margin-bottom: 20px;">Thông tin đơn hàng</div>
        <% try {
                                                while(rs.next()) {
        %>
        <div style="display: flex;">
            <div class="card-body">
                <div class="row">
                    <div class="col-sm-3">
                        <p class="mb-0">ID</p>
                    </div>
                    <div class="col-sm-9">
                        <input type="text" value="<%=rs.getInt("OrderID")%>" readonly>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-sm-3">
                        <p class="mb-0">Tên khách hàng</p>
                    </div>
                    <div class="col-sm-9">
                        <input type="text" value="<%=rs.getString("FullName")%>" readonly>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-sm-3">
                        <p class="mb-0">Email</p>
                    </div>
                    <div class="col-sm-9">
                        <input type="text" value="<%=rs.getString("Email")%>" readonly>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-sm-3">
                        <p class="mb-0">Số điện thoại</p>
                    </div>
                    <div class="col-sm-9">
                        <input type="text" value="<%=rs.getString("PhoneNumber")%>" readonly>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-sm-3">
                        <p class="mb-0">Ngày đặt hàng</p>
                    </div>
                    <div class="col-sm-9">
                        <input type="text" value="<%=rs.getString("OrderDate")%>" readonly>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-sm-3">
                        <p class="mb-0">Tổng giá tiền</p>
                    </div>
                    <div class="col-sm-9">
                        <input type="text" value="<%=df.format(rs.getDouble("TotalPrice"))%>" readonly>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-sm-3">
                        <p class="mb-0">Tên nhân viên</p>
                    </div>
                    <div class="col-sm-9">
                        <input type="text" value="<%=rs.getString("SaleName")%>" readonly>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-sm-3">
                        <p class="mb-0">Trạng thái</p>
                    </div>
                    <div class="col-sm-9">
                        <form action="saleOrderDetailURL" method="post">
                            <input type="hidden" name="orderID" value="<%=rs.getInt("OrderID")%>">
                            <input type="hidden" name="email" value="<%=rs.getString("ReceiverEmail")%>">
                            <select name="status" onchange="this.form.submit()" <%= rs.getInt("StatusID") == 1 || rs.getInt("StatusID") == 4 ? "disabled" : "" %>>
                                <%
                                while(rs3.next()) {
                                    int statusId = rs3.getInt(1);
                                    String statusName = rs3.getString(2);
                                    int selectedStatusId = rs.getInt("StatusID");
                                    boolean isSelected = selectedStatusId == statusId;

                                    // Check if the option should be disabled
                                    if (isSelected) {
                                        out.println("<option value=\"" + statusId + "\" selected>" + statusName + "</option>");
                                    } else {
                                        out.println("<option value=\"" + statusId + "\">" + statusName + "</option>");
                                    }
                                }
                                %>
                            </select>
                        </form>
                    </div>
                </div>
                <hr>
            </div>
            <% }
                                           } catch (SQLException ex) {
                                           }
            %>
            <div class="card-body" style="flex: 0 0 50%;border-left: 1px dashed;">
                <% try {
                        while(rs1.next()) {
                        int gender = rs1.getInt("ReceiverGender");
                        String genderText = (gender == 0) ? "Nam" : "Nữ";
                %>
                <div class="card-body mb-8" style="flex: 0 0 40%;
                     background: white;
                     border-radius: 10px;
                     margin-left: 130px;
                     max-width: 90%">
                    <div class="order-header">Thông tin người nhận</div>
                    <div class="row">
                        <div class="col-sm-3">
                            <p class="mb-0">Họ và tên</p>
                        </div>
                        <div class="col-sm-9">
                            <input type="text" value="<%=rs1.getString("ReceiverName")%>" readonly>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-sm-3">
                            <p class="mb-0">Giới tính</p>
                        </div>
                        <div class="col-sm-9">
                            <input type="text" value="<%= genderText %>" readonly>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-sm-3">
                            <p class="mb-0">Email</p>
                        </div>
                        <div class="col-sm-9">
                            <input type="text" value="<%=rs1.getString("ReceiverEmail")%>" readonly>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-sm-3">
                            <p class="mb-0">Số điện thoại</p>
                        </div>
                        <div class="col-sm-9">
                            <input type="text" value="<%=rs1.getString("ReceiverPhoneNumber")%>" readonly>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-sm-3">
                            <p class="mb-0">Địa chỉ</p>
                        </div>
                        <div class="col-sm-9">
                            <input type="text" value="<%=rs1.getString("ReceiverAddress")%>" readonly>
                        </div>
                    </div>
                    <hr>
                </div>
                <% }
                                                   } catch (SQLException ex) {
                                                   }
                %>
            </div>
        </div>

        <div class="row">
            <!-- DataTable with Hover -->
            <div class="col-lg-12">
                <div class="card mb-4">
                    <div class="table-responsive p-3">
                        <table class="table align-items-center table-flush table-hover" id="dataTableHover" style="width: 80%;
                               margin: auto;
                               border: 1px solid #dce2e5;
                               text-align: center;">
                            <div style="display: flex;
                                 flex-wrap: nowrap;
                                 flex-direction: row;
                                 align-content: center;
                                 justify-content: center;font-size: 24px;
                                 font-weight: bold;
                                 margin-bottom: 20px;">Sản phẩm đã đặt</div>
                            <thead class="thead-light">
                                <tr>
                                    <th style="min-width: 104px">Tên sản phẩm</th>
                                    <th style="max-height: 100px;">Ảnh</th>
                                    <th style="min-width: 109px;">Loại sản phẩm</th>
                                    <th style="min-width: 120px;">Giá tiền</th>
                                    <th style="min-width: 137px;">Số lượng</th>
                                    <th style="min-width: 77px;">Tổng số tiền</th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr>
                                    <th style="min-width: 104px">Tên sản phẩm</th>
                                    <th style="max-height: 100px;">Ảnh</th>
                                    <th style="min-width: 109px;">Loại sản phẩm</th>
                                    <th style="min-width: 120px;">Giá tiền</th>
                                    <th style="min-width: 137px;">Số lượng</th>
                                    <th style="min-width: 77px;">Tổng số tiền</th>
                                </tr>
                            </tfoot>
                            <tbody>
                                <%
    if (rs2 != null) {
    try {
        while (rs2.next()) {
        double totalPricePerUnit = rs2.getDouble("TotalPricePerUnit");
                                %>
                                <tr>
                                    <td><%=rs2.getString("ProductName")%></td>
                                    <td><img style="width: 100px" src="<%= rs2.getString("ProductURLShow") %>"/></td>
                                    <td><%=rs2.getString("CategoryName")%></td>
                                    <td><%=df.format(rs2.getDouble("UnitPrice"))%></td>
                                    <td><%=rs2.getInt("QuantityPerUnit")%></td>
                                    <td><%=df.format(totalPricePerUnit)%></td>
                                </tr>
                                <% 
                                        }
                                    } catch (SQLException ex) {
                                        ex.printStackTrace();
                                    }
                                } else {
                                    // Handle null ResultSet
                                    out.println("<tr><td colspan='11'>No data available</td></tr>");
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="js_marketing/ruang-admin.min.js"></script>
    <script src="vendor/chart.js/Chart.min.js"></script>
    <script src="js_marketing/demo/chart-area-demo.js"></script>  
    <script src="vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>
    <script src="js_sale/orderlist.js"></script>
</html>
