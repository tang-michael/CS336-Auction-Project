<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="persistence.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="css/item.css" rel="stylesheet" type="text/css" />
<link href="../css/core.css" rel="stylesheet" />
<title>Items in the auction</title>
</head>
<body>
    <%
        DbConnectionManager db = new DbConnectionManager();
        Connection con = db.getDbConnection();
        
        String sql = "select * from item where auction_id=" + request.getParameter("auction_id");
        Statement stItems = con.createStatement(); 
        ResultSet rsItems = stItems.executeQuery(sql);
        
        if(!rsItems.next()){
            out.println("<a href = postItem.jsp?auction_id=" + request.getParameter("auction_id") + "> Add a new Item</a>");
        }
        
        else{
            
            out.println("<a href = postItem.jsp?auction_id=" + request.getParameter("auction_id") + "> Add a new Item</a>");
            
            out.println("<br>");
            
            out.println("<a href = viewAuction.jsp?auction_id="+ request.getParameter("auction_id") + ">View the items in the Auction</a>");
        }
        con.close();
    %>
</body>
</html>