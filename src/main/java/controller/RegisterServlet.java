package controller;

import service.AuthService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servelet to register new users.
 */
@WebServlet({"/register"})
public class RegisterServlet extends HttpServlet {
    private AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        // Get the new user data.
        String userId = req.getParameter("userId").trim();
        String email = req.getParameter("email").trim();
        String initialRole = req.getParameter("initialRole");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("password");
        String firstName = req.getParameter("firstName").trim();
        String lastName = req.getParameter("lastName").trim();

        // ensure all the fields are present.
        if (userId.isEmpty() ||
                email.isEmpty() ||
                password.isEmpty() ||
                confirmPassword.isEmpty() ||
                firstName.isEmpty() ||
                lastName.isEmpty()
        ){
            String url = req.getContextPath() + "/register.jsp?error=All fields are required";
            resp.sendRedirect(url);
            return;
        }

        // ensure the passwords match.
        if(!password.equals(confirmPassword)){
            String url = req.getContextPath() + "/register.jsp?error=Passwords do not match";
            resp.sendRedirect(url);
            return;
        }

        // ensure the login id is not taken.
        if(authService.findUserByUserId(userId).isPresent()){
            String url = req.getContextPath() + "/register.jsp?error=User id is already taken";
            resp.sendRedirect(url);
            return;
        }

        // ensure the email is not taken.
        if(authService.endUserExistsByEmail(email)){
            String url = req.getContextPath() + "/register.jsp?error=Email is already taken";
            resp.sendRedirect(url);
            return;
        }

        // register the user.
        authService.register(userId, firstName, lastName, email, password, initialRole);


        // redirect to the login page with success message.
        String url = req.getContextPath() + "/?info=Registration was successful. Log in.";
        resp.sendRedirect(url);
    }
}
