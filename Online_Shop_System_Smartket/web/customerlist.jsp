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
                                <h2>Danh Sách Khách Hàng</h2>
                            </div>
                        </div>
                    </div>
                    <div class="table-filter">
                        <div class="row">
                            <div class="col-sm-3">
                                <div class="show-entries">
                                    <span>Show</span>
                                    <form action="customerlist">
                                        <select name="limit" class="form-control" onchange="this.form.submit()">
                                            <%String limit = (String)request.getAttribute("limit");
                                                if(limit == null){
                                                limit = "5";
                                                }
                                            %>
                                            <option value="5" <%=limit.equals("5")? "selected":""%>>5</option>
                                            <option value="10" <%=limit.equals("10")? "selected":""%>>10</option>
                                            <option value="15" <%=limit.equals("15")? "selected":""%>>15</option>
                                            <option value="20" <%=limit.equals("20")? "selected":""%>>20</option>
                                        </select>
                                    </form>
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
                                <th>Trạng Thái</th>						
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
                                    <td>${cus.userStatus ? 'Đang Hoạt Động':'Bị Chặn'}</td>                        
                                    <td>${cus.lastLogin}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="clearfix">
                        <!--<div class="hint-text">Showing <b>5</b> out of <b>25</b> entries</div>-->
                        <ul class="pagination">
                            <c:if test="${index>1}">
                                <li class="page-item"><a href="customerlist?index=${index-1}">Previous</a></li>
                                </c:if>
                                <c:forEach begin="1" end="${endPage}" var="i">
                                    <c:if test="${index == i}">
                                    <li class="page-item active"><a href="customerlist?index=${i}" class="page-link">${i}</a></li>
                                    </c:if>
                                    <c:if test="${index != i}">
                                    <li class="page-item"><a href="customerlist?index=${i}" class="page-link">${i}</a></li>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${index<endPage}">
                                <li class="page-item"><a href="customerlist?index=${index+1}">Next</a></li>
                                </c:if>
                        </ul>
                    </div>
                </div>
            </div>        
        </div>     
    </body>
</html>

