<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="persistence.model.Question"%>
<%@ page import="service.ItemService"%>
<%@ page import="java.util.List"%>
<%@ page import="controller.AttributeKeys"%>
<%@ page import="persistence.model.user.User"%>
<%@ page import="persistence.model.item.Item"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link href="../css/core.css" rel="stylesheet" />
</head>
<body>
	<div class="navbar">
		<%
		User user = (User) request.getSession().getAttribute(AttributeKeys.AUTHENTICATED_USER);
		String error = request.getParameter(AttributeKeys.ERROR_REQUEST_PARAM);
		%>
		<h2 class="navbar-brand">
			Online Auction System |
			<%=user.getFullName()%></h2>
		<div class="nav-links right-nav-links">
			<a class="active-link" href="index.jsp">Questions</a> <a
				href="ask_question.jsp">Post Question</a> <a href="item_list.jsp">View
				Items</a> <a href="${pageContext.request.contextPath}/logout">Logout</a>
		</div>
	</div>
			<%
			if(error != null){
		    %>
		         <div class="alert alert-danger"><%= error %></div>
		    <%
		        }
			%>
	<div class="item-container">

		<%
		String item_id = request.getParameter("item_id");
		ItemService itemService = new ItemService();
		Item item = itemService.getExactItem(item_id);
		System.out.println(item_id);
		%>

		<div class="item-details">
			<h2><%=item.getItemType() %></h2>
			<br />
			<br />
			<b>Brand:</b> <%=item.getBrand() %>
			<br />
			<br />
			<b>Current Bid:</b> $<%=item.getCurrentBid()%>
			<br />
			<br />
			<b>Closing Date</b> <%=item.getClosingDate() %>
			<br />
			<br />
			<b>Closing Date: </b> <%= item.getClosingTime()%> 
			<br />
			<br />
			<b>Initial Price: </b> $<%=item.getInitialPrice() %> 
			<br />
			<br />
			<b>Current Winner: </b> <%=item.getCurrent_winner() %>
			<br />
			<br />
			<b>Upper Limit: </b> $<%=item.getUpper_limit() %>  
			<br />
			<br />
			<b>User Increment: </b> $<%=item.getUser_increment() %>  
		</div>
		
	
		<form class="login-form" method="post" action="update-autobid?item_id=<%=item_id %>">
	        <h2 class="form-header text-center form-header">Create Bid</h2>
	        <div class="form-group">
	            <label>Bid</label>
	            <input type="text" class="form-control" name="user-bid" required/>
	        </div>
	        <div class="form-group">
	            <label>Upper Limit (Optional)</label>
	            <input type="text" class="form-control" name="upper-limit"/>
	        </div>
	        <div class="form-group">
	            <label>Bid Increment (Optional)</label>
	            <input type="text" class="form-control" name="bid-increment"/>
	        </div>
	        <div class="form-group">
	            <button type="submit" class="btn btn-primary">Submit</button>
	        </div>
   	 </form>
	</div>
</body>
</html>