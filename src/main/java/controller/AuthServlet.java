package controller;

import persistence.model.user.CustomerRepresentative;
import persistence.model.user.EndUser;
import persistence.model.user.User;
import service.AuthService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

/**
 * Servlet to authenticate users.
 */
@WebServlet({"/authenticate"})
public class AuthServlet extends HttpServlet {
    private AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        // Get the username and password.
        String userId = req.getParameter("userId");
        String password = req.getParameter("password");

        // check if the user exists given the user id.
        Optional<User> userOptional = authService.findUserByUserId(userId);
        if(!userOptional.isPresent()){
            String url = req.getContextPath() + "/?error=Invalid Username or Password";
            resp.sendRedirect(url);
            return;
        }

        // check if the password is correct.
        User user = userOptional.get();
        if(!user.getPwd().equals(password)){
            String url = req.getContextPath() + "/?error=Invalid Username or Password";
            resp.sendRedirect(url);
            return;
        }

        // set the authenticated user to the session.
        req.getSession().setAttribute(AttributeKeys.AUTHENTICATED_USER, user);

        // redirect the user to their respective home pages.
        String redirectUrl = "";
        if(user instanceof EndUser){
            redirectUrl = req.getContextPath() + "/end_user/";
        } else if(user instanceof CustomerRepresentative){
            redirectUrl = req.getContextPath() + "/cust_rep/";
        } else {
            redirectUrl = req.getContextPath() + "/admin/";
        }

        resp.sendRedirect(redirectUrl);
    }
}
