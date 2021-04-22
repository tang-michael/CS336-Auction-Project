package persistence.repository;

import persistence.model.user.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

/**
 * Class that manipulates the "user", "buyer", "end_user", "sellers", "customer_representative"
 * and "admin" tables.
 */
public class UserRepository extends Repository {

    // Check if an end user (a buyer or seller) exists with the given email
    // in the database.
    public boolean endUserExistsByEmail(String email) {
       try {
           String query = "SELECT * FROM `end_user` WHERE `email` = ?";
           PreparedStatement statement = dbConnection.prepareStatement(query);
           statement.setString(1, email);
           ResultSet resultSet = statement.executeQuery();

           boolean returnValue = resultSet.next();
           resultSet.close();
           statement.close();

           return returnValue;
       } catch (SQLException sqe){
           throw new RuntimeException(sqe);
       }
    }


    // Check whether an end user is a buyer.
    public boolean isBuyer(EndUser user) throws SQLException {
        String query = "SELECT * FROM `buyer` WHERE `login_id` = ?";
        PreparedStatement preparedStatement = dbConnection.prepareStatement(query);
        preparedStatement.setString(1, user.getLoginId());
        ResultSet resultSet = preparedStatement.executeQuery();

        boolean hasBuyer = resultSet.next();
        resultSet.close();
        preparedStatement.close();

        return hasBuyer;
    }

    // Find all the users form the database.
    public List<User> findAllUsers() throws SQLException {
        String query = "SELECT * FROM `users`";
        PreparedStatement preparedStatement = dbConnection.prepareStatement(query);
        ResultSet resultSet = preparedStatement.executeQuery();
        List<User> allUsers = new ArrayList<>();
        while (resultSet.next()){
            User user = userFromResultSet(resultSet);
            User specializedUser = specializeUser(user);
            allUsers.add(specializedUser);
        }

        resultSet.close();
        preparedStatement.close();
        return allUsers;
    }

