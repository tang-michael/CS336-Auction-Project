package persistence.model;

import persistence.model.item.Item;
import persistence.model.user.User;

import java.sql.Date;

/**
 * Represents the sale of an item.
 */
public class Sales {
    private Item item;
    private User user;
    private Date closeDateTime;

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getCloseDateTime() {
        return closeDateTime;
    }

    public void setCloseDateTime(Date closeDateTime) {
        this.closeDateTime = closeDateTime;
    }
}
