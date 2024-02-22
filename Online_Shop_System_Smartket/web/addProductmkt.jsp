<%-- 
    Document   : updateProductmkt
    Created on : Feb 15, 2024, 10:12:26 PM
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
        <title>Thêm sản phẩm</title>
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
                                <h2><b>Thêm sản phẩm</b></h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
        Product product = (Product)request.getAttribute("product");
        %>
        <script>
            function validateForm() {
                var unitInStock = parseInt(document.getElementById("unitInStock").value);
                var totalStock = parseInt(document.getElementById("totalStock").value);

                if (unitInStock > totalStock) {
                    alert("Hàng trong kho không thể lớn hơn Tổng số sản phẩm.");
                    return false;
                }
                return true;
            }
        </script>
        <form action="AddProductmktURL" method="get" onsubmit="return validateForm()">
            <input type="hidden" name="service" value="addProduct">
            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>Tên sản phẩm</th>
                    <th>Loại</th>
                    <th>Mô tả sản phẩm</th>
                    <th>Hàng trong kho</th>
                    <th>Giá bán</th>
                    <th>Giảm giá</th>
                    <th>Tổng số đánh giá</th>
                    <th>Tổng số sản phẩm</th>
                </tr>
            </thead>
                <tbody>
                    <tr>
                        <td><input type="text" name="productName" value="${productName}"></td>
                        <td><input type="number" name="categoryId" value="${categoryId}"></td>
                        <td><textarea name="productDescription">${productDescription}</textarea></td>
                        <td><input type="number" name="unitInStock" id="unitInStock" value="${unitInStock}"></td>
                        <td><input type="number" name="unitPrice" value="${unitPrice}"></td>
                        <td><input type="number" name="unitDiscount" value="${unitDiscount}"></td>
                        <td><input type="number" name="totalRate" value="${totalRate}"></td>
                        <td><input type="number" name="totalStock" id="totalStock" value="${totalStock}"></td>
                    </tr>
                </tbody>
            </table>
            <input type="submit" name="submit" value="Add Product">
            <input type="reset" value="Clear">
        </form>
    </body>
</html>
