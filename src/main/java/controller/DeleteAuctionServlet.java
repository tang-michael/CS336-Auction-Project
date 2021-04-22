package controller;

import service.AuctionService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet to delete an auction.
 */
@WebServlet({"/cust_rep/delete_auction"})
public class DeleteAuctionServlet extends HttpServlet {

    private final AuctionService auctionService = new AuctionService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // get the id of the auction to be removed. Convert it into an integer from a string.
        String auctionId = req.getParameter("auctionId");
        int parsedAuctionId;
        try {
            parsedAuctionId = Integer.parseInt(auctionId);
        } catch (Exception e){
            parsedAuctionId = -1;
        }

        // delete the auction with the given id
        auctionService.deleteAuction(parsedAuctionId);

        // redirect to the auctions list page.
        String url = req.getContextPath() + "/cust_rep/auctions.jsp?info=Deleted Auction Successfully!";
        resp.sendRedirect(url);
    }
}
