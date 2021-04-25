<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="persistence.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="../css/core.css" rel="stylesheet" />
<title>Success</title>
</head>
<body>
    <%
    try{
        out.println("<p>The user account has been successfully deleted.</p><br>");
        out.println("<p>Please close the window.</p>");
    }
    catch(Exception e){
        e.printStackTrace();
        out.println("Unable to delete the user.");
    }
    %>
</body>
</html>