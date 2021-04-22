<%@ page import="controller.AttributeKeys" %>
<%@ page import="persistence.model.user.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Auction - Questions</title>
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
            <a class="active-link" href="ask_question.jsp">Post Question</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>

    <div class="container">
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

        <h2>Ask Question</h2>
        <form method="post" action="${pageContext.request.contextPath}/end_user/post_question">
            <div class="form-group">
                <label>What is your question?</label>
                <textarea name="questionText" rows="7"></textarea>
            </div>
            <div class="form-group">
                <button class="btn btn-primary">Submit</button>
            </div>
        </form>
    </div>
</body>
</html>