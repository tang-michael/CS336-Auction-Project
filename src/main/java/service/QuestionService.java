package service;

import persistence.model.Question;
import persistence.model.user.EndUser;
import persistence.repository.QuestionRepository;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Class with logic for question objects.
 */
public class QuestionService {
    private final QuestionRepository questionRepository;

    public QuestionService() {
        this.questionRepository = new QuestionRepository();
    }

    // Add a question to the system storage.
    public void addQuestion(EndUser endUser, String question){
        try {
            this.questionRepository.addQuestion(endUser, question);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    //  Filter questions by keyword
    public List<Question> filterQuestionsByKeyWord(String keyWord){
        if(keyWord == null){
            keyWord = "";
        }

        List<Question> questions = findAllQuestions();
        String finalKeyWord = keyWord;
        return questions.stream().filter(
                question -> {
                    return question.getQuestion().toLowerCase().contains(finalKeyWord.toLowerCase());
                }
        ).collect(Collectors.toList());
    }


    // Anonymize all the questions asked by the given user.
    // Happens when the user is about to be deleted.
    public void anonymizeQuestionsByEndUser(EndUser endUser){
        List<Question> allQuestions = findAllQuestions();
        List<Question> questionsByEndUser = allQuestions
                .stream()
                .filter(it -> it.getUser().getLoginId().equals(endUser.getLoginId()))
                .collect(Collectors.toList());

        questionsByEndUser.forEach(question -> {
            try {
                questionRepository.anonymizeQuestion(question.getQuestionId());
            } catch (SQLException e) {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        });
    }

    // Find a question given its id
    public Optional<Question> findQuestionById(int questionId){
        List<Question> allQuestions = findAllQuestions();
        return allQuestions.stream()
                .filter(it -> it.getQuestionId() == questionId)
                .findFirst();
    }

    // Find all the questions from the system storage.
    public List<Question> findAllQuestions(){
        try {
            return this.questionRepository.findAllQuestions();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}
