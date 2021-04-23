<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="persistence.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/user.css" rel="stylesheet" type="text/css" />
<link href="../css/core.css" rel="stylesheet" />
<title>Add bid to an item</title>
</head>
<body>

    <%
    
    DbConnectionManager db = new DbConnectionManager();
    Connection con = db.getDbConnection();
    
    Statement stItems = null;
    ResultSet rsItems = null;
    
    String current_user = (String)session.getAttribute("user");
    int auctionId = Integer.parseInt(request.getParameter("auction_id"));
    %>
    <section class="user-heading">
        <div class="user-navbar">
            Welcome <%=current_user %> !
        </div>
        <h1>Auction</h1>
        <% 
        String sql = "select * from item i where i.auction_id = " + auctionId;
        stItems = con.createStatement(); 
        rsItems = stItems.executeQuery(sql);
        %>
    </section>
    
    <section class="user_items">
        <h3>Current Items</h3>
        <table>
            <thead>
    
                <tr>
                    <th>Item Id</th>
                    <th>Seller</th>
                    <th>Current Bid</th>
                    <th>Item type</th>
                    <th>Brand</th>
                    <th>Initial Price</th>
                    <th>Characteristics</th>
                </tr>
            </thead>
            <tbody>
                <%
                while (rsItems.next()) {
                    String id = rsItems.getString("item_id");
                %>
                <tr>
                    <td><a href="item.jsp?item_id=<%=id%>"><%=id%></a></td>
                    <td><%=rsItems.getString("login_id")%></td>
                    <td>$<%=rsItems.getString("current_bid")%></td>
                    <td><%=rsItems.getString("item_type")%></td>
                    <td><%=rsItems.getString("brand")%></td>
                    <td>$<%=rsItems.getString("initial_price")%></td>
                    <td><%=rsItems.getString("characteristics")%></td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </section>
    <%
    con.close();
    %>
</body>
</html>