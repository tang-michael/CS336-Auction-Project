<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="persistence.db.*"%>
<%@ page import="java.io.*,java.util.*,java.text.SimpleDateFormat,java.util.Date,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/user.css" rel="stylesheet" type="text/css" />
<link href="../css/core.css" rel="stylesheet" />
<title>Auctions</title>
</head>
<body>

    <%

    Connection con = DbConnectionManager.getConnection();
    Statement stItems = null;
    ResultSet rsItems = null;
    
    String current_user = (String)session.getAttribute("user");
    
    out.println("Welcome " + current_user);
    
    out.println("<a href = newAuctionDetails.jsp?name=" + current_user + ">Create a new Auction</a>");
    %>
    <section class="user-heading">
        <h1>Auctions</h1>
        <% 
        String sql = "select * from auctions";
        stItems = con.createStatement(); 
        rsItems = stItems.executeQuery(sql);
        %>
    </section>
    
    <section class="user_items">
        <h3>Current Auctions</h3>
        <table>
            <thead>
    
                <tr>
                    <th>Auction Id</th>
                    <th>Closing Date</th>
                    <th>Closing Time</th>
                </tr>
            </thead>
            <tbody>
                <%
                while (rsItems.next()) {
                    String id = rsItems.getString("auction_id");
                    String date = rsItems.getString("closing_date");
                    String time = rsItems.getString("closing_time");
                    
                    
                    String dateStamp = new SimpleDateFormat("yyyy-mm-dd").format(Calendar.getInstance());
                    String timeStamp = new SimpleDateFormat("hh:mm:ss").format(Calendar.getInstance().getTime());
                    
                %>
                <tr>
                    <td><a href="auction.jsp?auction_id=<%=id%>"><%=id%></a></td>
                    <td><%=date%></td>
                    <td><%=time%></td>
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