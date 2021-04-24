<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="persistence.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="css/item.css" rel="stylesheet" type="text/css" />
<link href="../css/core.css" rel="stylesheet" />
<title>Item</title>
</head>
<body>
    <%
       
        DbConnectionManager db = new DbConnectionManager();
        Connection con = db.getDbConnection();
    
        Statement stItems = null;
        ResultSet rsItems = null;
        
        String sql = "select * from item where item_id = " + request.getParameter("item_id");
        System.out.println(sql);
        stItems = con.createStatement(); 
        rsItems = stItems.executeQuery(sql);
        rsItems.next();
        
        String current_user = request.getParameter("name");
        out.println("<h1>Item</h1>");
    
    %>
    
    <div class="item-body">
        <div class="item-header">
            <b>Seller:</b><%=rsItems.getString("login_id")%>
        </div>
        <br />
        <div class="item-description">
            <b>Item Type:</b><%=rsItems.getString("item_type")%>
            <br />
            <b>Brand:</b> <%=rsItems.getString("brand")%>
        </div>
        <br />
        <div class="item-price">
            <b>Current Bid:</b><%=rsItems.getString("current_bid")%>
            <br />
            <b>Initial Price:</b> <%=rsItems.getString("initial_price")%>
        </div>
        

    </div>
    <br />
    <form action="bidItem.jsp" method="post">
        <%
        Timestamp currentdate = new Timestamp(System.currentTimeMillis());
        
        String closing_date = rsItems.getString("closing_date");
        String closing_time = rsItems.getString("closing_time");
        
        Timestamp closing_date_time = new Timestamp(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(closing_date + " " + closing_time).getTime());
        
        if(currentdate.compareTo(closing_date_time) > 0){
            out.println("<p>This auction is closed. Please do not place a bid</p>");
            out.println("<br><p>Return to the previous page<a href = setAuction.jsp>Auctions</a></p>");
        }
        %>
        Bid:<input type="text" name="bid_price" required/>
        <br>
        <input type ="hidden" id="item_id" name="item_id" value=<%=request.getParameter("item_id")%>>
        
        <input type ="submit" value = "Submit" />
    </form>
    <%
    con.close();
    %>
</body>
</html>