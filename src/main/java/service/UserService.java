package service;

import persistence.model.user.CustomerRepresentative;
import persistence.model.user.EndUser;
import persistence.model.user.User;
import persistence.repository.UserRepository;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Handle logic for the user objects.
 */
public class UserService {
    private final UserRepository userRepository;

    public UserService() {
        this.userRepository = new UserRepository();
    }

    // Check if the given end user is a buyer or not.
    public boolean isBuyer(EndUser user){
        try {
            return userRepository.isBuyer(user);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    // Get a list of all the customer representatives.
    public List<CustomerRepresentative> findAllCustomerRepresentatives(){
        try {
            List<User> allUsers = userRepository.findAllUsers();
            List<CustomerRepresentative> customerRepresentatives = new ArrayList<>();
            for (User user : allUsers) {
                if(user instanceof CustomerRepresentative){
                    customerRepresentatives.add((CustomerRepresentative) user);
                }
            }
            return customerRepresentatives;
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    // Delete an end user given the loginid
    public void deleteEndUser(String loginId){
        try {
            userRepository.deleteEndUser(loginId);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    // Update an end user with the new data.
    public void updateEndUser(EndUser endUser){
        try {
            userRepository.updateEndUser(endUser);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    // Get a list of all the end users that do not include the anonymous user.
    public List<EndUser> findAllEndUsers(){
        try {
            List<User> allUsers = userRepository.findAllUsers();
            List<EndUser> endUsers = new ArrayList<>();
            for (User user : allUsers) {
                if(!user.getLoginId().equals("anonymous") && user instanceof EndUser){
                    endUsers.add((EndUser) user);
                }
            }
            return endUsers;
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    // Find a user given their login.
    public Optional<User> findUserByLoginId(String loginId){
       return this.userRepository.findUserByLoginId(loginId);
    }

    // Add a new user to the system.
    public void addUser(User user){
        this.userRepository.addUser(user);
    }
}
