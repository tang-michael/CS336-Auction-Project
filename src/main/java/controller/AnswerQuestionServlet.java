package controller;

import persistence.model.Answer;
import persistence.model.Question;
import persistence.model.user.CustomerRepresentative;
import service.AnswersService;
import service.QuestionService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Date;
import java.util.Optional;

import static controller.AttributeKeys.AUTHENTICATED_USER;

/**
 * Servlet used by customer representative to answer a question.
 */
@WebServlet({"/cust_rep/answer_question"})
public class AnswerQuestionServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = -2341114510796725198L;
	private final AnswersService answersService = new AnswersService();
    private final QuestionService questionService = new QuestionService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        // get the customer representative answering the question.
        CustomerRepresentative customerRepresentative =
                (CustomerRepresentative) req.getSession().getAttribute(AUTHENTICATED_USER);

        // get the answer and question id from the request.
        String answer = req.getParameter("answer");
        String questionId = req.getParameter("questionId");

        // validate the supplied answer and the question id supplied.
        if(answer.isEmpty()){
            String url = req.getContextPath() + "/cust_rep/answer_question.jsp?error=The answer is invalid.";
            resp.sendRedirect(url);
            return;
        }

        int parsedQuestionId;
        try {
            parsedQuestionId = Integer.parseInt(questionId);
        } catch (Exception e){
            parsedQuestionId = -1;
        }

        Optional<Question> questionOptional = questionService.findQuestionById(parsedQuestionId);
        if(!questionOptional.isPresent()){
            String url = req.getContextPath() + "/cust_rep/answer_question.jsp?error=No such question";
            resp.sendRedirect(url);
            return;
        }

        // Create an answer object from the received data.
        Answer answerObj = new Answer();
        answerObj.setAnswer(answer);
        answerObj.setCustomerRepresentative(customerRepresentative);
        answerObj.setCreated(new Date());
        answerObj.setQuestion(questionOptional.get());
        answerObj.setAnswerId(0);

        // save the answer to the database
        answersService.addAnswer(answerObj);

        // redirect to the page for answering questions.
        String url = req.getContextPath() + "/cust_rep/answer_question.jsp?questionId=" + questionId + "&info=Your answer was submitted successfully";
        resp.sendRedirect(url);
    }
}
