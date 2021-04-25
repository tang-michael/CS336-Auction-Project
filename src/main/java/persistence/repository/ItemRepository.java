package persistence.repository;

import persistence.model.item.*;
import persistence.model.user.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

/**
 * Class that manipulates the "cameras", "phones", "computers",
 * "computer_accessories", "item" tables.
 */
public class ItemRepository extends Repository {
	private final UserRepository userRepository;

	public ItemRepository() {
		this.userRepository = new UserRepository();
	}

	// delete item data from the given table.
	private void deleteItemFromTable(int itemId, String tableName) throws SQLException {
		String query = "DELETE FROM `" + tableName + "` WHERE `item_id` = ?";
		PreparedStatement statement = dbConnection.prepareStatement(query);
		statement.setInt(1, itemId);
		statement.execute();
		statement.close();
	}

	// deletes an item and all the associated data in various tables.
	public void deleteItem(int itemId) throws SQLException {
		List<String> tables = Arrays.asList("cameras", "phones", "computers", "computer_accessories", "has_item",
				"item");
		for (String table : tables) {
			deleteItemFromTable(itemId, table);
		}
	}

	// Find all the items from the database.
	public List<Item> findItems() throws SQLException {
		String query = "SELECT * FROM `item`";
		PreparedStatement statement = dbConnection.prepareStatement(query);
		ResultSet resultSet = statement.executeQuery();
		List<Item> items = new ArrayList<>();
		while (resultSet.next()) {
			Item item = extractItem(resultSet);
			Item specializedItem = specializeItem(item);
			items.add(specializedItem);
		}

		resultSet.close();
		statement.close();
		System.out.println(items.size());
		return items;
	}

	public void updateItemBid(String item_id, String bid, String upper_limit, String bid_increment,
			String item_increment) throws SQLException {
		String query = "UPDATE item SET bid_increment=" + item_increment + ", user_increment=" + bid_increment
				+ ", current_bid=" + bid + ", upper_limit=" + upper_limit + " WHERE `item_id` = " + item_id;
		System.out.println(query);
		PreparedStatement statement = dbConnection.prepareStatement(query);
		statement.executeUpdate();
		statement.close();
	}
	
//	public void setWinner(String item_id, String winner) throws SQLException {
//		String query = "UPDATE item SET current_winner='"+winner + "' WHERE `item_id`=" + item_id;
//		PreparedStatement statement = dbConnection.prepareStatement(query);
//		statement.executeUpdate();
//		statement.close();
//	}

	public Item getItemByID(String id) throws SQLException {
		String query = "SELECT * From `item` WHERE `item_id` = " + id;
		PreparedStatement statement = dbConnection.prepareStatement(query);
		ResultSet resultSet = statement.executeQuery();
		resultSet.next();

		String itemType = resultSet.getString("item_type");
		String brand = resultSet.getString("brand");
		Date closingDate = resultSet.getDate("closing_date");
		Time closingTime = resultSet.getTime("closing_time");
		double currentBid = resultSet.getDouble("current_bid");
		double initialPrice = resultSet.getDouble("initial_price");
		double minPrice = resultSet.getDouble("min_price");
		double item_increment = resultSet.getDouble("bid_increment");
		double upper_limit = resultSet.getDouble("upper_limit");
		double user_increment = resultSet.getDouble("user_increment");

		Item item = new Item();
		item.setItemId(Integer.valueOf(id));
		item.setItemType(itemType);
		item.setBrand(brand);
		item.setClosingDate(closingDate);
		item.setClosingTime(closingTime);
		item.setCurrentBid(currentBid);
		item.setInitialPrice(initialPrice);
		item.setMinPrice(minPrice);
		item.setItem_increment(item_increment);
		item.setUpper_limit(upper_limit);
		item.setUser_increment(user_increment);

		return item;
	}

