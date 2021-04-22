package persistence.repository;

import persistence.model.Sales;
import persistence.model.item.Item;
import persistence.model.user.User;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Class that manipulates the "sells" table.
 */
public class SalesRepository extends Repository {
    private ItemRepository itemRepository = new ItemRepository();
    private UserRepository userRepository = new UserRepository();

    // Retreive all the sales from the database.
    public List<Sales> findSales() throws SQLException {
        String query = "SELECT * FROM sells";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        ResultSet resultSet = statement.executeQuery();
        List<Sales> sales = new ArrayList<>();
        while (resultSet.next()){
            int itemId = resultSet.getInt("item_id");
            Item item = itemRepository.findItems()
                    .stream()
                    .filter(it -> it.getItemId() == itemId)
                    .findFirst()
                    .get();

            String loginId = resultSet.getString("login_id");
            User user = userRepository.findUserByLoginId(loginId)
                    .get();

            Date date = resultSet.getDate("close_date_time");

            Sales salesObj = new Sales();
            salesObj.setCloseDateTime(date);
            salesObj.setItem(item);
            salesObj.setUser(user);

            sales.add(salesObj);
        }

        return sales;
    }

    // Delete all the sales that belong to a user of the given user id.
    public void deleteSalesByUserId(String userId) throws SQLException {
        String query = "DELETE FROM sells WHERE login_id = ?";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        statement.setString(1, userId);
        statement.execute();
        statement.close();
    }
}
