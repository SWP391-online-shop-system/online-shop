<%-- 
    Document   : marketing_dashboard
    Created on : Feb 1, 2024, 10:24:26 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="view.*" %>
<%@page import="model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.sql.ResultSet, java.sql.SQLException, java.util.List"%>
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
        <title>Danh sách Order</title>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/orderList.css" rel="stylesheet" type="text/css">
        <link href="css/css_saleProductList/orderlist.css" rel="stylesheet">
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
    </head>
    <%
        ResultSet rs = (ResultSet)request.getAttribute("data");
        ResultSet rs1 = (ResultSet)request.getAttribute("data1");
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
    <body id="page-top">
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
                            <h1 class="h3 mb-0 text-gray-800">Danh sách sản phẩm</h1>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="OrderListURL">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Danh sách sản phẩm</li>
                            </ol>
                        </div>
                        <div class="row">
                            <!-- DataTable with Hover -->
                            <div class="col-lg-12">
                                <div class="card mb-4">
                                    <div class="table-responsive p-3">
                                        <table class="table align-items-center table-flush table-hover" id="dataTableHover">
                                            <div style="display: flex;
                                                 margin-left: 200px;
                                                 margin-bottom: -30px;">
                                                <form action="OrderListURL" method="get" class="form-control">
                                                    <div class="filter-group" style="display:flex;margin-left: -28px;">
                                                        <div style="margin-right: 10px;">Từ: <input type="date" name="fromDate" value="${param.fromDate}" onchange="this.form.submit()"></div>
                                                        <div>Đến: <input type="date" name="toDate" value="${param.toDate}" onchange="this.form.submit()"></div>
                                                        <div>
                                                            <label for="saleName">Tên nhân viên: </label>
                                                            <select name="saleName" onchange="this.form.submit()">
                                                                <option value="">Tất cả</option>
                                                                <c:forEach var="user" items="${user}">
                                                                    <option value="${user.userID}"<c:if test="${user.userID eq param.saleName}"> selected</c:if>>
                                                                        ${user.firstName} ${user.lastName}
                                                                    </option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div>
                                                        <label for="statusName">Trạng thái:</label>
                                                        <select name="statusName" style="width: 115px;" onchange="this.form.submit()">
                                                            <option value="">Tất cả</option>
                                                            <c:forEach var="status" items="${status}">
                                                                <option value="${status.statusName}" <c:if test="${status.statusName eq param.statusName}">selected</c:if>>
                                                                    ${status.statusName}
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <input type="submit" value="Lọc" style="margin-left: 12px;" hidden>
                                                </form>
                                            </div>
                                            <thead class="thead-light">
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Tên khách hàng</th>
                                                    <th>Tên sản phẩm</th>
                                                    <th>Số lượng</th>
                                                    <th>Tổng giá tiền</th>
                                                    <th>Ngày tạo đơn</th>
                                                    <th>Tên nhân viên</th>
                                                    <th>Trạng thái</th>
                                                </tr>
                                            </thead>
                                            <tfoot>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Tên khách hàng</th>
                                                    <th>Tên sản phẩm</th>
                                                    <th>Số lượng</th>
                                                    <th>Tổng giá tiền</th>
                                                    <th>Ngày tạo đơn</th>
                                                    <th>Tên nhân viên</th>
                                                    <th>Trạng thái</th>
                                                </tr>
                                            </tfoot>
                                            <tbody>
                                                <% try {
                                                    while(rs.next()) {
                                                %>
                                                <tr onclick="Orderdetail(<%=rs.getInt("OrderID")%>)">
                                                    <td><%=rs.getInt("OrderID")%></td>
                                                    <td><%=rs.getString("FullName")%></td>
                                                    <td><%=rs.getString("ProductName")%></td>
                                                    <td><%=rs.getInt("Quantity")%></td>
                                                    <td><%= df.format(rs.getDouble("TotalPrice")) %></td>
                                                    <td><%=rs.getString("OrderDate")%></td>
                                                    <td><%=rs.getString("SaleName")%></td>
                                                    <td><%=rs.getString("StatusName")%></td>
                                                </tr>
                                                <% }
                                                   } catch (SQLException ex) {
                                                   }
                                                %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
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
        <script src="vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>
        <script src="js_sale/orderlist.js"></script>
        <!-- Page level custom scripts -->
        <script>
                                                            $(document).ready(function () {
                                                                $('#dataTableHover').DataTable(); // ID From dataTable with Hover
                                                            });
        </script>
        <script>
            function submitForm() {
                document.getElementById('filterForm').submit();
            }
        </script>
    </body>

</html>