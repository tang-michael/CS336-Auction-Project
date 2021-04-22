<%@ page import="controller.AttributeKeys" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Auction - Cust Reps</title>
    <link href="../css/core.css" rel="stylesheet" />
</head>
<body>
    <div class="navbar">
        <h2 class="navbar-brand">Online Auction System | Admin</h2>
        <div class="nav-links right-nav-links">
            <a href="index.jsp">Reports</a>
            <a href="reps.jsp">View Representatives</a>
            <a class="active-link" href="create_rep.jsp">Add Representative</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>

    <%
        String error = request.getParameter(AttributeKeys.ERROR_REQUEST_PARAM);
        String info = request.getParameter(AttributeKeys.INFO_REQUEST_PARAM);
        if(error != null){
    %>
    <div class="alert alert-danger"><%= error %></div>
    <% }

        if(info != null){
    %>

    <div class="alert alert-info">
        <%= info %>
    </div>

    <%
        }
    %>

    <form style="margin-bottom: 1rem;" method="post" action="${pageContext.request.contextPath}/admin/add_rep" class="container">
        <h2>Add Customer Representative</h2>
        
        <div class="form-group">
            <label>Enter user id</label>
            <input name="userId" type="text" class="form-control" />
        </div>
        <div class="form-group">
            <label>Enter first name</label>
            <input name="firstName" type="text" class="form-control" />
        </div>
        <div class="form-group">
            <label>Enter last name</label>
            <input name="lastName" type="text" class="form-control" />
        </div>
        <div class="form-group">
            <label>Enter hire date</label>
            <input name="hireDate" type="date" class="form-control" />
        </div>
        <div class="form-group">
            <label>Enter password </label>
            <input name="password" type="password" class="form-control" />
        </div>
        <div class="form-group">
            <label>Confirm password </label>
            <input name="confirmPassword" type="password" class="form-control" />
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-primary">Submit</button>
        </div>
    </form>
</body>
</html>