package service;

import persistence.model.Answer;
import persistence.model.Question;
import persistence.model.user.CustomerRepresentative;
import persistence.repository.AnswerRepository;

import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;

/**
 * The class handles any logic related to Answer objects.
 */
public class AnswersService {
    private final AnswerRepository answerRepository;

    public AnswersService() {
        answerRepository = new AnswerRepository();
    }

    // Add an answer to the system storage.
    public void addAnswer(Answer answer){
        try {
            answerRepository.addAnswer(answer);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }


    // Get all the answers from the system storage.
    public List<Answer> getAnswers(Question question){
        try {
            List<Answer> answers = answerRepository.findAllAnswers();
            return answers.stream()
                    .filter(answer ->
                            answer.getQuestion().getQuestionId() == question.getQuestionId())
                    .collect(Collectors.toList());
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

}
