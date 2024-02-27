<%-- 
    Document   : linkExpired
    Created on : Feb 3, 2024, 12:24:30 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Expired Link</title>
        <<link rel="stylesheet" href="css/expiredLink.css"/>
    </head>
    <body>
        <div class="expired">
            <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                 viewBox="0 0 464 390.4" style="enable-background:new 0 0 464 390.4;" xml:space="preserve">
            
            <circle class="st0" cx="126" cy="175.4" r="12"/>
            <circle class="st0" cx="339" cy="175.4" r="12"/>
            <circle class="st1" cx="232.5" cy="170.9" r="106.5"/>
            <path class="st2" d="M126,164.4c0,0,4.5-15.4,10.5-19.6c0,0,31,0,65-26.5c0,0,110,85.9,176-30.8c0,0-33,28.6-116-41.4
                  c0,0-131-16.2-135.5,106V164.4z"/>
            <path class="st2" d="M339,164.4c0,0,6.2-13.3-8.2-32.4l-6.3,3.9C324.5,135.9,333.5,142.9,339,164.4z"/>
            <path class="st2" d="M247.8,45.3c0,0,47.7-5.3,76.7,53.7L247.8,45.3z"/>
            <circle class="st2" cx="192" cy="175.4" r="9"/>
            <circle class="st2" cx="271" cy="175.4" r="9"/>
            <path class="st4" d="M101.4,390.1c22.1-106.8,75.7-114.1,137.1-114.1c61.4,0,104,18.8,130.1,114.1
                  C368.7,390.6,101.3,390.6,101.4,390.1z"/>

            <circle id="path" class="st3 uhoh" cx="234.5" cy="230.5" r="20"/>
            <path class="st3 smile" d="M191,214.4c-1.1-1.5,38.6,49.3,83,0"/>
            </svg>
            <% String userid = (String)request.getAttribute("userid");%>
            <% String email = (String)request.getAttribute("email");%>
            <div class="message">
                <h1>Ôi không, đường link đã hết hạn</h1>
                <p>Đường link này đã hết hạn. <%=userid%></p>
                <a href="signupURL?service=resend&uid=<%=userid%>&remail=<%=email%>">Click vào đây để nhận lại email</a>


            </div>

            <!--   <div class="light">
                <span></span>
                <span></span>
                <span></span>
              </div>
                <div class="light_btm">
                <span></span>
                <span></span>
                <span></span>
              </div> -->
        </div>
    </body>
    
</html>
