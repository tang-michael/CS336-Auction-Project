package persistence.model.user;

import java.util.Date;

/**
 * Class to represent the administrator.
 */
public class Admin extends User {
    private Date hireDate;

    public Date getHireDate() {
        return hireDate;
    }

    public void setHireDate(Date hireDate) {
        this.hireDate = hireDate;
    }
}
