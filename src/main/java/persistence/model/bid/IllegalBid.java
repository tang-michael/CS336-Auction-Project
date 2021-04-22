package persistence.model.bid;

/**
 * Class to represent an illegal bid.
 */
public class IllegalBid extends Bid {
    public IllegalBid(Bid bid){
        super(bid);
    }

    @Override
    public BidStatus getBidStatus() {
        return BidStatus.ILLEGAL;
    }
}
