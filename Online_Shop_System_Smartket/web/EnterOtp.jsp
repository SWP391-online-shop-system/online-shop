<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>

        <link
            href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
            rel="stylesheet" id="bootstrap-css">
        <script
        src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <!------ Include the above in your HEAD tag ---------->

        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

        <style type="text/css">
            .form-gap {
                padding-top: 70px;
            }
            .green-button {
                background-color: #28a745;
                color: white;
            }
        </style>
    </head>

    <body>
        <div class="form-gap"></div>
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="text-center">
                                <h3>
                                    <i class="fa fa-lock fa-4x"></i>
                                </h3>
                                <h2 class="text-center">Điền OTP</h2>
                                <%
if(request.getAttribute("message")!=null)
{
        out.print("<p class='text-danger ml-1'>"+request.getAttribute("message")+"</p>");
}
		  
                                %>

                                <div class="row">
                                    <div class="col-md-12 text-center">
                                        <p>Không nhận được email? <a href="resendOTP" class="resend-link">Gửi lại email</a></p>
                                    </div>
                                </div>

                                <style>
                                    .resend-link {
                                        color: #007bff; /* Màu chữ sử dụng Bootstrap */
                                        text-decoration: underline; /* Gạch chân văn bản */
                                    }

                                    .resend-link:hover {
                                        color: #0056b3; /* Màu chữ khi di chuột qua */
                                    }
                                </style>
                                <div class="panel-body">

                                    <form id="register-form" action="validateOtp" role="form" autocomplete="off"
                                          class="form" method="post">

                                        <div class="form-group">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i
                                                        class="glyphicon glyphicon-envelope color-blue"></i></span> <input
                                                    id="opt" name="otp" placeholder="Nhập OTP"
                                                    class="form-control" type="text" maxlength="6" required="required">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <input name="recover-submit"
                                                   class="btn btn-lg btn-primary btn-block green-button"
                                                   value="Tạo mật khẩu mới" type="submit">
                                        </div>

                                        <input type="hidden" class="hide" name="token" id="token"
                                               value="">
                                    </form>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

