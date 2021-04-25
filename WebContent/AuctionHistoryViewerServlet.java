package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import persistence.repository.AuctionsRepository;
import java.io.PrintWriter;

/**
 * Servlet to view history of auctions an user participated in
 */
@WebServlet("/AuctionHistoryViewer")
public class AuctionHistoryViewerServlet extends HttpServlet {
	
	private final AuctionsRepository aucRepo = new AuctionsRepository();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String loginID = request.getParameter("loginId");
		List<Auction> history = aucRepo.findAllAuctions();
		PrintWriter pw = request.getWriter();
		
		for (Auction a : history)
		{
			if (a.getHistoryOfBids().contains(loginID))
				pw.println(a.getAuctionId());
		}
		
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
}
