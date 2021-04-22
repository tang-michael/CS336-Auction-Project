<%@ page import="persistence.model.Question" %>
<%@ page import="java.util.Optional" %>
<%@ page import="service.QuestionService" %>
<%@ page import="service.AnswersService" %>
<%@ page import="persistence.model.Answer" %>
<%@ page import="java.util.List" %>
<%@ page import="controller.AttributeKeys" %>
<%@ page import="persistence.model.user.User" %>
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
    AnswersService answersService = new AnswersService();
    List<Answer> answers = answersService.getAnswers(question);
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
        <%
            User user = (User) request.getSession().getAttribute(AttributeKeys.AUTHENTICATED_USER);
        %>
        <h2 class="navbar-brand">Online Auction System | <%=  user.getFullName() %></h2>

        <div class="nav-links right-nav-links">
            <a href="index.jsp">Questions</a>
            <a href="ask_question.jsp">Post Question</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>

    <div class="container" style="margin-bottom: 1rem;">
        <h3>Question</h3>
        <div>
            <div style="padding: 2rem;border: 1px solid lightgray; margin-top: 1rem;background-color: rgb(224, 241, 245);">
                <div style="font-size: .9rem;display: flex; justify-content: space-between;">
                    <div> <span class="text-bold">Asked By: </span> <%= question.getUser().getFullName() %></div>
                    <div><span class="text-bold">Asked On</span>: <%= question.getCreatedFormatted() %></div>
                </div>
                <div style="padding: 1rem 0 1rem 0;">
                    <p><%= question.getQuestion() %></p>
                </div>
            </div>

            <h3 style="margin-top: 1rem">Answers</h3>

            <% if(answers.isEmpty()) { %>
                <div style="padding: 2rem;border: 1px solid lightgray; margin-top: 1rem;">
                    <div style="padding: 1rem 0 1rem 0;">
                        <p>No Answers found at the moment for this question.</p>
                    </div>
                </div>
            <% } %>

            <% for(Answer answer : answers) {%>
                <div style="padding: 2rem;border: 1px solid lightgray; margin-top: 1rem;">
                    <div style="font-size: .9rem;display: flex; justify-content: space-between;">
                        <div> <span class="text-bold">Answered By: </span> <%= answer.getCustomerRepresentative().getFullName()%></div>
                        <div><span class="text-bold">Answered On</span>: <%= answer.getCreatedFormatted() %></div>
                    </div>
                    <div style="padding: 1rem 0 1rem 0;">
                        <p><%= answer.getAnswer() %></p>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>