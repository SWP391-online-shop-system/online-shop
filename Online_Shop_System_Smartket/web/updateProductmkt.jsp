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
        <title>Cập nhật sản phẩm</title>
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
                                <h2>Cập nhật <b>Sản phẩm</b></h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
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
        <form action="EditProductmktURL" method="get" onsubmit="return validateForm()">
            <input type="hidden" name="service" value="update">
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
                </tr>
            </thead>
                <!-- Table headers -->
                <tbody>
                    <tr>
                        <td><input type="text" name="productId" value="${product.productID}" readonly></td>
                        <td><input type="text" name="productName" value="${product.productName}"></td>
                        <td><input type="number" name="categoryId" value="${product.categoryID}"></td>
                        <td><input type="text" name="productDescription" value="${product.productDescription}"></td>
                        <td><input type="number" name="unitInStock" id="unitInStock" value="${product.unitInStock}"></td>
                        <td><input type="number" name="unitPrice" value="${product.unitPrice}"></td>
                        <td><input type="number" name="unitDiscount" value="${product.unitDiscount}"></td>
                        <td><input type="text" name="createDate" value="${product.createDate}"></td>
                        <td><input type="number" name="totalRate" value="${product.totalRate}"></td>
                        <td><input type="number" name="totalStock" id="totalStock" value="${product.totalStock}"></td>
                        <td>
                            <select name="productStatus" id="productStatus">
                                <option value="0" ${productStatus == 0 ? 'selected' : ''}>Enabled</option>
                                <option value="1" ${productStatus == 1 ? 'selected' : ''}>Disabled</option>
                            </select>
                        </td>
                    </tr>
                </tbody>
            </table>
            <input type="submit" value="Update">
        </form>
    </body>
</html>
