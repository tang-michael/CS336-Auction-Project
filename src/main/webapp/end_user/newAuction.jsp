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
<title>New Auction</title>
</head>
<body>
    <%
        
        Connection con = DbConnectionManager.getConnection();
    
        //Create a SQL statement
        Statement st = con.createStatement();
        Statement st1 = con.createStatement();
        
        String current_user = (String)session.getAttribute("user");
        String closing_date = request.getParameter("closing_date");
        String closing_time = request.getParameter("closing_time");
        
        out.println("<p> Welcome " + current_user + "</p>");
        
        ResultSet auctionNum = st.executeQuery("SELECT MAX(a.auction_id) FROM auctions a");
        
        int auctionNumber;
        
        if(auctionNum != null){
            auctionNum.next();
            auctionNumber = auctionNum.getInt(1) + 1;
        }
        else{
            auctionNumber = 1;
        }
        
        st1.executeUpdate("INSERT INTO auctions VALUES(" + auctionNumber + ", '" + closing_date + "', '" + closing_time + "', '');");
        
        out.println("<p> The auction with the auction id " + auctionNumber + " has been created</p>");
        out.println("<a href = setAuction.jsp?name=" + current_user + "> Return to the previous window </a>");
        con.close();
    %>
</body>
</html>