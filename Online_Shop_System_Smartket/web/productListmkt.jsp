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
        <title>Bootstrap Order Details Table with Search Filter</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <<link rel="stylesheet" href="css/css_saleProductList/saleProductList.css"/>
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
                                    <label>Tìm kiếm</label>
                                    <input type="text" class="form-control">
                                </div>
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
                                <th>Action</th>
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
                                <td><%=rs.getInt("CategoryID")%></td>
                                <td><%=rs.getDouble("UnitPrice")%></td>
                                <td><%=rs.getInt("ProductID")%></td>
                                <td><%=rs.getInt("ProductID")%></td>
                                <!--<td><span class="status text-success">&bull;</span> Delivered</td>-->
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
                            <li class="page-item disabled"><a href="#">Previous</a></li>
                                <c:forEach begin="1" end="${endP}" var="i">
                                <li class="page-item"><a href="mktProductListURL?index=${i}" class="page-link">${i}</a></li>
                                </c:forEach>
                            <li class="page-item"><a href="#">Next</a></li>
                        </ul>
                    </div>

                </div>
            </div>        
        </div>     
    </body>
</html>
