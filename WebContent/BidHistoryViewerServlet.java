package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import persistence.repository.BidRepository;

/** Servlet to view history of bids in any auction **/

@WebServlet("/HistoryViewer")
public class BidHistoryViewerServlet extends HttpServlet {
	
	private final BidRepository bidRepo = new BidRepository();
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException
	{
		String loginID = req.getParameter("loginId");
		List<Bid> history = bidRepo.findAllBids();
		PrintWriter pw = request.getWriter();
	
		for (Bid b : history)
		{
			if (b.getUser().getloginId() == loginID)
				pw.println(b.getBidId() + ", " + b.getItem().getItemId() + ", " + b.getItem().getBrand());
		}
		
	}
}
