<%-- 
    Document   : customerlist
    Created on : Jan 31, 2024, 3:38:58 PM
    Author     : trant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Danh Sách Khách Hàng</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="css/css_customerlist/list.css"/>
        <link rel="stylesheet" href="css/css_customerlist/style.css"/>
        <link rel="stylesheet" href="css/css_header/header.css"/>
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">
        <!--<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>-->
        <!--<script>
        $(document).ready(function(){
                $('[data-toggle="tooltip"]').tooltip();
        });
        </script>-->
    </head>
    <body>
        <jsp:include page="include/header.jsp"/>
        <div class="container-xl" style="display: flex;max-width: none;">
            
            <!-- end sider -->
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-4">
                                <h2>Order <b>Details</b></h2>
                            </div>
                        </div>
                    </div>
                    <div class="table-filter">
                        <div class="row">
                            <div class="col-sm-3">
                                <div class="show-entries">
                                    <span>Show</span>
                                    <select class="form-control">
                                        <option>5</option>
                                        <option>10</option>
                                        <option>15</option>
                                        <option>20</option>
                                    </select>
                                    <span>entries</span>
                                </div>
                            </div>
                            <div class="col-sm-9">
                                <button type="button" class="btn btn-primary"><i class="fa fa-search"></i></button>
                                <div class="filter-group">
                                    <label>Name</label>
                                    <input type="text" class="form-control">
                                </div>
                                <div class="filter-group">
                                    <label>Location</label>
                                    <select class="form-control">
                                        <option>All</option>
                                        <option>Berlin</option>
                                        <option>London</option>
                                        <option>Madrid</option>
                                        <option>New York</option>
                                        <option>Paris</option>								
                                    </select>
                                </div>
                                <div class="filter-group">
                                    <label>Status</label>
                                    <select class="form-control">
                                        <option>Any</option>
                                        <option>Delivered</option>
                                        <option>Shipped</option>
                                        <option>Pending</option>
                                        <option>Cancelled</option>
                                    </select>
                                </div>
                                <span class="filter-icon"><i class="fa fa-filter"></i></span>
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Số Thứ Tự</th>
                                <th>Tên Khách Hàng</th>
                                <th>Giới Tính</th>
                                <th>Email</th>
                                <th>Số Điện Thoại</th>						
                                <th>Ngày Sinh</th>						
                                <th>Lần Đăng Nhập Cuối</th>
                            </tr>
                        </thead>
                        <tbody><%int count = 0;%>
                            <c:forEach items="${requestScope.data}" var="cus">
                            <tr><%count++;%>
                                <td><%=count%></td>
                                <td>${cus.firstName} ${cus.lastName}</td>
                                <td>${cus.gender ? 'Nam':'Nữ'}</td>
                                <td>${cus.email}</td>
                                <td>${cus.phoneNumber}</td>                        
                                <td>${cus.dateOfBirth}</td>                        
                                <td>${cus.lastLogin}</td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="clearfix">
                        <div class="hint-text">Showing <b>5</b> out of <b>25</b> entries</div>
                        <ul class="pagination">
                            <li class="page-item disabled"><a href="#">Previous</a></li>
                            <li class="page-item"><a href="#" class="page-link">1</a></li>
                            <li class="page-item"><a href="#" class="page-link">2</a></li>
                            <li class="page-item"><a href="#" class="page-link">3</a></li>
                            <li class="page-item active"><a href="#" class="page-link">4</a></li>
                            <li class="page-item"><a href="#" class="page-link">5</a></li>
                            <li class="page-item"><a href="#" class="page-link">6</a></li>
                            <li class="page-item"><a href="#" class="page-link">7</a></li>
                            <li class="page-item"><a href="#" class="page-link">Next</a></li>
                        </ul>
                    </div>
                </div>
            </div>        
        </div>     
    </body>
</html>

