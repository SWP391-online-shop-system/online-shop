<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.DecimalFormat" %>
<%@page import="view.*" %>
<%@page import="model.*" %>

<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta http-equiv="x-ua-compatible" content="ie=edge" />
        <title>Material Design for Bootstrap</title>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="style.css"/>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"/>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css"/>
        <style>
            @import url('https://fonts.googleapis.com/css?family=Open+Sans&display=swap');body{
                background-color: #eeeeee;
                font-family: 'Open Sans',serif
            }
            .container{
                margin-top:50px;
                margin-bottom: 50px
            }
            .card{
                position: relative;
                display: -webkit-box;
                display: -ms-flexbox;
                display: flex;
                -webkit-box-orient: vertical;
                -webkit-box-direction: normal;
                -ms-flex-direction: column;
                flex-direction: column;
                min-width: 0;
                word-wrap: break-word;
                background-color: #fff;
                background-clip: border-box;
                border: 1px solid rgba(0, 0, 0, 0.1);
                border-radius: 0.10rem
            }
            .card-header:first-child{
                border-radius: calc(0.37rem - 1px) calc(0.37rem - 1px) 0 0
            }
            .card-header{
                padding: 0.75rem 1.25rem;
                margin-bottom: 0;
                background-color: #fff;
                border-bottom: 1px solid rgba(0, 0, 0, 0.1)
            }
            .track{
                position: relative;
                background-color: #ddd;
                height: 7px;
                display: -webkit-box;
                display: -ms-flexbox;
                display: flex;
                margin-bottom: 60px;
                margin-top: 50px;
                width: 86%;
                margin-left: 65px;
            }
            .track .step{
                -webkit-box-flex: 1;
                -ms-flex-positive: 1;
                flex-grow: 1;
                width: 25%;
                margin-top: -18px;
                text-align: center;
                position: relative
            }
            .track .step.active:before{
                background: #FF5722
            }
            .track .step::before{
                height: 7px;
                position: absolute;
                content: "";
                width: 100%;
                left: 0;
                top: 18px
            }
            .track .step.active .icon{
                background: #ee5435;
                color: #fff
            }
            .track .icon{
                display: inline-block;
                width: 40px;
                height: 40px;
                line-height: 40px;
                position: relative;
                border-radius: 100%;
                background: #ddd
            }
            .track .step.active .text{
                font-weight: 400;
                color: #000
            }
            .track .text{
                display: block;
                margin-top: 7px
            }
            .itemside{
                position: relative;
                display: -webkit-box;
                display: -ms-flexbox;
                display: flex;
                width: 100%
            }
            .itemside .aside{
                position: relative;
                -ms-flex-negative: 0;
                flex-shrink: 0
            }
            .img-sm{
                width: 80px;
                height: 80px;
                padding: 7px
            }
            ul.row, ul.row-sm{
                list-style: none;
                padding: 0
            }
            .itemside .info{
                padding-left: 15px;
                padding-right: 7px
            }
            .itemside .title{
                display: block;
                margin-bottom: 5px;
                color: #212529
            }
            p{
                margin-top: 0;
                margin-bottom: 1rem
            }
            .btn-warning{
                color: #ffffff;
                background-color: #ee5435;
                border-color: #ee5435;
                border-radius: 1px
            }
            .btn-warning:hover{
                color: #ffffff;
                background-color: #ff2b00;
                border-color: #ff2b00;
                border-radius: 1px
            }
            .table1{
                width: 80%;
                float: right;
                margin-right: -37px;
            }
        </style>
    </head>
    <body>
        <%DecimalFormat df = new DecimalFormat("###,###");
            df.setMaximumFractionDigits(8);%>
        <div class="container">
            <article class="card table1">
                <header class="card-header"> My Orders </header>
                    <%
                      Product pro = new Product();
                      DAOProduct daoPro = new DAOProduct();
                      DAOOrder daoOrd = new DAOOrder();
                      String statusName = "";
                      ResultSet rsOrderGroup = (ResultSet)request.getAttribute("rsOrderGroup");
                      String productName="";
                      int countProduct = 0;
                    while(rsOrderGroup.next()){
                    pro = daoPro.getProductById(rsOrderGroup.getInt("ProductID"));
                    productName = pro.getProductName();
                    countProduct = rsOrderGroup.getInt("Quantity") - 1;
                    statusName = daoOrd.getStatusById(rsOrderGroup.getInt("StatusID")).getStatusName();
                    %>

                <form action="myOrder" method="post">
                    <div class="card-body">
                        <h6>Order ID: <strong><%=rsOrderGroup.getInt("OrderID")%></strong></h6>
                        <article class="card">
                            <div class="card-body row">

                                <div class="col"> <strong>Bao gồm:</strong> <br><%=productName%> và <%=countProduct%> sản phẩm khác </div>
                                <div class="col"> <strong>Thời gian đặt hàng:</strong>  <br><%=rsOrderGroup.getString("OrderDate")%></div>
                                <!--                                <div class="col"> <strong>Thời gian giao hàng :</strong> <br>2024-03-12 00:00:00 </div>-->
                                <div class="col"> <strong>Tổng giá trị đơn</strong> <br> <%=df.format(rsOrderGroup.getDouble("TotalPrice"))%>đ </div>
                                <div class="col"> <strong>Trạng thái:</strong> <br><%=statusName%></div>
                            </div>
                        </article>

                        <a style="margin-left: 681px;" href="#" class="btn btn-success" data-abc="true">  chi tiết đơn hàng <i class="fa fa-chevron-right"></i></a>
                        <hr>
                        <hr>
                    </div>
                </form>
                <%}%>
                <a href="#" class="btn btn-warning" data-abc="true"> <i class="fa fa-chevron-left"></i> Back to orders</a>
                <div class="col-lg-12">
                    <div class="product__pagination blog__pagination">
                        <c:if test="${tag>1}">
                            <a href="MyOrderURL?index=${tag-1}"><i class="fa fa-long-arrow-left"></i></a>
                        </c:if>
                        <c:forEach begin="1" end="${endP}" var="i">
                            <a href="MyOrderURL?index=${i}">${i}</a>
                        </c:forEach>
                        <c:if test="${tag<endP}">
                            <a href="MyOrderURL?index=${tag+1}"><i class="fa fa-long-arrow-right"></i></a>
                        </c:if>
                    </div>
                </div>
            </article>
        </div>
    </body>
</html>