<%-- 
    Document   : cartdetail
    Created on : Jan 10, 2024, 11:49:22 PM
    Author     : trant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/cartstyle.css"/>
        <link rel="stylesheet" href="css/homestyle.css"/>
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <title>Giỏ Hàng</title>
    </head>
    <body>
        <div id="body">
            <jsp:include page="include/header.jsp"/>
            <section>
                <div class="card">
                    <div class="row">
                        <div class=" cart">
                            <div class="title">
                                <div class="row">
                                    <div class="col"><h4><b>Giỏ hàng</b></h4></div>
                                    <div class="col align-self-center text-right text-muted">3 items</div>
                                </div>
                            </div>    

                            <div class="row main">
                                <!--                                    <div class="col"><img class="img-fluid" src="https://i.imgur.com/1GrakTl.jpg"></div>
                                                                    <div class="col">
                                                                        <div>Shirt</div>
                                                                        <div>Cotton T-shirt</div>
                                                                    </div>
                                                                    <div class="col">
                                                                        <a href="#">-</a><a href="#" class="border">1</a><a href="#">+</a>
                                                                    </div>
                                                                    <div class="col">&euro; 44.00 <span class="close">&#10005;</span></div>-->
                                
                            </div>


                            <div class="back-to-shop"><a href="#">&leftarrow;</a><span class="text-muted">Trở Về</span></div>
                        </div>
                        <div class="summary">
                            <div><h5><b>Summary</b></h5></div>
                            <hr>
                            <div class="row">
                                <div class="col" style="padding-left:0;">ITEMS 3</div>
                                <div class="col text-right">&euro; 132.00</div>
                            </div>
                            <p>Voucher</p>
                            <button class="btn btnvoucher" id="show-voucher">Chọn Voucher</button>

                            <div class="row" style="border-top: 1px solid rgba(0,0,0,.1); padding: 2vh 0;">
                                <div class="col">Tổng Tiền</div>
                                <div class="col text-right">&euro; 137.00</div>
                            </div>
                            <button class="btn">CHECKOUT</button>
                        </div>
                    </div>

                </div>
            </section> 
        </div>
        <div>
            <div class="popup">
                <div class="close-btn">X</div>
                <div class="form">
                    <h2>Voucher</h2>
                    <div class="form-element">
                        <label for="email">Không Có Voucher Nào</label>                                        
                    </div>


                </div>
            </div>

            <script>
                document.querySelector("#show-voucher").addEventListener("click", function () {
                    document.querySelector(".popup").style.display = "block";
                    document.querySelector(".popup").classList.add("active");
                    document.getElementById("body").classList.add("blurred-background");
                });
                document.querySelector(".popup .close-btn").addEventListener("click", function () {
//                    document.querySelector(".popup").classList.remove("active");
                    document.querySelector(".popup").style.display = "none";
                    document.getElementById("body").classList.remove("blurred-background");
                });
            </script>
        </div>

    </body>
</html>