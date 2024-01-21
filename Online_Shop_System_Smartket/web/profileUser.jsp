<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/homestyle.css"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
* {box-sizing: border-box}
body {font-family: "Lato", sans-serif;}

/* Style the tab */
.tab {
  float: left;
  border: 1px solid #ccc;
  background-color: #f1f1f1;
  width: 30%;
  height: 300px;
}

/* Style the buttons inside the tab */
.tab button {
  display: block;
  background-color: inherit;
  color: black;
  padding: 22px 16px;
  width: 100%;
  border: none;
  outline: none;
  text-align: left;
  cursor: pointer;
  transition: 0.3s;
  font-size: 17px;
}

/* Change background color of buttons on hover */
.tab button:hover {
  background-color: #ddd;
}

/* Create an active/current "tab button" class */
.tab button.active {
  background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
  float: left;
  padding: 0px 12px;
  border: 1px solid #ccc;
  width: 70%;
  border-left: none;
  height: 300px;
}
</style>
</head>
<body>
<jsp:include page="include/header.jsp"/>

<div class="tab">
  <button class="tablinks" onclick="openCity(event, 'user')" id="defaultOpen">Tài khoản</button>
  <button class="tablinks" onclick="openCity(event, 'avata')">Ảnh đại diện</button>
  <button class="tablinks" onclick="openCity(event, 'password')">Mật khẩu</button>

</div>


<div id="user" class="tabcontent">
    <h3>Hồ sơ</h3>
 <form action="/changeuserinfo" class="form-container">
    <table border="0" >
   <tr>
      <th></th>
      <th></th>
      
   </tr>
   <tr>
      <td>Họ:</td>
      <td>Tên:</td>
       
     
   </tr>
   <tr>
     <td>   <input type="text" name="firstName" value=""  /></td>
     <td>   <input type="text" name="firstName" value=""  /></td>
    
   </tr>
  <tr>
      <td>Email:</td>
      <td>Số điện thoại:</td>
       
     
   </tr>
    <tr>
     <td>   <input type="text" name="firstName" value=""  /></td>
     <td>   <input type="text" name="firstName" value=""  /></td>
    
   </tr>
    <tr>
      <td>Địa chỉ:</td>
      <td></td>
       
     
   </tr>
   
    <tr>
     <td>   <input type="text" name="firstName" value=""  /></td>
     <td></td>
    
   </tr>
</table>
         <button type="submit" class="btn">Lưu thay đổi</button>

       </form>

</div>


<div id="avata" class="tabcontent">
  

</div>

<div id="password" class="tabcontent">
  <form action="/changepassword" class="form-container">

    <h3>Thay đổi mật khẩu</h3>
  Mật khẩu của bạn phải có ít nhất 6 ký tự, bao gồm cả chữ số, chữ cái và ký tự đặc biệt (!$@%).
<br>
   <br> Mật khẩu hiện tại*<br>
   <input type="password" name="oldPassword" value=""  placeholder="Mật khẩu hiện tại" id="myInput1"/>
   <input type="checkbox" onclick="myFunction1()">Hiển thị mật khẩu<br>
             <br> Mật khẩu mới*<br>
            <input type="password" name="newPassword" value="" placeholder="Mật khẩu mới" id="myInput2"/>
            <input type="checkbox" onclick="myFunction2()">Hiển thị mật khẩu <br>

             <br> Nhập lại mật khẩu mới*<br>
            <input type="password" name="oldPassword" value="" placeholder="Nhập lại mật khẩu mới" id="myInput3"/>
            <input type="checkbox" onclick="myFunction3()">Hiển thị mật khẩu<br>
           

    <button type="submit" class="btn">Lưu mật khẩu</button>

  </form>

</div>


     


</div>

<script>

function myFunction1() {
  var x = document.getElementById("myInput1");
  if (x.type === "password") {
    x.type = "text";
  } else {
    x.type = "password";
  }
}
function myFunction2() {
  var x = document.getElementById("myInput2");
  if (x.type === "password") {
    x.type = "text";
  } else {
    x.type = "password";
  }
}
function myFunction3() {
  var x = document.getElementById("myInput3");
  if (x.type === "password") {
    x.type = "text";
  } else {
    x.type = "password";
  }
}

function openCity(evt, name) {
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }
  document.getElementById(name).style.display = "block";
  evt.currentTarget.className += " active";
}

// Get the element with id="defaultOpen" and click on it
document.getElementById("defaultOpen").click();

</script>

</body>
</html>
