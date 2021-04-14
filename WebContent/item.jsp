<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="project.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="css/item.css" rel="stylesheet" type="text/css" />
<title>Insert title here</title>
</head>
<body>
	<%
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
	
		Statement stItems = null;
		ResultSet rsItems = null;
		
		String sql = "select * from item where item_id=" + request.getParameter("item_id");
		System.out.println(sql);
		stItems = con.createStatement(); 
		rsItems = stItems.executeQuery(sql);
		rsItems.next();
		
		String current_user = request.getParameter("name");
		out.println("<h1>Item</h1>");
	
	%>
	
	<a href="user.jsp?name=<%=current_user%>">Go Back</a>
	<div class="item-body">
		<b>Seller:</b><%=rsItems.getString("login_id")%>
		<br />
		<b>Item ID:</b><%=rsItems.getString("item_id")%>
		<br />
		<b>Current Bid:</b><%=rsItems.getString("current_bid")%>
		<br />
		<b>Item Type:</b><%=rsItems.getString("item_type")%>
		<br />
		<b>Brand:</b> <%=rsItems.getString("brand")%>
		<br />
		<b>Initial Price:</b> <%=rsItems.getString("initial_price")%>
		<br />
		<b>Min Increment:</b><%=rsItems.getString("min_increment")%>
	</div>
	<br />
	Bid:<input type="text" name="bid_price" />
    <br>
    Autobid (Optional):<input type="text" name="autobid_price" />
    <br>
    <input type ="submit" value = "Submit" />
	<%
	con.close();
	%>
</body>
</html>