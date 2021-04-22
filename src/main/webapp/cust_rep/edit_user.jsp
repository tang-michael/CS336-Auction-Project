<%
    String loginId = request.getParameter("loginId");
    if(loginId == null){
        loginId = "$--1-unknown-user-temp--*-page-context-&";
    }

    UserService userService = new UserService();
    Optional<User> userOptional = userService.findUserByLoginId(loginId);
    if(userOptional.isEmpty()){
        response.sendRedirect("user_accounts.jsp?error=No such user.");
        return;
    }

    User user = userOptional.get();
    if(!(user instanceof EndUser) || user.getLoginId().equals("anonymous")){
        response.sendRedirect("user_accounts.jsp?error=Invalid user.");
        return;
    }

    EndUser endUser = (EndUser) user;
%>

<%@ page import="persistence.model.user.User" %>
<%@ page import="controller.AttributeKeys" %>
<%@ page import="service.UserService" %>
<%@ page import="java.util.Optional" %>
<%@ page import="persistence.model.user.EndUser" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Auction - Edit User</title>
    <link href="../css/core.css" rel="stylesheet" />
</head>
<body>
    <div class="navbar">
        <%
            User loggedInUser = (User) request.getSession().getAttribute(AttributeKeys.AUTHENTICATED_USER);
        %>
        <h2 class="navbar-brand">Online Auction System | <%=  loggedInUser.getFullName() %></h2>
        <div class="nav-links right-nav-links">
            <a href="index.jsp">Questions</a>
            <a href="user_accounts.jsp">User Accounts</a>
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

    <form style="margin-bottom: 1rem;" class="container" method="post" action="${pageContext.request.contextPath}/cust_rep/edit_user">
        <h2>Edit User</h2>
        <div>
            <div class="form-group">
                <label>Update First Name</label>
                <input value="<%=endUser.getFname()%>" name="firstName" type="text" class="form-control" />
            </div>
            <div class="form-group">
                <label>Update Last Name</label>
                <input value="<%=endUser.getLname()%>" name="lastName" type="text" class="form-control" />
            </div>
            <div class="form-group">
                <label>Update Email</label>
                <input name="email" value="<%=endUser.getEmail()%>" type="text" class="form-control" />
            </div>
            <div class="form-group">
                <label>Update Password</label>
                <input name="password" type="password" value="<%=endUser.getPwd()%>" class="form-control" />
            </div>
            <input type="hidden" value="<%=endUser.getLoginId()%>" name="loginId"/>
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Submit</button>
            </div>
        </div>
    </form>
</body>
</html>