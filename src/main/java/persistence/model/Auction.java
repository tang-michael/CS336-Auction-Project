package persistence.model;

/**
 * Represents an auction.
 */
public class Auction {
    private int auctionId;
    private String historyOfBids;

    public int getAuctionId() {
        return auctionId;
    }

    public void setAuctionId(int auctionId) {
        this.auctionId = auctionId;
    }

    public String getHistoryOfBids() {
        return historyOfBids;
    }

    public void setHistoryOfBids(String historyOfBids) {
        this.historyOfBids = historyOfBids;
    }
}
