package controller;

import persistence.model.user.CustomerRepresentative;
import service.UserService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.stream.Stream;

/**
 * Servlet to add a new customer representative.
 */
@WebServlet({"/admin/add_rep"})
public class AddCustomerRepresentativeServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        // extract the customer representative data from request.
        String userId = req.getParameter("userId").trim();
        String firstName = req.getParameter("firstName").trim();
        String lastName = req.getParameter("lastName").trim();
        String hireDate = req.getParameter("hireDate").trim();
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        // validate the data

        boolean isAnyEmpty = Stream.of(userId, firstName, lastName, hireDate, password, confirmPassword)
                .anyMatch(String::isEmpty);

        if(isAnyEmpty){
            String url = req.getContextPath() + "/admin/create_rep.jsp?error=All fields are required";
            resp.sendRedirect(url);
            return;
        }

        if(!password.equals(confirmPassword)){
            String url = req.getContextPath() + "/admin/create_rep.jsp?error=Passwords do not match!";
            resp.sendRedirect(url);
            return;
        }

        if(userService.findUserByLoginId(userId).isPresent()){
            String url = req.getContextPath() + "/admin/create_rep.jsp?error=User id is already taken";
            resp.sendRedirect(url);
            return;
        }

        DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");
        Date hireDateObj = null;
        try {
            hireDateObj = dateFormat.parse(hireDate);
        } catch (ParseException e) {
            String url = req.getContextPath() + "/admin/create_rep.jsp?error=Invalid Date Format";
            resp.sendRedirect(url);
            return;
        }


        // create the customer representative object from the validated data.
        CustomerRepresentative customerRepresentative = new CustomerRepresentative();
        customerRepresentative.setHireDate(hireDateObj);
        customerRepresentative.setFname(firstName);
        customerRepresentative.setLname(lastName);
        customerRepresentative.setLoginId(userId);
        customerRepresentative.setPwd(password);

        // add the customer representative to the database and redirect to the page for adding new
        // customer representatives.
        userService.addUser(customerRepresentative);
        resp.sendRedirect(req.getContextPath() + "/admin/create_rep.jsp?info=Added customer representative.");
    }
}
