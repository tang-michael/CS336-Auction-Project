<%@ page import="persistence.model.user.User" %>
<%@ page import="controller.AttributeKeys" %>
<%@ page import="service.AuctionService" %>
<%@ page import="persistence.model.Auction" %>
<%@ page import="java.util.List" %>
<%
    AuctionService auctionService = new AuctionService();
    List<Auction> auctionList = auctionService.findAllAuctions();

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Auction - Auctions</title>
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

        <a href="bids.jsp">Bids</a>
        <a class="active-link" href="auctions.jsp">Auctions</a>
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
    <h2>Auctions</h2>
    <table>
        <tr>
            <th>Auction ID</th>
            <th>Histroy of Bids</th>
            <th>Delete Auction</th>
        </tr>

        <% if(auctionList.isEmpty()) {%>
        <tr>
            <td colspan="3">
                No auctions found
            </td>
        </tr>
        <% } %>

        <% for (Auction auction : auctionList) { %>
        <tr>
            <td><%= auction.getAuctionId() %></td>
            <td><%= auction.getHistoryOfBids() %></td>
            <td>
                <a href="${pageContext.request.contextPath}/cust_rep/delete_auction?auctionId=<%=auction.getAuctionId()%>">Delete</a>
            </td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
