package persistence.model.user;

/**
 * Class to represent an end user.
 */
public class EndUser extends User {
    private String email;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        if(email.length() > 20){
            email = email.substring(0, 20);
        }
        this.email = email;
    }
}
