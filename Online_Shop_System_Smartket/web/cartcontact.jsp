<%-- 
    Document   : cartdetail
    Created on : Jan 10, 2024, 11:49:22 PM
    Author     : trant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page import="java.util.Vector,java.sql.SQLException,java.sql.ResultSet" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="view.Categories,view.User" %>
<%@page import="model.DAOCategories" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/cartstyle.css"/>
        <link rel="stylesheet" href="css/css_header/header.css"/>
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <title>Giỏ Hàng</title>
    </head>
    <body>
        <%
            HttpSession session3 = request.getSession();
            User user = (User) session3.getAttribute("account");
           ResultSet rs = (ResultSet)request.getAttribute("data");
           String message ="";
           DecimalFormat decimalFormat = new DecimalFormat("#,###.#");
           double totalprice = 0;
        %>
        <jsp:include page="include/header.jsp"/>
        <section style="display: flex">
            <aside>
                <p> Menu </p>
                <div class="menu-section-content-search-form" style="margin-bottom: 20px;">
                    <form action="searchPageURL" method="get">
                        <input name="keyWord" type="text" placeholder="Bạn cần tìm gì?" style="width: 67%;border-radius: 7px;padding: 8px 2px 8px 6px;"/>
                        <button type="submit" class="search-btn">Tìm kiếm</button>
                    </form>
                </div>
                <a href="HomePageURL"><i class="fa fa-home"></i> Trang Chủ</a>
                <a href="HomePageURL?section=newProduct">Sản Phẩm Mới Nhất</a>
                <p style="font-size: 16px;text-align: center;">Danh Mục Sản Phẩm:</p>
                <!--<label for="touch-1"><span class="content-title-2">Danh Mục Sản Phẩm</span>-->
                <!--<i class="fa-solid fa-angle-down"></i>-->
                <!--</label>-->               
                <!--<input type="checkbox" id="touch-1">--> 
                <ul class="sider-menu-1">
                    <%
                    DAOCategories daoCate = new DAOCategories();
                    Vector<Categories> CateList = daoCate.getCategories("select * from Categories");
                    for(Categories cate: CateList){%>
                    <li><a href="ProductListURL?service=ShowCategory&CategoryID=<%=cate.getCategoryID()%>&index=1"><%=cate.getCategoryName()%></a></li> 
                        <%}%>
                </ul>
            </aside>
            <div class="card">
                <div class="row">
                    <div class="cart-contact">
                        <%
                            int userID = user.getUserID();
                            String firstName = user.getFirstName();
                            String lastName = user.getLastName();
                            String address = user.getAddress();
                            String phone = user.getPhoneNumber();
                            String email = user.getEmail();
                        %>
                        <h4 style="margin-top: -73px;">Thông Tin Người Nhận</h4>
                        <label>Tên Người Nhận
                        </label><br/>
                        <input type="text" value="<%=firstName+" "+lastName%>" required autofocus><br/>
                        <label>Số Điện Thoại Người Nhận
                        </label><br/>
                        <input value="<%=phone%>"required/><br/>
                        <label>Email Người Nhận
                        </label><br/>
                        <input value="<%=email%>"required/><br/>
                        <label>Địa Chỉ Người Nhận
                        </label><br/>
                        <select id="city">
                            <option value="" selected>Chọn tỉnh thành</option>           
                        </select>

                        <select id="district">
                            <option value="" selected>Chọn quận huyện</option>
                        </select>

                        <select id="ward">
                            <option value="" selected>Chọn phường xã</option>
                        </select><br/>

                        <hr/>
                        <input type="text" value="<%=address%>" required/>
                        <button id="goBackButton">Quay lại</button>
                    </div>
                    <div class="summary-order">
                        <h4>Thông Tin Đơn Hàng</h4>
                        <%
                           try {
                               while (rs.next()){
                                double unitPrice = rs.getDouble("UnitPrice");
                                double totalunitprice = unitPrice*rs.getInt("Quantity");
                                totalprice += rs.getInt("Quantity")*unitPrice;
                        %>    
                        <div class="summary-product">
                            <table>
                                <tbody>
                                    <tr>
                                        <td>
                                            <img class="img-fluid" src="<%=rs.getString("ProductURL")%>">
                                        </td>
                                        <td>
                                            <%=rs.getString("ProductName")%><br/>
                                            Số Lượng: <%=rs.getInt("Quantity")%>
                                        </td>
                                    </tr>
                                    <!--                                <tr>
                                                                        <td>
                                                                            <div class="summary-product">
                                                                            </div>
                                                                        </td>
                                                                    </tr>-->
                                </tbody>

                            </table>
                        </div>

                        <%}
                            rs.close(); 
                            } catch (SQLException e) {
                             e.printStackTrace();
                            }
                        %>
                    </div>
                </div>

            </div>
        </section> 
        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
        <script>
            var citis = document.getElementById("city");
            var districts = document.getElementById("district");
            var wards = document.getElementById("ward");
            var Parameter = {
                url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
                method: "GET",
                responseType: "application/json",
            };
            var promise = axios(Parameter);
            promise.then(function (result) {
                renderCity(result.data);
            });

            function renderCity(data) {
                for (const x of data) {
                    var opt = document.createElement('option');
                    opt.value = x.Name;
                    opt.text = x.Name;
                    opt.setAttribute('data-id', x.Id);
                    citis.options.add(opt);
                }
                citis.onchange = function () {
                    district.length = 1;
                    ward.length = 1;
                    if (this.options[this.selectedIndex].dataset.id != "") {
                        const result = data.filter(n => n.Id === this.options[this.selectedIndex].dataset.id);

                        for (const k of result[0].Districts) {
                            var opt = document.createElement('option');
                            opt.value = k.Name;
                            opt.text = k.Name;
                            opt.setAttribute('data-id', k.Id);
                            district.options.add(opt);
                        }
                    }
                };
                district.onchange = function () {
                    ward.length = 1;
                    const dataCity = data.filter((n) => n.Id === citis.options[citis.selectedIndex].dataset.id);
                    if (this.options[this.selectedIndex].dataset.id != "") {
                        const dataWards = dataCity[0].Districts.filter(n => n.Id === this.options[this.selectedIndex].dataset.id)[0].Wards;

                        for (const w of dataWards) {
                            var opt = document.createElement('option');
                            opt.value = w.Name;
                            opt.text = w.Name;
                            opt.setAttribute('data-id', w.Id);
                            wards.options.add(opt);
                        }
                    }
                };
            }
            document.getElementById("goBackButton").addEventListener("click", function () {
                window.history.back();
            });
        </script>
    </body>
</html>