package service;

import persistence.model.item.Item;
import persistence.model.user.User;
import persistence.repository.ItemRepository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Class with logic for "Item" objects.
 */
public class ItemService {
    private final ItemRepository itemRepository;

    public ItemService() {
        itemRepository = new ItemRepository();
    }


    // Find all the items from the system storage.
    public List<Item> findItems(){
        try {
            return itemRepository.findItems();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
    
    public void updateWinner(String item_id, String winner) throws SQLException {
    	itemRepository.setWinner(item_id, winner);
    }
    
    public void updateItemBid(String item_id, String bid, String upper_limit, String bid_increment, String item_increment) throws SQLException {
    	itemRepository.updateItemBid(item_id, bid, upper_limit, bid_increment, item_increment);
    }
    
    public Item getExactItem(String item_id) throws SQLException {
          return itemRepository.getItemByID(item_id);
    }

    // Delete items for the given user.
    public void deleteItemsForUser(User user){
        List<Item> allItems = findItems();
        List<Item> userItems = allItems
                .stream()
                .filter(item -> item.getUser().getLoginId().equals(user.getLoginId()))
                .collect(Collectors.toList());

        for (Item userItem : userItems) {
            try {
                itemRepository.deleteItem(userItem.getItemId());
            } catch (SQLException e) {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }
    }
}
