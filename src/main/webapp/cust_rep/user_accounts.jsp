<%@ page import="controller.AttributeKeys" %>
<%@ page import="persistence.model.user.User" %>
<%@ page import="service.UserService" %>
<%@ page import="persistence.model.user.EndUser" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Auction - User Accounts</title>
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
            <a class="active-link" href="user_accounts.jsp">User Accounts</a>
            <a href="bids.jsp">Bids</a>
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

    <div class="container">
        <h2>User Accounts</h2>
        <%
            UserService userService = new UserService();
            List<EndUser> endUserList = userService.findAllEndUsers();
        %>
        <div>
            <table>
                <tr>
                    <th>User Id</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>

                <% if(endUserList.isEmpty()) {%>
                    <tr>
                        <td colspan="6">
                            No end users found at the moment.
                        </td>
                    </tr>
                <% } %>

                <%
                    for (EndUser endUser : endUserList) {
                %>

                <tr style="padding: .3rem;">
                    <td><%= endUser.getLoginId() %></td>
                    <td><%= endUser.getFname() %></td>
                    <td><%= endUser.getLname() %></td>
                    <td><%= endUser.getEmail() %></td>
                    <td>
                        <a href="edit_user.jsp?loginId=<%=endUser.getLoginId()%>" style="text-decoration: none;">Edit</a>
                    </td>
                    <td>
                        <a style="text-decoration: none;" href="${pageContext.request.contextPath}/cust_rep/delete_user?loginId=<%=endUser.getLoginId()%>">Delete</a>
                    </td>
                </tr>

                <% } %>

               
            </table>

        </div>
    </div>
</body>
</html>