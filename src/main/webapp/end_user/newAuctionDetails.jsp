<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="persistence.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link href="../css/core.css" rel="stylesheet" />
        <title>New Auction Registration</title>
    </head>
    <body>
        
        <form action="newAuction.jsp" method="post">
            Closing Date (Please enter date in yyyy-mm-dd format) :<input type="text" name="closing_date" />
            <br>
            Closing Time (Please enter time in 24hr format in hh:mm:ss) :<input type="text" name="closing_time" />
            <br>
            <input type ="submit" value = "Submit" /> 
        </form>
        
    </body>
</html>