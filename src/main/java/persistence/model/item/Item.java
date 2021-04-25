package persistence.model.item;

import persistence.model.user.User;

import java.sql.Date;
import java.sql.Time;

/**
 * Class to represent an item.
 */
public class Item {
    private int itemId;
    private User user;
    private String itemType;
    private String brand;
    private Date closingDate;
    private Time closingTime;
    private double currentBid;
    private double initialPrice;
    private double minPrice;
    private double upper_limit;
    private double user_increment;
    private double item_increment;
    private String current_winner;

    public Item(){}

    public Item(Item item){
        itemId = item.getItemId();
        user = item.getUser();
        itemType = item.getItemType();
        brand = item.getBrand();
        closingDate = item.getClosingDate();
        closingTime = item.getClosingTime();
        currentBid = item.getCurrentBid();
        initialPrice = item.getInitialPrice();
        minPrice = item.getMinPrice();
        upper_limit = item.getUpper_limit();
        user_increment = item.getUser_increment();
        item_increment = item.getItem_increment();
        current_winner = item.getCurrent_winner();
    }

    public String getCurrent_winner() {
		return current_winner;
	}

	public void setCurrent_winner(String current_winner) {
		this.current_winner = current_winner;
	}

	public double getUpper_limit() {
		return upper_limit;
	}

	public void setUpper_limit(double upper_limit) {
		this.upper_limit = upper_limit;
	}

	public double getUser_increment() {
		return user_increment;
	}

	public void setUser_increment(double user_increment) {
		this.user_increment = user_increment;
	}

	public double getItem_increment() {
		return item_increment;
	}

	public void setItem_increment(double item_increment) {
		this.item_increment = item_increment;
	}

	public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public double getInitialPrice() {
        return initialPrice;
    }

    public void setInitialPrice(double initialPrice) {
        this.initialPrice = initialPrice;
    }

    public double getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(double minPrice) {
        this.minPrice = minPrice;
    }

    public double getCurrentBid() {
        return currentBid;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getItemType() {
        return itemType;
    }

    public void setItemType(String itemType) {
        this.itemType = itemType;
    }

    public Date getClosingDate() {
        return closingDate;
    }

    public void setClosingDate(Date closingDate) {
        this.closingDate = closingDate;
    }

    public Time getClosingTime() {
        return closingTime;
    }

    public void setClosingTime(Time closingTime) {
        this.closingTime = closingTime;
    }



    public void setCurrentBid(double currentBid) {
        this.currentBid = currentBid;
    }

    public String getCategory(){
        return "General Item";
    }
}
