<%@ page import="persistence.model.Question" %>
<%@ page import="service.QuestionService" %>
<%@ page import="java.util.Optional" %>
<%@ page import="controller.AttributeKeys" %>
<%
    String questionId = request.getParameter("questionId");
    if(questionId == null){
        response.sendRedirect("index.jsp");
        return;
    }

    int parsedQuestionId;
    try {
        parsedQuestionId = Integer.parseInt(questionId);
    } catch (Exception e){
        parsedQuestionId = -1;
    }

    QuestionService questionService = new QuestionService();
    Optional<Question> questionById = questionService.findQuestionById(parsedQuestionId);
    if(questionById.isEmpty()){
        response.sendRedirect("index.jsp");
        return;
    }

    Question question = questionById.get();

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Auction - Answers</title>
    <link href="../css/core.css" rel="stylesheet" />
</head>
<body>
    <div class="navbar">
        <h2 class="navbar-brand">Online Auction System | Samson</h2>
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

    <div class="container">
        <h3>Question</h3>
        <form method="post" action="${pageContext.request.contextPath}/cust_rep/answer_question">
            <div style="padding: 2rem;border: 1px solid lightgray; margin-top: 1rem;background-color: rgb(224, 241, 245);">
                <div style="font-size: .9rem;display: flex; justify-content: space-between;">
                    <div> <span class="text-bold">Asked By: </span> <%= question.getUser().getFullName() %></div>
                    <div><span class="text-bold">Asked On</span>: <%= question.getCreatedFormatted() %></div>
                </div>
                <div style="padding: 1rem 0 1rem 0;">
                    <p><%= question.getQuestion() %></p>
                </div>
            </div>

            <div>
                <div class="form-group">
                    <label>What is your answer?</label>
                    <textarea name="answer" class="form-control" rows="7"></textarea>
                    <input hidden name="questionId" value="<%=question.getQuestionId()%>" />
                </div>
                <div class="form-group">
                    <button class="btn btn-primary">Submit</button>
                </div>
            </div>
        </form>
    </div>
</body>
</html>