package persistence.model.report;

import persistence.model.item.Item;

/**
 * Class to represent the best-selling item info.
 */
public class BestSellingItem {
    private String category;
    private int count;

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}
