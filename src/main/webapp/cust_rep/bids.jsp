<%@ page import="persistence.model.bid.Bid" %>
<%@ page import="java.util.List" %>
<%@ page import="service.BidService" %>
<%@ page import="controller.AttributeKeys" %>
<%@ page import="persistence.model.user.User" %>
<%

    BidService bidService = new BidService();
    List<Bid> bids = bidService.findAllBids();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Auction - Bids</title>
    <link href="../css/core.css" rel="stylesheet" />
</head>
<body>
    <div class="navbar">
        <%
            User user = (User) request.getSession().getAttribute(AttributeKeys.AUTHENTICATED_USER);
        %>
        <h2 class="navbar-brand">Online Auction System | <%=  user.getFullName() %></h2>

        <div class="nav-links right-nav-links">
            <a href="index.jsp">Questions</a>
            <a href="user_accounts.jsp">User Accounts</a>
            <a class="active-link" href="bids.jsp">Bids</a>
            <a href="auctions.jsp">Auctions</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>

    <%
        String error = request.getParameter(AttributeKeys.ERROR_REQUEST_PARAM);
        String info = request.getParameter(AttributeKeys.INFO_REQUEST_PARAM);
        if(error != null){
    %>
    <div class="alert alert-danger"><%= error %></div>
    <%
        }
        if(info != null){
    %>

    <div class="alert alert-info">
        <%= info %>
    </div>

    <%
        }
    %>

    <div class="container" style="margin-bottom: 1rem;">
        <h2>Bids</h2>
        <table>
            <tr>
                <th>Bid Id</th>
                <th>Bidder</th>
                <th>Item</th>
                <th>Item Initial Price</th>
                <th>Bid Amount</th>
                <th>Bid Status</th>
                <th>Delete</th>
            </tr>
            <% if(bids.isEmpty()) {%>
                <tr>
                    <td colspan="7">
                        No bids found yet.
                    </td>
                </tr>
            <% } %>

            <% for (Bid bid : bids) { %>
                <tr>
                    <td>
                        <%= bid.getBidId() %>
                    </td>
                    <td><%= bid.getUser().getFullName() %></td>
                    <td><%= bid.getItem().getItemType() %></td>
                    <td>$<%= bid.getItem().getInitialPrice() %></td>
                    <td>$<%= bid.getOffer() %></td>
                    <td><%= bid.getBidStatus().getDescription() %></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/cust_rep/delete_bid?bidId=<%=bid.getBidId()%>">Delete</a>
                    </td>
                </tr>
            <% } %>

        </table>
    </div>
</body>
</html>