package persistence.model;

import persistence.model.user.EndUser;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Represents a question asked by an end user.
 */
public class Question {
    private int questionId;
    private String question;
    private EndUser user;
    private Date created;

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public EndUser getUser() {
        return user;
    }

    public void setUser(EndUser user) {
        this.user = user;
    }

    public Date getCreated() {
        return created;
    }

    public String getCreatedFormatted(){
        DateFormat dateTimeFormatter = new SimpleDateFormat("MMM dd, yyyy");
        return dateTimeFormatter.format(this.created);

    }

    public void setCreated(Date created) {
        this.created = created;
    }
}
