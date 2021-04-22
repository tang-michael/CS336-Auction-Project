package persistence.model.user;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Class to represent a customer representative.
 */
public class CustomerRepresentative extends User {
    private Date hireDate;

    public Date getHireDate() {
        return hireDate;
    }

    public void setHireDate(Date hireDate) {
        this.hireDate = hireDate;
    }

    public String getHireDateFormatted(){
        DateFormat dateTimeFormatter = new SimpleDateFormat("MMM dd, yyyy");
        return dateTimeFormatter.format(this.hireDate);
    }

}
