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
			<br />
			<b>Min Increment:</b><%=rsItems.getString("min_increment")%>
		</div>
		

	</div>
	<br />
	<form action="bidItem.jsp?item_id=<%=request.getParameter("item_id")%>&bid_irce=<%=%>">
		Bid:<input type="text" name="bid_price" required/>
	    <br>
	    Autobid (Optional):<input type="text" name="autobid_price" />
	    <br>
	    <input type ="submit" value = "Submit" />
    </form>
	<%
	con.close();
	%>
</body>
</html>