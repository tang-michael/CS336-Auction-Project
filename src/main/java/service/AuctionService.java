package service;

import persistence.model.Auction;
import persistence.repository.AuctionsRepository;

import java.sql.SQLException;
import java.util.List;

/**
 * The class handles any logic related to Auction objects.
 */
public class AuctionService {
    private final AuctionsRepository auctionsRepository;

    public AuctionService() {
        this.auctionsRepository = new AuctionsRepository();
    }

    // Delete an auction from the system storage.
    public void deleteAuction(int auctionId){
        try {
            auctionsRepository.deleteAuction(auctionId);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    // Find all the auctions from the system storage.
    public List<Auction> findAllAuctions(){
        try {
            return auctionsRepository.findAllAuctions();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}
