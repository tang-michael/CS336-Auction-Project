<%@ page import="controller.AttributeKeys" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Auction - Login</title>
    <link href="css/core.css" rel="stylesheet" />
</head>
<body>
    <div class="navbar">
        <h2 class="navbar-brand">Online Auction System</h2>
        <div class="nav-links right-nav-links">
            <a href="index.jsp">Login</a>
            <a href="register.jsp">Register</a>
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


    <form class="login-form" method="post" action="authenticate">
        <h2 class="form-header text-center form-header">Login</h2>
        <div class="form-group">
            <label>Enter your user id</label>
            <input type="text" class="form-control" name="userId" />
        </div>
        <div class="form-group">
            <label>Enter your password</label>
            <input type="password" class="form-control" name="password"/>
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-primary">Submit</button>
        </div>
    </form>
</body>
</html>