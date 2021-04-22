package persistence.repository;

import persistence.model.Auction;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * The class deals with operations on the "auctions" table.
 */
public class AuctionsRepository extends Repository{

    // Find all the auctions from the "auctions" table.
    public List<Auction> findAllAuctions() throws SQLException {
        String query = "SELECT * FROM `auctions`";
        PreparedStatement preparedStatement = dbConnection.prepareStatement(query);
        ResultSet resultSet = preparedStatement.executeQuery();
        List<Auction> auctions = new ArrayList<>();
        while (resultSet.next()){
            Auction auction = extractAuction(resultSet);
            auctions.add(auction);
        }

        resultSet.close();
        preparedStatement.close();
        return auctions;
    }

    // Delete the given auction from the database.
    public void deleteAuction(int auctionId) throws SQLException {
        String deleteQuery = "DELETE FROM `auctions` WHERE `auction_id` = ?";
        PreparedStatement preparedStatement = dbConnection.prepareStatement(deleteQuery);
        preparedStatement.setInt(1, auctionId);
        preparedStatement.execute();
        preparedStatement.close();
    }

    // Extracts an auction object from the resultset.
    private Auction extractAuction(ResultSet resultSet) throws SQLException {
        int auctionId = resultSet.getInt("auction_id");
        String historyOfBids = resultSet.getString("history_of_bids");
        Auction auction = new Auction();
        auction.setAuctionId(auctionId);
        auction.setHistoryOfBids(historyOfBids);
        return auction;
    }
}
