<%-- 
    Document   : productList
    Created on : Jan 17, 2024, 2:48:42 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Male_Fashion Template">
        <meta name="keywords" content="Male_Fashion, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>San pham</title>

        <!-- Css Styles -->
        <link rel="stylesheet" href="css/css_header/header.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/magnific-popup.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/nice-select.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/owl.carousel.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/style.css" type="text/css">
        <link rel="stylesheet" href="css/css_footer/footer.css" type="text/css">
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>

    </head>

    <body>
        <jsp:include page="include/header.jsp"/>
        <!-- Shop Section Begin -->
        <section class="shop spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <div class="shop__sidebar">
                            <div class="shop__sidebar__search">
                                <form action="#">
                                    <input type="text" placeholder="Search...">
                                    <button type="submit"><span class="icon_search"></span></button>
                                </form>
                            </div>
                            <div class="shop__sidebar__accordion">
                                <div class="accordion" id="accordionExample">
                                    <div class="card">
                                        <div class="card-heading">
                                            <a data-toggle="collapse" data-target="#collapseOne">Danh mục</a>
                                        </div>
                                        <div id="collapseOne" class="collapse show" data-parent="#accordionExample">
                                            <div class="card-body">
                                                <div class="shop__sidebar__categories">
                                                    <ul class="nice-scroll">
                                                        <li><a href="#">Men (20)</a></li>
                                                        <li><a href="#">Women (20)</a></li>
                                                        <li><a href="#">Bags (20)</a></li>
                                                        <li><a href="#">Clothing (20)</a></li>
                                                        <li><a href="#">Shoes (20)</a></li>
                                                        <li><a href="#">Accessories (20)</a></li>
                                                        <li><a href="#">Kids (20)</a></li>
                                                        <li><a href="#">Kids (20)</a></li>
                                                        <li><a href="#">Kids (20)</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card">
                                        <div class="card-heading">
                                            <a data-toggle="collapse" data-target="#collapseThree">Lọc theo giá tiền</a>
                                        </div>
                                        <div id="collapseThree" class="collapse show" data-parent="#accordionExample">
                                            <div class="card-body">
                                                <div class="shop__sidebar__price">
                                                    <ul>
                                                        <li><a href="#">$0.00 - $50.00</a></li>
                                                        <li><a href="#">$50.00 - $100.00</a></li>
                                                        <li><a href="#">$100.00 - $150.00</a></li>
                                                        <li><a href="#">$150.00 - $200.00</a></li>
                                                        <li><a href="#">$200.00 - $250.00</a></li>
                                                        <li><a href="#">250.00+</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card">
                                        <div class="card-heading">
                                            <a data-toggle="collapse" data-target="#collapseSix">Tags</a>
                                        </div>
                                        <div id="collapseSix" class="collapse show" data-parent="#accordionExample">
                                            <div class="card-body">
                                                <div class="shop__sidebar__tags">
                                                    <a href="#">Product</a>
                                                    <a href="#">Bags</a>
                                                    <a href="#">Shoes</a>
                                                    <a href="#">Fashio</a>
                                                    <a href="#">Clothing</a>
                                                    <a href="#">Hats</a>
                                                    <a href="#">Accessories</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-9">
                        <div class="shop__product__option">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6">
                                    <div class="shop__product__option__left">
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6">
                                    <div class="shop__product__option__right">
                                        <p>Sort by Price:</p>
                                        <select>
                                            <option value="">Low To High</option>
                                            <option value="">$0 - $55</option>
                                            <option value="">$55 - $100</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg">
                                        <img src="images/product/lgtv1.png" alt="alt"/>
                                        <ul class="product__hover">
                                            <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
                                            <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a>
                                            </li>
                                            <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
                                        </ul>
                                    </div>
                                    <div class="product__item__text">
                                        <h6>Piqué Biker Jacket</h6>
                                        <a href="#" class="add-cart">+ Add To Cart</a>
                                        <div class="rating">
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                        </div>
                                        <h5>$67.24</h5>
                                        <div class="product__color__select">
                                            <label for="pc-4">
                                                <input type="radio" id="pc-4">
                                            </label>
                                            <label class="active black" for="pc-5">
                                                <input type="radio" id="pc-5">
                                            </label>
                                            <label class="grey" for="pc-6">
                                                <input type="radio" id="pc-6">
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item sale">
                                    <div class="product__item__pic set-bg" data-setbg="img/product/product-3.jpg">
                                        <span class="label">Sale</span>
                                        <ul class="product__hover">
                                            <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
                                            <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a>
                                            </li>
                                            <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
                                        </ul>
                                    </div>
                                    <div class="product__item__text">
                                        <h6>Multi-pocket Chest Bag</h6>
                                        <a href="#" class="add-cart">+ Add To Cart</a>
                                        <div class="rating">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star-o"></i>
                                        </div>
                                        <h5>$43.48</h5>
                                        <div class="product__color__select">
                                            <label for="pc-7">
                                                <input type="radio" id="pc-7">
                                            </label>
                                            <label class="active black" for="pc-8">
                                                <input type="radio" id="pc-8">
                                            </label>
                                            <label class="grey" for="pc-9">
                                                <input type="radio" id="pc-9">
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg" data-setbg="img/product/product-4.jpg">
                                        <ul class="product__hover">
                                            <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
                                            <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a>
                                            </li>
                                            <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
                                        </ul>
                                    </div>
                                    <div class="product__item__text">
                                        <h6>Diagonal Textured Cap</h6>
                                        <a href="#" class="add-cart">+ Add To Cart</a>
                                        <div class="rating">
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                        </div>
                                        <h5>$60.9</h5>
                                        <div class="product__color__select">
                                            <label for="pc-10">
                                                <input type="radio" id="pc-10">
                                            </label>
                                            <label class="active black" for="pc-11">
                                                <input type="radio" id="pc-11">
                                            </label>
                                            <label class="grey" for="pc-12">
                                                <input type="radio" id="pc-12">
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item sale">
                                    <div class="product__item__pic set-bg" data-setbg="img/product/product-6.jpg">
                                        <span class="label">Sale</span>
                                        <ul class="product__hover">
                                            <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
                                            <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a>
                                            </li>
                                            <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
                                        </ul>
                                    </div>
                                    <div class="product__item__text">
                                        <h6>Ankle Boots</h6>
                                        <a href="#" class="add-cart">+ Add To Cart</a>
                                        <div class="rating">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star-o"></i>
                                        </div>
                                        <h5>$98.49</h5>
                                        <div class="product__color__select">
                                            <label for="pc-16">
                                                <input type="radio" id="pc-16">
                                            </label>
                                            <label class="active black" for="pc-17">
                                                <input type="radio" id="pc-17">
                                            </label>
                                            <label class="grey" for="pc-18">
                                                <input type="radio" id="pc-18">
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg" data-setbg="img/product/product-7.jpg">
                                        <ul class="product__hover">
                                            <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
                                            <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a>
                                            </li>
                                            <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
                                        </ul>
                                    </div>
                                    <div class="product__item__text">
                                        <h6>T-shirt Contrast Pocket</h6>
                                        <a href="#" class="add-cart">+ Add To Cart</a>
                                        <div class="rating">
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                        </div>
                                        <h5>$49.66</h5>
                                        <div class="product__color__select">
                                            <label for="pc-19">
                                                <input type="radio" id="pc-19">
                                            </label>
                                            <label class="active black" for="pc-20">
                                                <input type="radio" id="pc-20">
                                            </label>
                                            <label class="grey" for="pc-21">
                                                <input type="radio" id="pc-21">
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg" data-setbg="img/product/product-8.jpg">
                                        <ul class="product__hover">
                                            <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
                                            <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a>
                                            </li>
                                            <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
                                        </ul>
                                    </div>
                                    <div class="product__item__text">
                                        <h6>Basic Flowing Scarf</h6>
                                        <a href="#" class="add-cart">+ Add To Cart</a>
                                        <div class="rating">
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                        </div>
                                        <h5>$26.28</h5>
                                        <div class="product__color__select">
                                            <label for="pc-22">
                                                <input type="radio" id="pc-22">
                                            </label>
                                            <label class="active black" for="pc-23">
                                                <input type="radio" id="pc-23">
                                            </label>
                                            <label class="grey" for="pc-24">
                                                <input type="radio" id="pc-24">
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg" data-setbg="img/product/product-9.jpg">
                                        <ul class="product__hover">
                                            <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
                                            <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a>
                                            </li>
                                            <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
                                        </ul>
                                    </div>
                                    <div class="product__item__text">
                                        <h6>Piqué Biker Jacket</h6>
                                        <a href="#" class="add-cart">+ Add To Cart</a>
                                        <div class="rating">
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                        </div>
                                        <h5>$67.24</h5>
                                        <div class="product__color__select">
                                            <label for="pc-25">
                                                <input type="radio" id="pc-25">
                                            </label>
                                            <label class="active black" for="pc-26">
                                                <input type="radio" id="pc-26">
                                            </label>
                                            <label class="grey" for="pc-27">
                                                <input type="radio" id="pc-27">
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item sale">
                                    <div class="product__item__pic set-bg" data-setbg="img/product/product-10.jpg">
                                        <span class="label">Sale</span>
                                        <ul class="product__hover">
                                            <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
                                            <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a>
                                            </li>
                                            <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
                                        </ul>
                                    </div>
                                    <div class="product__item__text">
                                        <h6>Multi-pocket Chest Bag</h6>
                                        <a href="#" class="add-cart">+ Add To Cart</a>
                                        <div class="rating">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star-o"></i>
                                        </div>
                                        <h5>$43.48</h5>
                                        <div class="product__color__select">
                                            <label for="pc-28">
                                                <input type="radio" id="pc-28">
                                            </label>
                                            <label class="active black" for="pc-29">
                                                <input type="radio" id="pc-29">
                                            </label>
                                            <label class="grey" for="pc-30">
                                                <input type="radio" id="pc-30">
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg" data-setbg="img/product/product-11.jpg">
                                        <ul class="product__hover">
                                            <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
                                            <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a>
                                            </li>
                                            <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
                                        </ul>
                                    </div>
                                    <div class="product__item__text">
                                        <h6>Diagonal Textured Cap</h6>
                                        <a href="#" class="add-cart">+ Add To Cart</a>
                                        <div class="rating">
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                        </div>
                                        <h5>$60.9</h5>
                                        <div class="product__color__select">
                                            <label for="pc-31">
                                                <input type="radio" id="pc-31">
                                            </label>
                                            <label class="active black" for="pc-32">
                                                <input type="radio" id="pc-32">
                                            </label>
                                            <label class="grey" for="pc-33">
                                                <input type="radio" id="pc-33">
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item sale">
                                    <div class="product__item__pic set-bg" data-setbg="img/product/product-12.jpg">
                                        <span class="label">Sale</span>
                                        <ul class="product__hover">
                                            <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
                                            <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a>
                                            </li>
                                            <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
                                        </ul>
                                    </div>
                                    <div class="product__item__text">
                                        <h6>Ankle Boots</h6>
                                        <a href="#" class="add-cart">+ Add To Cart</a>
                                        <div class="rating">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star-o"></i>
                                        </div>
                                        <h5>$98.49</h5>
                                        <div class="product__color__select">
                                            <label for="pc-34">
                                                <input type="radio" id="pc-34">
                                            </label>
                                            <label class="active black" for="pc-35">
                                                <input type="radio" id="pc-35">
                                            </label>
                                            <label class="grey" for="pc-36">
                                                <input type="radio" id="pc-36">
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg" data-setbg="img/product/product-13.jpg">
                                        <ul class="product__hover">
                                            <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
                                            <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a>
                                            </li>
                                            <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
                                        </ul>
                                    </div>
                                    <div class="product__item__text">
                                        <h6>T-shirt Contrast Pocket</h6>
                                        <a href="#" class="add-cart">+ Add To Cart</a>
                                        <div class="rating">
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                        </div>
                                        <h5>$49.66</h5>
                                        <div class="product__color__select">
                                            <label for="pc-37">
                                                <input type="radio" id="pc-37">
                                            </label>
                                            <label class="active black" for="pc-38">
                                                <input type="radio" id="pc-38">
                                            </label>
                                            <label class="grey" for="pc-39">
                                                <input type="radio" id="pc-39">
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg" data-setbg="img/product/product-14.jpg">
                                        <ul class="product__hover">
                                            <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
                                            <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a>
                                            </li>
                                            <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
                                        </ul>
                                    </div>
                                    <div class="product__item__text">
                                        <h6>Basic Flowing Scarf</h6>
                                        <a href="#" class="add-cart">+ Add To Cart</a>
                                        <div class="rating">
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                        </div>
                                        <h5>$26.28</h5>
                                        <div class="product__color__select">
                                            <label for="pc-40">
                                                <input type="radio" id="pc-40">
                                            </label>
                                            <label class="active black" for="pc-41">
                                                <input type="radio" id="pc-41">
                                            </label>
                                            <label class="grey" for="pc-42">
                                                <input type="radio" id="pc-42">
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="product__pagination">
                                    <a class="active" href="#">1</a>
                                    <a href="#">2</a>
                                    <a href="#">3</a>
                                    <span>...</span>
                                    <a href="#">21</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Shop Section End -->

        <!-- Footer Section Begin -->
        <footer class="footer_1">
            <div class="container_1" style="height: 270px;padding-top: 28px;">
                <div class="row_1">
                    <div class="col_1" id="company">
                        <img src="images/logo/logo.png" alt="" class="logo_1">
                        <p style="font-family: poppins;font-size: 15px;color: white;">
                            công ty Smartket Việt Nam, 54 Liễu Giai, quận Ba Đình, Hà Nội 
                        </p>
                        <div class="social_1">
                            <a href="#"><i class="fab fa-facebook"></i></a>
                            <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
                        </div>
                    </div>


                    <div class="col_1" id="services">
                        <h3 class="footer_title_1">Dịch vụ</h3>
                        <div class="links_1">
                            <a href="#">Tuyển dụng</a>
                            <a href="#">Quảng cáo</a>
                            <a href="#">Chính sách</a>
                        </div>
                    </div>

                    <div class="col_1" id="useful-links" style="margin-left: 50px;margin-right: 50px;">
                        <h3 class="footer_title_1">Đường dẫn</h3>
                        <div class="links_1">
                            <a href="#">Về chúng tôi</a>
                            <a href="#">Danh mục</a>
                            <a href="#">Tin tức</a>
                            <a href="#">Hỗ trợ</a>
                        </div>
                    </div>

                    <div class="col_1" id="contact">
                        <h3 class="footer_title_1">Liên hệ</h3>
                        <div class="contact-details_1">
                            <i class="fa-regular fa-envelope"></i>
                            <p style="color: white;">Smartket@gmail.com</p>
                        </div>
                        <div class="contact-details_1">
                            <i class="fa fa-phone"></i>
                            <p style="color: white;">+84 99.999.999</p>
                        </div>
                    </div>
                </div>

                <div class="row_1">
                    <div class="form_1" style="margin-top: -56px;">
                        <form action="">
                            <input class="email-input_1" style="height: 40px;" type="text" placeholder="Email here...">
                            <button class="email-button_1" style="height: 43px;padding-top: 10px;"><i class="fa fa-paper-plane"></i></button>
                        </form>
                    </div>
                </div>
            </div>
        </footer>
        <!-- Footer Section End -->

        <!-- Search Begin -->
        <div class="search-model">
            <div class="h-100 d-flex align-items-center justify-content-center">
                <div class="search-close-switch">+</div>
                <form class="search-model-form">
                    <input type="text" id="search-input" placeholder="Search here.....">
                </form>
            </div>
        </div>

        <!-- Search End -->

        <!-- Js Plugins -->
    </body>

</html>