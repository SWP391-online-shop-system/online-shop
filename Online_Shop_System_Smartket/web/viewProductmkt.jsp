<%-- 
    Document   : viewProduct
    Created on : Feb 15, 2024, 1:59:07 PM
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
        <title>View Product List</title>
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
    <body>
        <div class="container-xl">
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-4">
                                <h2>View <b>Product</b></h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
        <% String message = (String)request.getParameter("message"); %>
        <% if (message != null && !message.isEmpty()) { %>
            <div class="alert alert-info" role="alert">
                <%= message %>
            </div>
        <% } %>
        <!-- Form content -->
    </div>
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên sản phẩm</th>
                    <th>Ảnh</th>
                    <th>Loại</th>
                    <th>Mô tả sản phẩm</th>
                    <th>Hàng trong kho</th>
                    <th>Giá bán</th>
                    <th>Giảm giá</th>
                    <th>Ngày tạo</th>
                    <th>Tổng số đánh giá</th>
                    <th>Tổng số sản phẩm</th>
                    <th>Ngày tạo</th>
                </tr>
            </thead>
            <tbody>
                <%
                ResultSet rs = (ResultSet) request.getAttribute("data");
                if (rs != null) {
                    try {
                        while (rs.next()) { 
                %>
                <tr>
                    <td><%= rs.getInt("ProductID") %></td>
                    <td><%= rs.getString("ProductName") %></td>
                    <td><img style="width: 100px" src="<%= rs.getString("ProductURL") %>"/></td>
                    <td><%= rs.getString("CategoryName") %></td>
                    <td><%= rs.getString("ProductDescription") %></td>
                    <td><%= rs.getInt("UnitInStock") %></td>
                    <td><%= rs.getInt("UnitPrice") %></td>
                    <td><%= rs.getInt("UnitDiscount") %></td>
                    <td><%= rs.getString("CreateDate") %></td>
                    <td><%= rs.getInt("TotalRate") %></td>
                    <td><%= rs.getInt("TotalStock") %></td>
                    <td><%= rs.getBoolean("ProductStatus") %></td>
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
    </body>
</html>
