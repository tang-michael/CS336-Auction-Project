package persistence.repository;

import persistence.model.bid.Bid;
import persistence.model.bid.IllegalBid;
import persistence.model.bid.LegalBid;
import persistence.model.item.Item;
import persistence.model.user.EndUser;
import persistence.model.user.User;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Class manipulate the "bid", "bids", "has_item", "legal_bid", and "illegal_bid"
 * tables in the database.
 */
public class BidRepository extends Repository {
    private final UserRepository userRepository;
    private final ItemRepository itemRepository;

    public BidRepository() {
        userRepository = new UserRepository();
        itemRepository = new ItemRepository();
    }

    // Delete the bid information from the given table.
    private void deleteBidFromTable(int bidId, String tableName) throws SQLException {
        String query = "DELETE FROM `" + tableName + "` WHERE `bid_id` = ?";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        statement.setInt(1, bidId);
        statement.execute();
        statement.close();
    }

    // Delete bid information from all the tables that hold information about that bid.
    public void deleteBid(int bidId) throws SQLException {
        List<String> tables = Arrays.asList("legal_bid", "illegal_bid", "has_item", "bids", "bid");
        for (String table : tables) {
            deleteBidFromTable(bidId, table);
        }
    }


    // Find all bids from the database.
    public List<Bid> findAllBids() throws SQLException {
        String query = "SELECT * FROM `bids`";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        ResultSet resultSet = statement.executeQuery();
        List<Bid> bidList = new ArrayList<>();

        while (resultSet.next()){
            String loginId = resultSet.getString("login_id");
            User user = userRepository.findUserByLoginId(loginId).get();

            int bidId = resultSet.getInt("bid_id");
            int bidOffer = resultSet.getInt("bid_offer");
            int increment = resultSet.getInt("increment");

            Bid bid = new Bid();
            bid.setBidId(bidId);
            bid.setUser(user);
            bid.setOffer(bidOffer);
            bid.setIncrement(increment);

            Item bidItem = getBidItem(bid);
            bid.setItem(bidItem);

            Bid specializedBid = specializeBid(bid);
            bidList.add(specializedBid);
        }

        resultSet.close();
        statement.close();

        return bidList;
    }

    // Get the item that belongs to the bid.
    private Item getBidItem(Bid bid) throws SQLException {
        String query = "SELECT * FROM has_item WHERE bid_id = ?";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        statement.setInt(1, bid.getBidId());
        ResultSet resultSet = statement.executeQuery();
        final int itemId;
        if(resultSet.next()){
            itemId = resultSet.getInt("item_id");
        } else {
            itemId = -1;
        }

        resultSet.close();
        statement.close();

        return itemRepository.findItems()
                .stream()
                .filter(it -> it.getItemId() == itemId)
                .findFirst()
                .get();
    }

    // Given a generic bid, convert it to either a Legal or Illegal Bid
    private Bid specializeBid(Bid bid) throws SQLException {
        Optional<Bid> legalBidOptional = specializeAsLegalBid(bid);
        if(legalBidOptional.isPresent()){
            return legalBidOptional.get();
        }

        Optional<Bid> illegalBidOptional = specializeAsIllegalBid(bid);
        return illegalBidOptional.orElse(bid);
    }

    // Check if a bid is illegal in the database. If it is convert the bid to an IllegalBid object.
    private Optional<Bid> specializeAsIllegalBid(Bid bid) throws SQLException {
        String query = "SELECT * FROM `illegal_bid` WHERE bid_id = ?";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        statement.setInt(1, bid.getBidId());
        ResultSet resultSet = statement.executeQuery();

        Optional<Bid> bidOptional = Optional.empty();
        if(resultSet.next()){
            IllegalBid illegalBid = new IllegalBid(bid);
            bidOptional = Optional.of(illegalBid);
        }

        resultSet.close();
        statement.close();

        return bidOptional;
    }

    // Check if a bid is Legal in the database. If it is, convert it into
    // a LegalBid object.
    private Optional<Bid> specializeAsLegalBid(Bid bid) throws SQLException {
        String query = "SELECT * FROM `legal_bid` WHERE bid_id = ?";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        statement.setInt(1, bid.getBidId());
        ResultSet resultSet = statement.executeQuery();

        Optional<Bid> bidOptional = Optional.empty();
        if(resultSet.next()){
            LegalBid legalBid = new LegalBid(bid);
            bidOptional = Optional.of(legalBid);
        }

        resultSet.close();
        statement.close();

        return bidOptional;
    }
    
    // Delete all the bids (if any) for the items the seller has 
    // posted.
    public void deleteBidsForSellerItems(EndUser endUser) throws SQLException {
    	List<Item> allItems = itemRepository.findItems();
    	
    	List<Item> sellerItems = allItems.stream()
    			.filter(item -> item.getUser().getLoginId()
    					.equals(endUser.getLoginId()))
    			.collect(Collectors.toList());
    	
    	List<Bid> allBids = findAllBids();
    	
    	for(Item sellerItem : sellerItems) {
    		deleteBidsForItem(sellerItem, allBids);
    	}
    	
    }
    
    // Delete bids for the single item the seller has posted.
    private void deleteBidsForItem(Item item, List<Bid> allBids) throws SQLException {
    	List<Bid> targetBids = allBids.stream()
    			.filter(bid -> bid.getItem().getItemId() == item.getItemId())
    			.collect(Collectors.toList());
    
    	for(Bid targetBid : targetBids) {
    		this.deleteBid(targetBid.getBidId());
    	}
    }
    
    
}
