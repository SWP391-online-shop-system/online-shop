<%-- 
    Document   : settingList
    Created on : Feb 27, 2024, 4:20:03 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>
<%@page import="java.util.Vector" %>
<%@page import="view.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .error-message {
                color: red;
            }
        </style>
    </head>
    <body>
        <%
            DAOSetting daoS = new DAOSetting();
         ResultSet rsSetting = (ResultSet)request.getAttribute("rsSetting");%>
        <form action="SettingListURL" method="POST">
            <%while(rsSetting.next()){%>
            <input type="hidden" name="SettingID" value="<%=rsSetting.getInt("SettingID")%>">
            <div><%=rsSetting.getString("SettingName")%></div>
            <input type="number" name="valueSettingHomePage" min="6" value="<%=rsSetting.getString("SettingValue")==null?"6":rsSetting.getString("SettingValue")%>">
            <%}%>
            <button type="submit">Luu</button>
        </form>
    </body>
</html>
