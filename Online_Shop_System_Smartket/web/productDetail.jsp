<%-- 
    Document   : productDetail
    Created on : Feb 19, 2024, 9:39:41 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.DAOProduct"%>
<%@page import="view.Product"%>
<%@page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>product full detail - Bootdey.com</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/css_productDetail/style.css"/>
    </head>
    <body>
        <%DecimalFormat df = new DecimalFormat("###,###");
            df.setMaximumFractionDigits(8);%>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" />
        <div class="container">

            <div class="product-content product-wrap clearfix product-deatil">
                <div class="row">
                    <%
                    DAOProduct dao = new DAOProduct();
                    ResultSet rsDetail = (ResultSet)request.getAttribute("rsDetail");
                    Product newPro  = new Product();
                    List<String> listUrls = new ArrayList<>();
                    int countNode = -1;
                    %>
                    <div class="col-md-5 col-sm-12 col-xs-12">
                        <div class="product-image">
                            <div id="myCarousel-2" class="carousel slide">
                                <ol class="carousel-indicators">
                                    <%
                                    while(rsDetail.next()){
                                    newPro = dao.getProductById(rsDetail.getInt("ProductID"));
                                    listUrls.add(rsDetail.getString(13));
                                    countNode++;
                                    if(countNode==0){%>
                                    <li data-target="#myCarousel-2" data-slide-to="0" class="active"></li>
                                        <%}else{%>
                                    <li data-target="#myCarousel-2" data-slide-to="<%=countNode%>" class></li>
                                        <%}}%>
                                </ol>
                                <div class="carousel-inner">
                                    <%for (int i = 0; i < listUrls.size(); i++) {
                                    if (i == 0) { %>
                                    <div class="item active">
                                        <img src="<%=listUrls.get(i)%>" class="img-responsive" alt style="height: 335px;width: 253px;margin-left: 98px;"/>
                                    </div>
                                    <% } else { %>
                                    <div class="item">
                                        <img src="<%=listUrls.get(i)%>" class="img-responsive" alt style="height: 335px;width: 253px;margin-left: 98px;"/>
                                    </div>
                                    <%}}%>
                                </div>
                                <a class="left carousel-control" href="#myCarousel-2" data-slide="prev"> <span class="glyphicon glyphicon-chevron-left"></span> </a>
                                <a class="right carousel-control" href="#myCarousel-2" data-slide="next"> <span class="glyphicon glyphicon-chevron-right"></span> </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-md-offset-1 col-sm-12 col-xs-12">
                        <h2 class="name">
                            <%=newPro.getProductName()%>
                            <small></small>
                            <%  int totalRate = 0;
                                String resultRate = "";
                                int rateCount = 0;
                                int UserRateCount = 0;
                                String description = newPro.getProductDescription().replace("@@LINEBREAK@@", "</br>");
                                System.out.println("des in jsp = "+description);
                                double realPrice =(newPro.getUnitPrice() *(100 - newPro.getUnitDiscount()) / 100) ;
                                ResultSet rsRate = (ResultSet)request.getAttribute("rsRate");
                                 if(rsRate.next()){
                                 totalRate = (int)rsRate.getDouble(2);  
                                 rateCount = (int)rsRate.getInt(3);
                                 UserRateCount = (int)rsRate.getInt(4);
                                }
                                resultRate = newPro.convertStar(totalRate);
                            %>
                            <span style="font-size: 15px; color: orange"><%=resultRate%></span>
                            <span class="fa fa-2x"><h5 style="font-size: 14px;">(<%=rateCount%>) đánh giá</h5></span>
                            <a href="javascript:void(0);"><%=UserRateCount%> Khách hàng đã đánh giá</a>
                        </h2>
                        <hr/>
                        <h3 class="price-container">
                            <%
                            if(newPro.getUnitDiscount() == 0){%>
                            <%=df.format(realPrice)%>đ
                            <%} else {%>
                            <%=df.format(realPrice)%>đ
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <span style="color: red; text-decoration: line-through"><%=df.format(newPro.getUnitPrice())%>đ</span>
                            <%}%>
                        </h3>
                        <hr/>
                        <div class="description description-tabs">
                            <ul id="myTab" class="nav nav-pills">
                                <li class="active"><a href="#more-information" data-toggle="tab" class="no-margin">Mô tả sản phẩm</a></li>
                                <li class><a href="#reviews" data-toggle="tab">Đánh giá</a></li>
                            </ul>
                            <div id="myTabContent" class="tab-content">
                                <div class="tab-pane fade active in" id="more-information">
                                    <br/>
                                    <strong><%=newPro.getProductName()%></strong>
                                    <div style="white-space: pre-line;">
                                        <%=description%>
                                    </div>

                                </div>
                                <div class="tab-pane fade" id="reviews">
                                    <br/>
                                    <div class="chat-body no-padding profile-message">
                                        <ul>
                                            <li class="message">
                                                <img src="https://bootdey.com/img/Content/avatar/avatar1.png" class="online" />
                                                <span class="message-text">
                                                    <a href="javascript:void(0);" class="username">
                                                        Alisha Molly
                                                    </a>
                                                    <span class="pull-right" style="height: 38px;padding: 10px;">
                                                        <i class="fa fa-star fa-2x text-primary"></i>
                                                        <i class="fa fa-star fa-2x text-primary"></i>
                                                        <i class="fa fa-star fa-2x text-primary"></i>
                                                        <i class="fa fa-star fa-2x text-primary"></i>
                                                        <i class="fa fa-star fa-2x text-muted"></i>
                                                    </span>
                                                    <br/>
                                                    <span>Can't divide were divide fish forth fish to. Was can't form the, living life grass darkness very image let unto fowl isn't in blessed fill life yielding above all moved</span>
                                                </span>
                                                <ul class="list-inline font-xs" style="margin-bottom: 50px;">
                                                    <li style="float:left">
                                                        <small class="text-muted pull-right ultra-light"> Posted 1 year ago </small>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li class="message">
                                                <img src="https://bootdey.com/img/Content/avatar/avatar2.png" class="online" />
                                                <span class="message-text">
                                                    <a href="javascript:void(0);" class="username">
                                                        Aragon Zarko
                                                    </a>
                                                    <span class="pull-right" style="height: 38px;padding: 10px;">
                                                        <i class="fa fa-star fa-2x text-primary"></i>
                                                        <i class="fa fa-star fa-2x text-primary"></i>
                                                        <i class="fa fa-star fa-2x text-primary"></i>
                                                        <i class="fa fa-star fa-2x text-primary"></i>
                                                        <i class="fa fa-star fa-2x text-primary"></i>
                                                    </span>
                                                    <br/>
                                                    Excellent product, love it!
                                                </span>
                                                <ul class="list-inline font-xs" style="margin-bottom: 50px;">
                                                    <li style="float: left">
                                                        <small class="text-muted pull-right ultra-light"> Posted 1 year ago </small>
                                                    </li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr/>
                        <div class="row">
                            <div class="col-sm-12 col-md-6 col-lg-6">
                                <a href="javascript:void(0);" class="btn btn-success btn-lg">Mua ngay</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
        <script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <script type="text/javascript">

        </script>
    </body>
</html>