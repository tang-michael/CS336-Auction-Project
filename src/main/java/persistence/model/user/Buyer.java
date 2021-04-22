package persistence.model.user;

/**
 * Class to represent a buyer.
 */
public class Buyer extends EndUser {
    private String alerts;

    public String getAlerts() {
        return alerts;
    }

    public void setAlerts(String alerts) {
        this.alerts = alerts;
    }
}
