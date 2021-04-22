package persistence.model.user;

/**
 * Represents a user on the system.
 */
public class User {
    private String fname;
    private String lname;
    private String loginId;
    private String pwd;

    /* ---------- Getters and Setters ------------------- */
    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getLoginId() {
        return loginId;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getFullName(){
        return this.fname + " " + this.lname;
    }
}
