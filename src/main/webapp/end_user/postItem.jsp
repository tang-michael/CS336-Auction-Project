<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="persistence.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link href="../css/core.css" rel="stylesheet" />
        <title>Post Item</title>
    </head>
    <body>
        
        <form action="setItem.jsp" method="post">
            <input type="radio" id="computerAccessories" name="type" value = "computerAccessories">
            <label for="computerAccessories">Computer Accessories</label>
            <br>
            <input type="radio" id="computers" name="type" value = "computers">
            <label for="computers">Computers</label>
            <br>
            <input type="radio" id="phones" name="type" value = "phones">
            <label for="phones">Phones</label>
            <br>
            <input type="radio" id="cameras" name="type" value = "cameras">
            <label for="cameras">Cameras</label>
            <br>
            Login ID (Please use your own login id):<input type="text" name="login_id" />
            <br>
            Brand Name:<input type="text" name="brandName" />
            <br>
            Initial Price:<input type="text" name="initPrice" />
            <br>
            Item Name :<input type="text" name="itemName" />
            <br>
            Characteristics :<input type="text" name="characteristics" />
            <br>
            Minimum Price (Optional) :<input type="text" name="minPrice" />
            <br>
            Closing Date (Please enter date in yyyy-mm-dd format) :<input type="text" name="closing_date" />
            <br>
            Closing Time (Please enter time in 24hr format in hh:mm:ss) :<input type="text" name="closing_time" />
            <br>
            <input type ="submit" value = "Submit" /> 
        </form>
        
    </body>
</html>