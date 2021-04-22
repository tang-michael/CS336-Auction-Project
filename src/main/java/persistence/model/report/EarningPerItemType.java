package persistence.model.report;

/**
 * Class to represent the earning per item type.
 */
public class EarningPerItemType {
    private String itemType;
    private int earning;

    public String getItemType() {
        return itemType;
    }

    public void setItemType(String itemType) {
        this.itemType = itemType;
    }

    public int getEarning() {
        return earning;
    }

    public void setEarning(int earning) {
        this.earning = earning;
    }
}
