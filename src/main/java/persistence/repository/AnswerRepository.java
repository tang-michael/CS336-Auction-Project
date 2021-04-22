package persistence.repository;

import persistence.model.Answer;
import persistence.model.Question;
import persistence.model.user.CustomerRepresentative;
import service.QuestionService;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * The class deals with manipulating data on the "answer" table.
 */
public class AnswerRepository extends Repository{
    private final QuestionService questionService;
    private final UserRepository userRepository;

    public AnswerRepository() {
        try {
            questionService = new QuestionService();
            userRepository = new UserRepository();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    // Add an answer to the database.
    public void addAnswer(Answer answer) throws SQLException {
        String query = "INSERT INTO `answer`(`answer_id`, `answer`, `question_id`, `login_id`, `created`)" +
                " VALUES (?, ?, ?, ?, ?)";

        PreparedStatement preparedStatement = dbConnection.prepareStatement(query);
        preparedStatement.setInt(1, 0);
        preparedStatement.setString(2, answer.getAnswer());
        preparedStatement.setInt(3, answer.getQuestion().getQuestionId());
        preparedStatement.setString(4, answer.getCustomerRepresentative().getLoginId());
        preparedStatement.setDate(5, new java.sql.Date(answer.getCreated().getTime()));

        preparedStatement.execute();
        preparedStatement.close();
    }

    // Find all the answers from the database.
    public List<Answer> findAllAnswers() throws SQLException {
        String query = "SELECT * FROM `answer`";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        ResultSet resultSet = statement.executeQuery();

        List<Answer> answers = new ArrayList<>();
        while (resultSet.next()){
            Answer answer = extractAnswerFromResultSet(resultSet);
            answers.add(answer);
        }

        resultSet.close();
        statement.close();

        return answers;
    }


    // Extracts an answer from a resultset and converts it into an answer object.
    private Answer extractAnswerFromResultSet(ResultSet resultSet) throws SQLException {
        int answerId = resultSet.getInt("answer_id");
        String answer = resultSet.getString("answer");

        int questionId = resultSet.getInt("question_id");
        Question question = questionService.findQuestionById(questionId).get();

        String loginId = resultSet.getString("login_id");
        CustomerRepresentative customerRepresentative = (CustomerRepresentative)
                userRepository.findUserByLoginId(loginId).get();

        Date created = resultSet.getDate("created");

        Answer answerObj = new Answer();
        answerObj.setAnswerId(answerId);
        answerObj.setAnswer(answer);
        answerObj.setQuestion(question);
        answerObj.setCustomerRepresentative(customerRepresentative);
        answerObj.setCreated(created);

        return answerObj;
    }
}
