<%@ page import="controller.AttributeKeys" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Auction - Register</title>
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

    <form method="post" action="register" class="login-form">
        <h2 class="form-header text-center form-header">Register</h2>
        <div class="form-group">
            <label>Enter your user id</label>
            <input name="userId" type="text" class="form-control" />
        </div>
        <div class="form-group">
            <label>Enter your first name</label>
            <input  name="firstName" type="text" class="form-control" />
        </div>
        <div class="form-group">
            <label>Enter your last name name</label>
            <input  name="lastName" type="text" class="form-control" />
        </div>
        <div class="form-group">
            <label>Enter your email</label>
            <input  name="email" type="text" class="form-control" />
        </div>
        <div class="form-group">
            <label>Enter your initial role.</label>
            <select name="initialRole">
                <option value="BUYER">BUYER</option>
                <option value="SELLER">SELLER</option>
            </select>
        </div>
        <div class="form-group">
            <label>Enter your password</label>
            <input name="password" type="password" class="form-control" />
        </div>
        <div class="form-group">
            <label>Confirm your password</label>
            <input name="confirmPassword" type="password" class="form-control" />
        </div>
        <div class="form-group">
            <button class="btn btn-primary">Submit</button>
        </div>
    </form>
</body>
</html>