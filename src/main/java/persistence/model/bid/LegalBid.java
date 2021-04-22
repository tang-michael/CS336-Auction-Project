package persistence.model.bid;

/**
 * Class to represent a legal bid.
 */
public class LegalBid extends Bid {
    public LegalBid(Bid bid){
        super(bid);
    }

    @Override
    public BidStatus getBidStatus() {
        return BidStatus.LEGAL;
    }
}
