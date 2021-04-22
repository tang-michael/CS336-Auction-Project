package persistence.model.report;

/**
 * Class to represent the earning for a specific buyer.
 */
public class EarningPerBuyer {
    private String fullName;
    private int earning;

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public int getEarning() {
        return earning;
    }

    public void setEarning(int earning) {
        this.earning = earning;
    }
}
