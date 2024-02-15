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
        <link rel="stylesheet" href="css/css_saleProductList/saleProductList.css"/>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function () {
                $('[data-toggle="tooltip"]').tooltip();
            });
        </script>
    </head>
    <%
    ResultSet rs = (ResultSet)request.getAttribute("data");
    %>
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
                                <div class="filter-group">
                                    <label>Loại</label>
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
                                    <label>Trạng thái</label>
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
                            %>
                            <tr>
                                <td><%=rs.getInt("ProductID")%></td>
                                <td><img style="width: 100px" src="<%=rs.getString("ProductURL")%>"/></td>
                                <td><%=rs.getString("ProductName")%></td>
                                <td><%=rs.getString("CategoryName")%></td>
                                <td><%=rs.getDouble("UnitPrice")%></td>
                                <td><span class="status text-success">&bull;</span> Delivered</td>
                                <td>
                                    <div class="dropdown">
                                        <button class="btn btn-secondary btn-sm dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            Hành động
                                        </button>
                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                            <a class="dropdown-item" href="#" onclick="hideProduct(<%= rs.getInt("ProductID") %>)">Ẩn</a>
                                            <a class="dropdown-item" href="#" onclick="showProduct(<%= rs.getInt("ProductID") %>)">Hiện</a>
                                            <a class="dropdown-item" href="viewProduct.jsp?productId=<%= rs.getInt("ProductID") %>">Xem</a>
                                            <a class="dropdown-item" href="editProduct.jsp?productId=<%= rs.getInt("ProductID") %>">Chỉnh sửa</a>
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
                    <div class="clearfix">
                        <div class="hint-text">Showing <b>5</b> out of <b>25</b> entries</div>
                        <ul class="pagination">
                            <li class="page-item <c:if test='${empty param.index or param.index eq "1"}'>disabled</c:if>">
                                <a href="<c:if test='${param.index ne "1" and not empty param.index}'>ControllerSearchMKTURL?index=${(param.index - 1)}&amp;</c:if>keyWord=${param.keyWord}" class="page-link">Previous</a>
                                </li>
                                <li class="page-item <c:if test='${empty param.index or param.index eq "1"}'>active</c:if>">
                                <a href="ControllerSearchMKTURL?index=1&amp;keyWord=${param.keyWord}" class="page-link">1</a>
                            </li>
                            <c:forEach begin="2" end="${endP}" var="i">
                                <li class="page-item <c:if test='${param.index eq i}'>active</c:if>">
                                    <a href="ControllerSearchMKTURL?index=${i}&amp;keyWord=${param.keyWord}" class="page-link">${i}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item <c:if test='${param.index eq endP or empty param.index}'>disabled</c:if>">
                                <a href="<c:if test='${not empty param.index and param.index ne endP}'>ControllerSearchMKTURL?index=${(param.index + 1)}&amp;</c:if>keyWord=${param.keyWord}" class="page-link">Next</a>
                            </li>
                        </ul>











                    </div>

                </div>
            </div>        
        </div>     
    </body>
</html>