    // Find a user given the login id.
    public Optional<User> findUserByLoginId(String loginId){
        try {
            Optional<User> generalUser = findGeneralUserByLoginId(loginId);
            if(!generalUser.isPresent()){
                return Optional.empty();
            }

             User user = specializeUser(generalUser.get());
            return Optional.of(user);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    // Extract a generic User object given the login id.
    private Optional<User> findGeneralUserByLoginId(String loginId) throws SQLException{
        String query = "SELECT * From `users` WHERE `login_id` = ?";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        statement.setString(1, loginId);

        ResultSet resultSet = statement.executeQuery();
        if(!resultSet.next()){
            return Optional.empty();
        }

        User user = userFromResultSet(resultSet);
        resultSet.close();
        statement.close();
        return Optional.of(user);
    }

    // Extract a generic User object from the given query resultset.
    private User userFromResultSet(ResultSet resultSet) throws SQLException {
        User user = new User();
        user.setFname(resultSet.getString("fname"));
        user.setLname(resultSet.getString("lname"));
        user.setLoginId(resultSet.getString("login_id"));
        user.setPwd(resultSet.getString("pwd"));

        return user;
    }

    // Convert a user to one of the User subclasses such as EndUser, Admin e.t.c
    private User specializeUser(User user) throws SQLException {
        Optional<User> admin = specializeAsAdmin(user);
        if(admin.isPresent()){
            return admin.get();
        }

        Optional<User> endUser = specializeAsEndUser(user);
        if(endUser.isPresent()){
            return endUser.get();
        }

        Optional<User> custRepUser = specializeAsCustomerRep(user);
        return custRepUser.orElse(user);
    }


    // Convert a User object to an EndUser object if
    // the user is an end user as determined in the database.
    private Optional<User> specializeAsEndUser(User user) throws SQLException {
        String query = "SELECT * FROM `end_user` WHERE `login_id` = ?";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        statement.setString(1, user.getLoginId());

        ResultSet resultSet = statement.executeQuery();
        if(!resultSet.next()){
            return Optional.empty();
        }

        String email = resultSet.getString("email");
        EndUser endUser = new EndUser();
        endUser.setEmail(email);
        endUser.setFname(user.getFname());
        endUser.setLname(user.getLname());
        endUser.setLoginId(user.getLoginId());
        endUser.setPwd(user.getPwd());

        resultSet.close();
        statement.close();
        return Optional.of(endUser);
    }


    // Update an endUser given the information.
    public void updateEndUser(EndUser endUser) throws SQLException {
        if(endUser instanceof Buyer){
            _updateBuyer((Buyer) endUser);
        }
        _updateEndUser(endUser);
        updateGenericUser(endUser);
    }

    // Update the "buyer" table given the buyer information.
    private void _updateBuyer(Buyer buyer) throws SQLException {
        String updateQuery = "UPDATE `buyer` SET `alerts` = ? WHERE `login_id` = ?";
        PreparedStatement statement = dbConnection.prepareStatement(updateQuery);
        statement.setString(1, buyer.getAlerts());
        statement.setString(2, buyer.getLoginId());
        statement.execute();
        statement.close();
    }


    // Update the "end_user" table given the end user information.
    private void _updateEndUser(EndUser endUser) throws SQLException {
        String updateQuery = "UPDATE `end_user` SET `email` = ? WHERE `login_id` = ?";
        PreparedStatement statement = dbConnection.prepareStatement(updateQuery);
        statement.setString(1, endUser.getEmail());
        statement.setString(2, endUser.getLoginId());
        statement.execute();
        statement.close();
    }

    // Update the "user" table given the user information.
    private void updateGenericUser(User user) throws SQLException {
        String updateQuery = "UPDATE `users` SET `fname`=?, `lname`=?, `pwd`=? WHERE login_id = ?";
        PreparedStatement statement = dbConnection.prepareStatement(updateQuery);
        statement.setString(1, user.getFname());
        statement.setString(2, user.getLname());
        statement.setString(3, user.getPwd());
        statement.setString(4, user.getLoginId());
        statement.execute();
        statement.close();
    }

    // If the user is a customer representative, convert them to a
    // CustomerRepresentative object.
    private Optional<User> specializeAsCustomerRep(User user) throws SQLException {
        String query = "SELECT * FROM `customer_representatives` WHERE `login_id` = ?";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        statement.setString(1, user.getLoginId());

        ResultSet resultSet = statement.executeQuery();
        if(!resultSet.next()){
            return Optional.empty();
        }

        Date date = resultSet.getDate("hire_date");
        CustomerRepresentative customerRepresentative = new CustomerRepresentative();
        customerRepresentative.setHireDate(date);
        customerRepresentative.setFname(user.getFname());
        customerRepresentative.setLname(user.getLname());
        customerRepresentative.setLoginId(user.getLoginId());
        customerRepresentative.setPwd(user.getPwd());

        resultSet.close();
        statement.close();

        return Optional.of(customerRepresentative);
    }

    // Delete an end user from the database.
    public void deleteEndUser(String loginId) throws SQLException {
        deleteBuyer(loginId);
        deleteSeller(loginId);
        _deleteEndUser(loginId);
        deleteGenericUser(loginId);
    }

    // Delete user from the "end_user" table.
    private void _deleteEndUser(String loginId) throws SQLException {
        String query = "DELETE FROM `end_user` WHERE `login_id` = ?";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        statement.setString(1, loginId);
        statement.execute();
        statement.close();
    }

    // Delete user from the "users" table.
    private void deleteGenericUser(String loginId) throws SQLException {
        String query = "DELETE FROM `users` WHERE `login_id` = ?";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        statement.setString(1, loginId);
        statement.execute();
        statement.close();
    }

    // Delete user from the "buyer" table.
    private void deleteBuyer(String loginId) throws SQLException {
        String query = "DELETE FROM `buyer` WHERE `login_id` = ?";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        statement.setString(1, loginId);
        statement.execute();
        statement.close();
    }

    // Delete user from the "sellers" table.
    private void deleteSeller(String loginId) throws SQLException {
        String query = "DELETE FROM `sellers` WHERE `login_id` = ?";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        statement.setString(1, loginId);
        statement.execute();
        statement.close();
    }


    // Convert the User to an Admin object if the user supplied is
    // determined to be an admin in the database.
    private Optional<User> specializeAsAdmin(User user) throws SQLException {
        String query = "SELECT * FROM `admins` WHERE `login_id` = ?";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        statement.setString(1, user.getLoginId());

        ResultSet resultSet = statement.executeQuery();
        if(!resultSet.next()){
            return Optional.empty();
        }

        Date date = resultSet.getDate("hire_date");
        Admin admin = new Admin();
        admin.setHireDate(date);
        admin.setFname(user.getFname());
        admin.setLname(user.getLname());
        admin.setLoginId(user.getLoginId());
        admin.setPwd(user.getPwd());

        resultSet.close();
        statement.close();

        return Optional.of(admin);
    }

    // Add a new user to the database.
    public void addUser(User user){
       try {
           addGenericUser(user);
           addCustomerRep(user);
           addEndUser(user);
           addBuyer(user);
           addSeller(user);
       } catch (SQLException e){
           e.printStackTrace();
           throw new RuntimeException(e);
       }
    }

    // add a user info to the "customer_representative" table.
    private void addCustomerRep(User customerRepresentative) throws SQLException {
        if(!(customerRepresentative instanceof CustomerRepresentative)){
            return;
        }

        CustomerRepresentative specializedUser = (CustomerRepresentative) customerRepresentative;
        String query = "INSERT INTO `customer_representatives`(`hire_date`, `login_id`) VALUES (? , ?)";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        java.sql.Date hireDate = new java.sql.Date(specializedUser.getHireDate().getTime());
        statement.setDate(1, hireDate);
        statement.setString(2, specializedUser.getLoginId());
        statement.execute();
        statement.close();
    }

    // Add user to the "end_user" table.
    private void addEndUser(User buyerOrSeller) throws SQLException {
        if(!(buyerOrSeller instanceof EndUser)){
            return;
        }

        EndUser specializedUser = (EndUser) buyerOrSeller;

        String query = "INSERT INTO `end_user`(`email`, `login_id`) VALUES (?, ?)";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        statement.setString(1, specializedUser.getEmail());
        statement.setString(2, specializedUser.getLoginId());
        statement.execute();
        statement.close();
    }

    // Add user to the "users" table.
    private void addGenericUser(User user) throws SQLException {
        String query = "INSERT INTO `users`(`fname`, `lname`, `login_id`, `pwd`) VALUES (?, ?, ?, ?)";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        statement.setString(1, user.getFname());
        statement.setString(2, user.getLname());
        statement.setString(3, user.getLoginId());
        statement.setString(4, user.getPwd());

        statement.execute();
        statement.close();
    }

    // Add user to the "buyer" table if the user is a buyer.
    private void addBuyer(User user) throws SQLException {
        if (!(user instanceof Buyer)){
            return;
        }

        Buyer buyer = (Buyer) user;
        String query = "INSERT INTO `buyer`(`alerts`, `login_id`) VALUES (? , ?)";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        statement.setString(1, buyer.getAlerts());
        statement.setString(2, buyer.getLoginId());
        statement.execute();
        statement.close();
    }

    // Add a seller to the "sellers" table in the database.
    private void addSeller(User user) throws SQLException {
        if(!(user instanceof Seller)){
            return;
        }

        String query = "INSERT INTO `sellers`(`login_id`) VALUES (?)";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        statement.setString(1, user.getLoginId());
        statement.execute();
        statement.close();
    }
}
