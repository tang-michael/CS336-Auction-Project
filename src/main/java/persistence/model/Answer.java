package persistence.model;

import persistence.model.user.CustomerRepresentative;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Represents an answer to question.
 */
public class Answer {
    private int answerId;
    private String answer;
    private Question question;
    private CustomerRepresentative customerRepresentative;
    private Date created;

    public int getAnswerId() {
        return answerId;
    }

    public void setAnswerId(int answerId) {
        this.answerId = answerId;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    public CustomerRepresentative getCustomerRepresentative() {
        return customerRepresentative;
    }

    public void setCustomerRepresentative(CustomerRepresentative customerRepresentative) {
        this.customerRepresentative = customerRepresentative;
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
