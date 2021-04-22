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
    private String characteristics;

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
        characteristics = item.getCharacteristics();
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

    public String getCharacteristics() {
        return characteristics;
    }

    public void setCharacteristics(String characteristics) {
        this.characteristics = characteristics;
    }

    public void setCurrentBid(double currentBid) {
        this.currentBid = currentBid;
    }

    public String getCategory(){
        return "General Item";
    }
}
