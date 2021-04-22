package controller;

import persistence.model.user.EndUser;
import persistence.model.user.User;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;
import java.util.stream.Stream;

/**
 * Servlet to update a user.
 */
@WebServlet({"/cust_rep/edit_user"})
public class EditUserServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // Get the user details we are about to edit
        String loginId = req.getParameter("loginId");
        String firstName = req.getParameter("firstName").trim();
        String lastName = req.getParameter("lastName").trim();
        String email = req.getParameter("email").trim();
        String password = req.getParameter("password");

        // ensure all the fields are present.
        if(Stream.of(firstName, lastName, email, password).anyMatch(String::isEmpty)){
            String url = req.getContextPath() + "/cust_rep/edit_user.jsp?loginId=" + loginId + "&error=All fields are required";
            resp.sendRedirect(url);
            return;
        }

        // ensure the user we are about to edit exists.
        Optional<User> userOptional = userService.findUserByLoginId(loginId);
        if(!userOptional.isPresent()){
            String url = req.getContextPath() + "/cust_rep/user_accounts.jsp?error=Invalid User";
            resp.sendRedirect(url);
            return;
        }

        // create a new user object.
        User user = userOptional.get();
        EndUser endUser = (EndUser) user;
        endUser.setPwd(password);
        endUser.setEmail(email);
        endUser.setFname(firstName);
        endUser.setLname(lastName);

        // update the user using the object above.
        userService.updateEndUser(endUser);

        // redirect to the edit user page.
        String url = req.getContextPath() + "/cust_rep/edit_user.jsp?loginId=" + loginId + "&info=User was updated";
        resp.sendRedirect(url);
    }
}
