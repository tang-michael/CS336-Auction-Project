package service;

import persistence.repository.UserRepository;
import persistence.model.user.Buyer;
import persistence.model.user.EndUser;
import persistence.model.user.Seller;
import persistence.model.user.User;

import java.util.Optional;

/**
 * The class handles authentication logic.
 */
public class AuthService {
    private final UserRepository userRepository = new UserRepository();

    // Find a user given the id in the system storage.
    public Optional<User> findUserByUserId(String userId){
        return userRepository.findUserByLoginId(userId);
    }

    // Check if an end user exists given the email
    public boolean endUserExistsByEmail(String email){
       return userRepository.endUserExistsByEmail(email);
    }

    // Register a new user in the database.
    public void register(String userId, String firstName, String lastName, String email, String password, String initialRole){
        EndUser user;
        if(initialRole.equals("BUYER")){
            Buyer buyer  = new Buyer();
            buyer.setAlerts("");
            user = buyer;
        } else {
            user = new Seller();
        }

        user.setLoginId(userId);
        user.setFname(firstName);
        user.setLname(lastName);
        user.setEmail(email);
        user.setPwd(password);

        userRepository.addUser(user);
    }
}
