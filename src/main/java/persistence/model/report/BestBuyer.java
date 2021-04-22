package persistence.model.report;

/**
 * Class to represent the best buyer information.
 */
public class BestBuyer {
    private String fullName;
    private int totalEarnings;

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public int getTotalEarnings() {
        return totalEarnings;
    }

    public void setTotalEarnings(int totalEarnings) {
        this.totalEarnings = totalEarnings;
    }
}
