package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

import persistence.*;
import service.UserService;
import java.io.PrintWriter;


/**
 * Servlet to provide alerts for users
 */
@WebServlet("/AlertsManagerServlet")
public class AlertsManagerServlet extends HttpServlet {

	private final UserService userServ = new UserService();
	private final ItemRepository itemRepo = new ItemRepository();
	private final DbConnectionManager dbconn = new DbConnectionManager();
	
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String loginID = request.getParameter("loginId");
		PrintWriter pw = request.getWriter();
		
		Optional<User> userTemp = userServ.findUserByLoginId(loginID);
		
		if(userTemp.isEmpty()){
            String url = request.getContextPath() + "/end_user/index.jsp?error=No user found";
            response.sendRedirect(url);
            return;
        }
		
		User user = userTemp.get();
		 if(!(user instanceof EndUser)){
	            String url = request.getContextPath() + "/end_user/index.jsp?error=User not allowed";
	            response.sendRedirect(url);
	            return;
	        }
		 
		 EndUser enduser = (EndUser) user;
		
		// confirms user will be buyer and be able to set alert for item
		if (userServ.isBuyer(enduser))
		{
			int itemID = request.getparameter("itemId");
			
			//queries for wanted item
			String query = "select i.itemType from item where i.itemId = " + itemID;
			PreparedStatement ps = dbconn.getConnection().prepareStatement(query, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
			ResultSet rs = ps.executeQuery();
			
			Item item = itemRepo.extractItem(rs);
		
			String alert = request.getParameter("alerts");
			enduser.setAlerts(alert);
			
			pw.println("Item " + item.getitemId() + " begins at $" + item.getInitialPrice() + " and bidding closes on " +
					item.getClosingDate() + " at " + item.getClosingTime());
		}
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
}
	
