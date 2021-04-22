package persistence.model.bid;

import persistence.model.item.Item;
import persistence.model.user.User;

/**
 * Class to represent a bid.
 */
public class Bid {
    private int bidId;
    private User user;
    private int increment;
    private int offer;
    private Item item;

    public Bid(){}

    public Bid(Bid bid){
        bidId = bid.getBidId();
        user = bid.getUser();
        increment = bid.getIncrement();
        offer = bid.getOffer();
        item = bid.getItem();
    }

    public int getBidId() {
        return bidId;
    }

    public void setBidId(int bidId) {
        this.bidId = bidId;
    }

    public void setOffer(int offer) {
        this.offer = offer;
    }

    public int getOffer() {
        return offer;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public Item getItem() {
        return item;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getIncrement() {
        return increment;
    }

    public void setIncrement(int increment) {
        this.increment = increment;
    }

    public  BidStatus getBidStatus(){
        return BidStatus.UNKNOWN;
    }
}
