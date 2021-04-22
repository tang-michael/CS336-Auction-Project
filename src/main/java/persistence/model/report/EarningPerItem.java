package persistence.model.report;

/**
 * Class to represent the earning per item.
 */
public class EarningPerItem {
    private String itemName;
    private String itemCategory;
    private String itemBrand;
    private int earning;

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getItemCategory() {
        return itemCategory;
    }

    public void setItemCategory(String itemCategory) {
        this.itemCategory = itemCategory;
    }

    public String getItemBrand() {
        return itemBrand;
    }

    public void setItemBrand(String itemBrand) {
        this.itemBrand = itemBrand;
    }

    public void setEarning(int earning) {
        this.earning = earning;
    }

    public int getEarning() {
        return earning;
    }
}
