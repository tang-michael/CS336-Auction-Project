package service;

import persistence.model.bid.Bid;
import persistence.model.user.EndUser;
import persistence.model.user.User;
import persistence.repository.BidRepository;
import persistence.repository.ItemRepository;

import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Service class with logic tied to Bids.
 */
public class BidService {
    private final BidRepository bidRepository;

    public BidService() {
        bidRepository = new BidRepository();
    }

    // Find all the bids from the system storage.
    public List<Bid> findAllBids(){
        try {
            return bidRepository.findAllBids();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    // Delete a bid from the system storage.
    public void deleteBid(int bidId){
        try {
            bidRepository.deleteBid(bidId);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    // Delete all the bids that belong to a given user.
    public void deleteBidsForUser(User user){
        List<Bid> allBids = findAllBids();
        List<Bid> userbids = allBids
                .stream()
                .filter(it -> it.getUser().getLoginId().equals(user.getLoginId()))
                .collect(Collectors.toList());

        for (Bid userbid : userbids) {
            deleteBid(userbid.getBidId());
        }
    }
   
    // Delete any bids for items the seller might have posted.
    public void deleteBidsForSellerItems(EndUser seller) {
    	try {
			bidRepository.deleteBidsForSellerItems(seller);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
    	
    }
}
