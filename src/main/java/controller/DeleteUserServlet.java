package controller;

import persistence.model.user.EndUser;
import persistence.model.user.User;
import service.*;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

/**
 * Servlet to delete a user.
 */
@WebServlet({"/cust_rep/delete_user"})
public class DeleteUserServlet extends HttpServlet {
    private final UserService userService = new UserService();
    private final QuestionService questionService = new QuestionService();
    private final BidService bidService = new BidService();
    private final ItemService itemService = new ItemService();
    private final SalesService salesService = new SalesService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // Get the login id of the user to be deleted.
        String loginId = req.getParameter("loginId");

        // ensure the login id is present.
        if(loginId == null){
            String url = req.getContextPath() + "/cust_rep/user_accounts.jsp?error=User is required!";
            resp.sendRedirect(url);
            return;
        }

        // ensure a use exists with the given login id.
        Optional<User> userOptional = userService.findUserByLoginId(loginId);
        if(userOptional.isEmpty()){
            String url = req.getContextPath() + "/cust_rep/user_accounts.jsp?error=No such user!";
            resp.sendRedirect(url);
            return;
        }

        // ensure the user to be deleted is an EndUser (you can't delete customer representatives or admins).
        User user = userOptional.get();
        if(!(user instanceof EndUser)){
            String url = req.getContextPath() + "/cust_rep/user_accounts.jsp?error=Invalid User!";
            resp.sendRedirect(url);
            return;
        }

        // delete the user and any associated data such as sales, bids e.t.c
        EndUser endUser = (EndUser) user;
        
        // anonymize any questions asked by this user
        questionService.anonymizeQuestionsByEndUser(endUser);
        
        // delete the sales by this user, if any.
        salesService.deleteSalesByUser(endUser);
        
        // delete bids placed by this user.
        bidService.deleteBidsForUser(endUser);
        
        // delete any bids that were placed 
        // for any items belonging to the current user.
        bidService.deleteBidsForSellerItems(endUser);
        
        // delete any items this user had placed.
        itemService.deleteItemsForUser(endUser);
        
        // finally delete the user. 
        userService.deleteEndUser(loginId);

        // redirect to the user accounts page.
        String url = req.getContextPath() + "/cust_rep/user_accounts.jsp?info=Deleted user successfully!";
        resp.sendRedirect(url);
    }
}
