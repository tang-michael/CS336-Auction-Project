package controller;

import persistence.model.user.EndUser;
import service.QuestionService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet that allows a user to post (ask) a question
 */
@WebServlet({"/end_user/post_question"})
public class PostQuestionServlet extends HttpServlet {
    private final QuestionService questionService = new QuestionService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // Get the question text
        String question = req.getParameter("questionText");

        // ensure the question is valid.
        if(question.isEmpty()){
            String url = req.getContextPath() + "/end_user/ask_question.jsp?error=The question is required.";
            resp.sendRedirect(url);
            return;
        }

        // Get the current end user from session.
        EndUser currentEndUser = (EndUser) req.getSession()
                .getAttribute(AttributeKeys.AUTHENTICATED_USER);

        // add the question to the database.
        questionService.addQuestion(currentEndUser, question);

        // redirect to the ask question page with a success message.
        String url = req.getContextPath() + "/end_user/ask_question.jsp?info=Question was asked successfully!";
        resp.sendRedirect(url);
    }
}
