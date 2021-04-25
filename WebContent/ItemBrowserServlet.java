package controller;

import persistence.model.item.Item;
import persistence.model.user.User;
import persistence.repository.ItemRepository;

import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

/** Servlet to browse items and check current bid status **/


@WebServlet({"/BrowseItems"});
public class ItemBrowserServlet extends HttpServlet {

	private final ItemRepository itemRepo = new ItemRepository();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		List<Item> browser = itemRepo.findItems();
		double currentBid = req.getParameter("currentBid");
		String itemType = req.getParameter("itemType");
		String brand = req.getParameter("brand");
		int itemID = req.getParameter("itemId");
		
		PrintWriter pw = request.getWriter();
		
		for(Item i: browser)
		{
			pw.println(i.getItemId() + ", " + i.getBrand() + ", " + i.getCurrentBid()); 
		}
		
	}
}
