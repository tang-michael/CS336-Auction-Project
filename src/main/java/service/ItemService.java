package service;

import persistence.model.item.Item;
import persistence.model.user.User;
import persistence.repository.ItemRepository;

import java.sql.SQLException;
import java.util.List;
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
