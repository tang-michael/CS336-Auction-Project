package persistence.repository;

import persistence.model.Question;
import persistence.model.user.EndUser;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Class that manipulates the "question" table in the database.
 */
public class QuestionRepository extends Repository {
    private final UserRepository userRepository;

    public QuestionRepository() {
        try {
            this.userRepository = new UserRepository();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // Set a question to have been asked by an "anonymous" user. Useful
    // when a user is deleted and the question was associated with that user.
    public void anonymizeQuestion(int questionId) throws SQLException {
        String query = "UPDATE `question` SET `login_id`='anonymous' WHERE `question_id` = ?";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        statement.setInt(1, questionId);
        statement.execute();
        statement.close();
    }

    // Add a new question to the database.
    public void addQuestion(EndUser endUser, String question) throws SQLException {
        String query = "INSERT INTO `question` (`question_id`, `question`, `login_id`, `created`) " +
                "VALUES (?, ?, ?, ?)";

        PreparedStatement preparedStatement = dbConnection.prepareStatement(query);
        preparedStatement.setInt(1, 0);
        preparedStatement.setString(2, question);
        preparedStatement.setString(3, endUser.getLoginId());
        preparedStatement.setDate(4, new Date(new java.util.Date().getTime()));

        preparedStatement.execute();
    }

    // Find all the questions from the database.
    public List<Question> findAllQuestions() throws SQLException {
        String query = "SELECT * FROM `question`";
        PreparedStatement preparedStatement = dbConnection.prepareStatement(query);
        ResultSet resultSet = preparedStatement.executeQuery();
        List<Question> questionList = new ArrayList<>();
        while (resultSet.next()){
            Question question = extractQuestionFromResultSet(resultSet);
            questionList.add(question);
        }

        return questionList;
    }

    // Extract a question from a query resultset.
    private Question extractQuestionFromResultSet(ResultSet resultSet) throws SQLException {
        String question = resultSet.getString("question");
        int questionId = resultSet.getInt("question_id");
        Date date = resultSet.getDate("created");
        String endUseLogin = resultSet.getString("login_id");
        EndUser endUser = (EndUser) userRepository.findUserByLoginId(endUseLogin).get();

        Question questionObj = new Question();
        questionObj.setCreated(date);
        questionObj.setQuestion(question);
        questionObj.setUser(endUser);
        questionObj.setQuestionId(questionId);

        return questionObj;
    }
}
