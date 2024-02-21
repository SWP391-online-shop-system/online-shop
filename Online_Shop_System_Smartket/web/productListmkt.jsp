<%-- 
    Document   : productListSale
    Created on : Jan 30, 2024, 9:42:53 PM
    Author     : HP
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="view.*" %>
<%@page import="model.*" %>
<%@page import="java.sql.ResultSet, java.sql.SQLException"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Product List</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/css_saleProductList/saleProductList.css"/>
        <link rel="stylesheet" href="css/css_mkt/style.css"/>
        <script>
            $(document).ready(function () {
                $('[data-toggle="tooltip"]').tooltip();
            });
        </script>
    </head>
    <%
    ResultSet rs = (ResultSet)request.getAttribute("data");
    %>
    <div class="container">
        <% String message = (String)request.getParameter("message"); %>
        <% if (message != null && !message.isEmpty()) { %>
        <div class="alert alert-info" role="alert">
            <%= message %>
        </div>
        <% } %>
        <!-- Form content -->
    </div>
    <body>
        <div class="container-xl">
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-4">
                                <h2>Product <b>List</b></h2>
                            </div>
                        </div>
                    </div>
                    <div class="table-filter">
                        <div class="row">
                            <div class="col-sm-9">
                                <form action="ControllerSearchMKTURL" method="post">
                                    <button type="submit" value="search" class="btn btn-primary"><i class="fa fa-search"></i></button>
                                    <div class="filter-group">
                                        <label>Tìm kiếm</label>
                                        <input type="text" name="keyWord" class="form-control" placeholder="Tìm kiếm">
                                    </div>
                                </form>
                                <form action="mktProductListURL" method="get" id="categoryForm">
                                    <div class="filter-group">
                                        <label>Loại</label>
                                        <select class="form-control" name="categoryId" onchange="submitForm()">
                                            <option value="">All</option>
                                            <c:forEach var="category" items="${categories}">
                                                <option value="${category.categoryID}">${category.categoryName}</option>
                                            </c:forEach>							
                                        </select>
                                    </div>
                                </form>
                                <div class="filter-group">
                                    <label>Trạng thái</label>
                                    <select class="form-control">
                                        <option>Any</option>
                                        <option>Còn hàng</option>
                                        <option>Hết hàng</option>
                                    </select>
                                </div>
                                <span class="filter-icon"><i class="fa fa-filter"></i></span>
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Ảnh</th>
                                <th>Tiêu đề</th>
                                <th>Loại</th>
                                <th>Giá bán</th>
                                <th>Trạng thái</th>						
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    while(rs.next()) {
                                    int unitInStock = rs.getInt("UnitInStock");
                                        int totalStock = rs.getInt("TotalStock");
                                        String status = (unitInStock > 0 && unitInStock <= totalStock) ? "Còn hàng" : "Hết hàng";
                            %>
                            <tr>
                                <td><%=rs.getInt("ProductID")%></td>
                                <td><img style="width: 100px" src="<%=rs.getString("ProductURL")%>"/></td>
                                <td><%=rs.getString("ProductName")%></td>
                                <td><%=rs.getString("CategoryName")%></td>
                                <td><%=rs.getDouble("UnitPrice")%></td>
                                <td><%= status %></td>
                                <td>
                                    <div class="dropdown">
                                        <button class="btn btn-secondary btn-sm dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            Hành động
                                        </button>
                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                            <a class="dropdown-item" href="#" onclick="hideProduct(<%= rs.getInt("ProductID") %>)">Ẩn</a>
                                            <a class="dropdown-item" href="#" onclick="showProduct(<%= rs.getInt("ProductID") %>)">Hiện</a>
                                            <a class="dropdown-item" href="mktViewProductURL?productId=<%= rs.getInt("ProductID") %>">Xem</a>
                                            <a class="dropdown-item" href="EditProductmktURL?productId=<%= rs.getInt("ProductID") %>">Chỉnh sửa</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <%}
                                                        } catch (SQLException ex) {
                                                        }
                            %>
                        </tbody>
                    </table>
                    <ul class="pagination">
                        <div class="product__pagination blog__pagination" style="margin: 0;margin-left: 40px;">
                            <c:forEach begin="1" end="${endP}" var="i">
                                <c:choose>
                                    <c:when test="${param.index == i}">
                                        <a class="page-link" style="background: #7fad39; border-color: #7fad39; color: #ffffff;" href="mktProductListURL?index=${i}&amp;keyWord=${keyWord}">${i}</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="page-link" href="ControllerSearchMKTURL?index=${i}&amp;keyWord=${keyWord}">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                    </ul>


                </div>
            </div>        
        </div>     
    </body>
    <script>
        function submitForm() {
            document.getElementById('categoryForm').submit();
        }
    </script>
</html>
