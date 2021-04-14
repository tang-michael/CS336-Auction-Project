<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="project.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/user.css" rel="stylesheet" type="text/css" />
<title>Insert title here</title>
</head>
<body>

	<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

	Statement stItems = null;
	ResultSet rsItems = null;
	
	String current_user = request.getParameter("name");
	%>
	<section class="user-heading">
		<div class="user-navbar">
			Welcome <%=current_user %> !
			<a href='logout.jsp'>Logout</a>
		</div>
		<h1>Auction</h1>
		<% 
		String sql = "select * from item";
		stItems = con.createStatement(); 
		rsItems = stItems.executeQuery(sql);
		%>
	</section>
	
	<section class="user_items">
		<h3>Current Items</h3>
		<table>
			<thead>
	
				<tr>
					<th>Seller</th>
					<th>Current Bid</th>
					<th>Item type</th>
					<th>Brand</th>
					<th>Initial Price</th>
					<th>Min Increment</th>
				</tr>
			</thead>
			<tbody>
				<%
				while (rsItems.next()) {
					String id = rsItems.getString("item_id");
				%>
				<tr>
					<td><a href="item.jsp?item_id=<%=id%>&name=<%=current_user%>"><%=rsItems.getString("login_id")%></a></td>
					<td><%=rsItems.getString("current_bid")%></td>
					<td><%=rsItems.getString("item_type")%></td>
					<td><%=rsItems.getString("brand")%></td>
					<td>$<%=rsItems.getString("initial_price")%></td>
					<td>$<%=rsItems.getString("min_increment")%></td>
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