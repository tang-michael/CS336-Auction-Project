<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="service.ItemService" %>
<%@ page import="java.util.List" %>
<%@ page import="controller.AttributeKeys" %>
<%@ page import="persistence.model.item.Item" %>
<%@ page import="persistence.model.user.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Items for Auction</title>
 <link href="../css/core.css" rel="stylesheet" />
</head>
<body>
	<div class="navbar">
        <%
            User user = (User) request.getSession().getAttribute(AttributeKeys.AUTHENTICATED_USER);
        %>
        <h2 class="navbar-brand">Online Auction System | <%=  user.getFullName() %></h2>
        <div class="nav-links right-nav-links">
            <a class="active-link" href="index.jsp">Questions</a>
            <a href="ask_question.jsp">Post Question</a>
            <a href="item_list.jsp">View Items</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <h2>Items for Auction</h2>
        <%
            ItemService itemService= new ItemService();
            List<Item> itemList = itemService.findItems();
        %>
        <div>
            <table>
                <tr>
                    <th>Brand</th>
                    <th>Initial Price</th>
                    <th>Min Price</th>
                    <th>Current Bid</th>
                    <th>Closing Date</th>
                    <th>Closing Time</th>
                    <th>Current Winner</th>
                    <th>Increment</th>
                    <th>Regular Bid</th>
                    <th>Auto Bid</th>
                </tr>

                <% if(itemList.isEmpty()) {%>
                    <tr>
                        <td colspan="9">
                            No items found at the moment.
                        </td>
                    </tr>
                <% } %>

                <%
                    for (Item items: itemList) {
                %>

                <tr style="padding: .3rem;">
                    <td><a href="item.jsp?item_id=<%=items.getItemId()%>"><%= items.getBrand() %></a></td>
                    <td><a href="item.jsp?item_id=<%=items.getItemId()%>"><%= items.getInitialPrice() %></a></td>
                    <td><a href="item.jsp?item_id=<%=items.getItemId()%>"><%= items.getMinPrice() %></a></td>
                    <td><a href="item.jsp?item_id=<%=items.getItemId()%>"><%= items.getCurrentBid() %></a></td>
                    <td><a href="item.jsp?item_id=<%=items.getItemId()%>"><%= items.getClosingDate() %></a></td>
                    <td><a href="item.jsp?item_id=<%=items.getItemId()%>"><%= items.getClosingTime() %></a></td>
                     <td><a href="item.jsp?item_id=<%=items.getItemId()%>"><%= items.getCurrent_winner() %></a></td>
                      <td><a href="item.jsp?item_id=<%=items.getItemId()%>"><%= items.getItem_increment() %></a></td>
                      <td><a href="#">Here</a></td>
                      <td><a href="#">Here</a></td>
                </tr>

                <% } %>

               
            </table>

        </div>
    </div>
</body>
</html>