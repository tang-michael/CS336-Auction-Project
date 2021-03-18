<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="project.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>BuyMe</title>
    </head>
    <body>
        <form action="login.jsp" method="post">
            User name :<input type="text" name="usr" />
            <br>
            password :<input type="password" name="password" />
            <br>
            <input type ="submit" value = "Submit" /> 
         </form>
            <p>New user <a href ="register.html">Login Here</a>. 
    </body>
</html>