package controller;

import service.BidService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet to delete a bid.
 */
@WebServlet({"/cust_rep/delete_bid"})
public class DeleteBidServlet extends HttpServlet {

    private final BidService bidService = new BidService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // Get the bid id to be deleted from the request, convert it into an integer.
        String bidId = req.getParameter("bidId");
        int parsedId;

        try{
            parsedId = Integer.parseInt(bidId);
        } catch (Exception e){
            parsedId = -100;
        }

        // delete the the bid using the bid id.
        bidService.deleteBid(parsedId);

        // redirect to the bids page.
        String url = req.getContextPath() + "/cust_rep/bids.jsp?info=Deleted bid successfully";
        resp.sendRedirect(url);
    }
}
