<%-- 
    Document   : customerlist
    Created on : Jan 31, 2024, 3:38:58 PM
    Author     : trant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="jakarta.servlet.http.HttpSession"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Danh Sách Cài Đặt</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/css_marketing_dashboard/marketing_dashboard_style.css" rel="stylesheet">
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">
    </head>
    <body id="page-top">
        <%
            HttpSession sessionMessage = request.getSession();
            String message =(String)sessionMessage.getAttribute("message");
            
        %>
        <div id="wrapper">
            <!-- Sidebar -->
            <ul class="navbar-nav sidebar sidebar-light accordion" id="accordionSidebar">
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="MarketingDashBoardURL">
                    <div class="sidebar-brand-icon">
                        <img style="height: 91px;
                             width: 133px;
                             margin-bottom: -18px;" src="images/logo/logo.png">
                    </div>
                </a>
                <div style="position: sticky; top: 30px;">
                    <hr class="sidebar-divider wee-0" style="margin: 0px;">
                    <li class="nav-item active">
                        <a class="nav-link" href="MarketingDashBoardURL">
                            <i class="fas fa-fw fa-tachometer-alt"></i>
                            <span>Thống kê</span></a>
                    </li>
                    <hr class="sidebar-divider">
                    <li class="nav-item">
                        <a class="nav-link" href="adminOrderTrackURL?status=all&orderFrom=&orderTo=">
                            <i class="fas fa-calendar fa-2x text-primary"></i>
                            <span>Đơn hàng</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="userlist">
                            <span>Người dùng</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="settinglist">
                            <span>Cài đặt</span>
                        </a>
                    </li>
                </div>
            </ul>
            <!-- Sidebar -->
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <!-- TopBar -->
                    <nav class="navbar navbar-expand navbar-light bg-navbar topbar mb-4 static-top">
                        <div style="font-weight: 700;color: white;font-size: 37px;letter-spacing: 2px;font-family: Nunito,-apple-system,BlinkMacSystemFont"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";">Trang Admin</div>
                        <ul class="navbar-nav ml-auto">
                            <div class="topbar-divider d-none d-sm-block"></div>
                            <li class="nav-item dropdown no-arrow">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown"
                                   aria-haspopup="true" aria-expanded="false">
                                    <img class="img-profile rounded-circle" src="images/user/${sessionScope.account.userImage}" style="max-width: 60px">
                                    <span class="ml-2 d-none d-lg-inline text-white small">${sessionScope.account.firstName}&nbsp;${sessionScope.account.lastName}</span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Hồ sơ
                                    </a>
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Cài đặt
                                    </a>
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Lịch sử thay đổi
                                    </a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="logout">
                                        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Đăng xuất
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </nav>
                    <!-- Topbar -->

                    <!-- Container Fluid-->
                    <div class="container-fluid" id="container-wrapper">
                        <div class="d-sm-flex align-items-center justify-content-between mb-4">
                            <h1 class="h3 mb-0 text-gray-800">Danh Sách Cài Đặt</h1>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="./">Trang Chủ</a></li>
                                <li class="breadcrumb-item active">Danh Sách Cài Đặt</li>
                            </ol>
                        </div>

                        <!-- Row -->
                        <div<%if(message == null){%> style="display: none"<%}%>>
                            <%if(message != null){%>
                            <%if(message.equals("Thêm thành công")){%>
                            <div class="alert alert-success alert-dismissible" role="alert" style="width: 40%" >
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <h6><i class="fas fa-check"></i><b>  <%=message%></b></h6>
                            </div>
                            <%}%>
                            <%if(message.equals("Email đã tồn tại")){%>
                            <div class="alert alert-warning alert-dismissible" role="alert" style="width: 40%">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <h6><i class="fas fa-check"></i><b>  <%=message%></b></h6>
                            </div>
                            <%}}%>
                        </div>
                        <%sessionMessage.removeAttribute("message");%>
                        <div class="row">
                            <button style="margin-left: 13px;margin-bottom: 5px;" type="button" class="btn btn-secondary" data-toggle="modal" data-target="#exampleModalLong"
                                    id="#modalLong">Thêm Cài Đặt Mới</button>
                        </div>
                        <div class="row">
                            <!-- DataTable with Hover -->
                            <div class="col-lg-12">
                                <div class="card mb-4">                                 
                                    <div class="table-responsive p-3">
                                        <table class="table align-items-center table-flush table-hover" id="dataTableHover13" style="font-size: 14px;">
                                            <div style="display: flex;
                                                 margin-left: 200px;
                                                 margin-bottom: -29px;">
                                                <%
                                                String status = (String)request.getAttribute("status");
                                                String type = (String)request.getAttribute("type");
                                                %>
                                                <form action="settinglist" method="get">
                                                    <div class="filter-group" style="display:flex;align-items: baseline;">
                                                        <div style="margin-right: 14px;">Loại</div>
                                                        <select class="form-control" name="type" onchange="this.form.submit()" style="height: 33px;margin-top: -12px;">   
                                                            <option value="0" <%if(type.equals("0")){%>selected<%}%>>Tất cả</option>
                                                            <option value="1" <%if(type.equals("1")){%>selected<%}%>>Danh mục</option>							
                                                            <option value="2" <%if(type.equals("2")){%>selected<%}%>>Sản phẩm</option>							
                                                        </select>

                                                        <div style="width: 104%;
                                                             margin-left: 15px;margin-right: 15px;">Trạng thái</div>
                                                        <select class="form-control" name="status" onchange="this.form.submit()" style="height: 33px;margin-top: -12px;width: 130px;">                                                            
                                                            <option value="3" <%if(status.equals("3")){%>selected<%}%>>Tất cả</option>                                                     
                                                            <option value="1" <%if(status.equals("1")){%>selected<%}%>>Kích hoạt</option>                                                          
                                                            <option value="0" <%if(status.equals("0")){%>selected<%}%>>Vô hiệu hóa</option>                                                            
                                                        </select>

                                                    </div>       
                                                    <input type="submit" style="display: none;">
                                                    <input type="hidden" name="service" value="fillter"/>
                                                </form>
                                            </div>
                                            <thead class="thead-light">
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Tên</th>
                                                    <th>Loại</th>
                                                    <th>Trạng Thái</th>	
                                                    <th>Yêu cầu</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${requestScope.listsetting}" var="setting">
                                                    <tr style="text-align: center; cursor: pointer" onclick="settingDetails(${setting.settingID})">
                                                        <td>${setting.settingID}</td>
                                                        <td>${setting.settingName}</td>
                                                        <td>
                                                            <c:if test="${setting.settingValue == 1}"><span class="badge badge-success">Danh mục</span></c:if>
                                                            <c:if test="${setting.settingValue == 2}"><span class="badge badge-danger">Sản phẩm</span></c:if>
                                                            </td>
                                                        <td>
                                                            <c:if test="${setting.settingStatus == 1}"><span class="badge badge-success">Kích hoạt</span></c:if>
                                                            <c:if test="${setting.settingStatus == 0}"><span class="badge badge-danger">Vô hiệu hóa</span></c:if>
                                                            </td>
                                                            <td>${setting.settingOrder}</td>
                                                    </tr>
                                                </c:forEach>    
                                            </tbody>
                                        </table>
                                    </div>                                    
                                </div>
                            </div>
                        </div>
                        <!--Row-->
                        <!-- Modal Long -->
                        <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog"
                             aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <form action="settinglist" method="post">
                                    <input type="hidden" name="service" value="addsetting"/>
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="exampleModalLongTitle">Thêm Cài Đặt</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">  
                                            <div class="form-element form-group">                                              
                                                <label for="registerEmail">Loại</label>                                               
                                                <input type="text" name="settingname1" placeholder="Nhập Loại" required class="form-control">
                                            </div>
                                            <div class="form-element form-group">                                              
                                                <label for="registerEmail">Giá trị</label>                                               
                                                <input type="text" name="settingvalue1" placeholder="Nhập Giá trị" required class="form-control">
                                            </div>

                                            <div class="form-element form-group">                                              
                                                <label for="registerEmail">Yêu cầu</label>                                               
                                                <input type="text" name="settingorder1" placeholder="Nhập Yêu cầu" required class="form-control"
                                                       pattern="[0-9 ]+">
                                            </div>
                                            <div class="form-element">
                                                <label for="registerEmail">Mô tả</label>
                                                <input type="text" name="settingdes1" placeholder="Nhập Mô tả" required class="form-control">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Đóng</button>
                                            <button type="submit" class="btn btn-primary">Lưu</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>      
                </div>
                <!---Container Fluid-->
            </div>
        </div>
        <!-- Scroll to top -->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
        <!--        <script src="js_marketing/ruang-admin.min.js"></script>
        --><script src="js_marketing/customerlist.js"></script>  
        <script src="vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

        <!-- Page level custom scripts -->
        <script>
                                                        $('#dataTableHover13').DataTable({
                                                            columns: [
                                                                {searchable: false},
                                                                {searchable: true},
                                                                {searchable: false},
                                                                {searchable: false},
                                                                {searchable: false}],
                                                            search: {
                                                                placeholder: 'Type search here'
                                                            }
                                                        });
                                                        function settingDetails(uid) {
                                                            var url = "settingdetails?uid=" + uid;
                                                            window.location.href = url;
                                                        }

        </script>
    </body>
</html>