	// Extract an item from a query resultset.
	private Item extractItem(ResultSet resultSet) throws SQLException {
		int itemId = resultSet.getInt("item_id");

		String loginId = resultSet.getString("login_id");
		User user = userRepository.findUserByLoginId(loginId).get();

		String itemType = resultSet.getString("item_type");
		String brand = resultSet.getString("brand");
		Date closingDate = resultSet.getDate("closing_date");
		Time closingTime = resultSet.getTime("closing_time");
		double currentBid = resultSet.getDouble("current_bid");
		double initialPrice = resultSet.getDouble("initial_price");
		double minPrice = resultSet.getDouble("min_price");
		String characteristics = resultSet.getString("characteristics");
		double item_increment = resultSet.getDouble("bid_increment");

		Item item = new Item();
		item.setItemId(itemId);
		item.setUser(user);
		item.setItemType(itemType);
		item.setBrand(brand);
		item.setClosingDate(closingDate);
		item.setClosingTime(closingTime);
		item.setCurrentBid(currentBid);
		item.setInitialPrice(initialPrice);
		item.setMinPrice(minPrice);
		item.setItem_increment(item_increment);

		return item;
	}

	// Convert a generic Item object to one of it's subclasses e.g "Camera"
	// if the item is detected to be a camera in the database.
	private Item specializeItem(Item item) throws SQLException {
		Optional<Phone> phoneOptional = specializeAsPhone(item);
		if (phoneOptional.isPresent()) {
			return phoneOptional.get();
		}

		Optional<ComputerAccessory> computerAccessoryOptional = specializeAsComputerAccessory(item);
		if (computerAccessoryOptional.isPresent()) {
			return computerAccessoryOptional.get();
		}

		Optional<Computer> computerOptional = specializeAsComputer(item);
		if (computerOptional.isPresent()) {
			return computerOptional.get();
		}

		Optional<Camera> cameraOptional = specilizeAsCamera(item);
		if (cameraOptional.isPresent()) {
			return cameraOptional.get();
		}

		return item;
	}

	// Convert an Item to a Phone object if the Item is a phone
	// as verified in the database.
	private Optional<Phone> specializeAsPhone(Item item) throws SQLException {
		String query = "SELECT * FROM `phones` WHERE `item_id` = ?";
		PreparedStatement statement = dbConnection.prepareStatement(query);
		statement.setInt(1, item.getItemId());
		ResultSet resultSet = statement.executeQuery();
		Optional<Phone> phoneOptional = Optional.empty();

		if (resultSet.next()) {
			Phone phone = new Phone(item);
			phoneOptional = Optional.of(phone);
		}

		resultSet.close();
		statement.close();

		return phoneOptional;

	}

	// Convert an Item to a ComputerAccessory object if the Item is a computer
	// accessory
	// as verified in the database.
	private Optional<ComputerAccessory> specializeAsComputerAccessory(Item item) throws SQLException {
		String query = "SELECT * FROM `computer_accessories` WHERE `item_id` = ?";
		PreparedStatement statement = dbConnection.prepareStatement(query);
		statement.setInt(1, item.getItemId());
		ResultSet resultSet = statement.executeQuery();
		Optional<ComputerAccessory> accessoryOptional = Optional.empty();

		if (resultSet.next()) {
			ComputerAccessory computerAccessory = new ComputerAccessory(item);
			accessoryOptional = Optional.of(computerAccessory);
		}

		resultSet.close();
		statement.close();

		return accessoryOptional;
	}

	// Convert an Item to a Computer object if the Item is a computer
	// as verified in the database.
	private Optional<Computer> specializeAsComputer(Item item) throws SQLException {
		String query = "SELECT * FROM `computers` WHERE `item_id` = ?";
		PreparedStatement statement = dbConnection.prepareStatement(query);
		statement.setInt(1, item.getItemId());
		ResultSet resultSet = statement.executeQuery();
		Optional<Computer> computerOptional = Optional.empty();

		if (resultSet.next()) {
			Computer computer = new Computer(item);
			computerOptional = Optional.of(computer);
		}

		resultSet.close();
		statement.close();

		return computerOptional;
	}

	// Convert an Item to a Camera object if the Item is a camera
	// as verified in the database.
	private Optional<Camera> specilizeAsCamera(Item item) throws SQLException {
		String query = "SELECT * FROM `cameras` WHERE `item_id` = ?";
		PreparedStatement statement = dbConnection.prepareStatement(query);
		statement.setInt(1, item.getItemId());
		ResultSet resultSet = statement.executeQuery();
		Optional<Camera> cameraOptional = Optional.empty();

		if (resultSet.next()) {
			Camera camera = new Camera(item);
			cameraOptional = Optional.of(camera);
		}

		resultSet.close();
		statement.close();

		return cameraOptional;
	}
}
