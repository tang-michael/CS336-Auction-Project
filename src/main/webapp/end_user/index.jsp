<%@ page import="persistence.model.Question" %>
<%@ page import="service.QuestionService" %>
<%@ page import="java.util.List" %>
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
            <a href="setAuction.jsp">View Auctions and Bid Items</a>
            <a class="active-link" href="index.jsp">Questions</a>
            <a href="ask_question.jsp">Post Question</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>

    <%
        QuestionService questionService = new QuestionService();
        String searchQuery = request.getParameter("searchQuery");
        List<Question> questionList = questionService.filterQuestionsByKeyWord(searchQuery);
    %>

    <div class="container">
        <div style="display: flex;justify-content: space-between;">
            <h2>Questions</h2>
            <% if (searchQuery != null) {%>
                <a href="index.jsp" class="btn btn-primary" style="text-decoration: none">Clear Search</a>
            <% } %>
        </div>

        <form>
            <div class="form-group">
                <label>Search questions by keyword</label>
                <div style="display: flex;justify-content: space-between;">
                    <input type="text" name="searchQuery" placeholder="Enter your keyword here" class="form-control" />
                    <button type="submit" class="btn btn-primary">Search</button>
                </div>
            </div>
        </form>
        <div style="margin-top: 2rem;">

            <% if(questionList.isEmpty()) {%>
                <div style="padding: 2rem;border: 1px solid lightgray; margin-top: 1rem;">
                    <div style="padding: 1rem 0 1rem 0;">
                        <p>No Questions Found</p>
                    </div>
                </div>
            <% } %>

            <% for(Question question : questionList){ %>
                <div style="padding: 2rem;border: 1px solid lightgray; margin-top: 1rem;">
                    <div style="font-size: .9rem;display: flex; justify-content: space-between;">
                        <div> <span class="text-bold">Asked By: </span> <%= question.getUser().getFullName() %></div>
                        <div><span class="text-bold">Asked On</span>: <%= question.getCreatedFormatted() %></div>
                    </div>
                    <div style="padding: 1rem 0 1rem 0;">
                        <p><%= question.getQuestion() %></p>
                    </div>
                    <div>
                        <div style="font-size: .9rem;">
                            <a href="answers.jsp?questionId=<%=question.getQuestionId()%>">
                                <span class="text-bold">Answers</span>
                            </a>
                        </div>
                    </div>
                </div>
            <% } %>

        </div>
    </div>
</body>
</html>