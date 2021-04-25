package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import persistence.model.item.Item;
import persistence.model.user.User;
import service.ItemService;

@WebServlet({ "/end_user/update-autobid" })
public class AutoBidServlet extends HttpServlet {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private ItemService itemService = new ItemService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String bid = req.getParameter("user-bid");
        String upper_limit = req.getParameter("upper-limit");
        String bid_increment = req.getParameter("bid-increment");
        String item_id = req.getParameter("item_id");
        
        User user = (User) req.getSession().getAttribute(AttributeKeys.AUTHENTICATED_USER);

        try {
            Item item = itemService.getExactItem(item_id);

            /* Edge cases */
            // updateItemBid(item_id, current_bid,upper_limit,user_increment,
            // item_increment);
            // Check if placed bid is greater than current bid
            if (Double.parseDouble(bid) < item.getCurrentBid()) {
                resp.sendRedirect(req.getContextPath() + "/end_user/autoBidItem.jsp?item_id=" + item_id
                        + "&error=bid must be higher than current bid!");
                return;
            }
            // Check if (placed bid - current bid) is higher than the increment
            else if (Double.parseDouble(bid) - item.getCurrentBid() < item.getItem_increment()) {
                resp.sendRedirect(req.getContextPath() + "/end_user/autoBidItem.jsp?item_id=" + item_id
                        + "&error=bid must be higher than the increment!");
                return;
            }
            /* No upper limit */
            if (upper_limit.length() == 0) {
                // Bid is greater than upper limit with no upper limit
                if (item.getUpper_limit() < Double.parseDouble(bid)) {
                    double total = Double.parseDouble(bid) + item.getUser_increment();
                    itemService.updateItemBid(item_id,String.valueOf(total), String.valueOf(0), String.valueOf(item.getUser_increment()),
                            String.valueOf(item.getItem_increment()));
                    resp.sendRedirect(req.getContextPath() + "/end_user/autoBidItem.jsp?item_id=" + item_id);
//                    itemService.updateWinner(item_id, user.getLoginId());
                    return;
                }
                // Bid is less than upper limit with no upper limit
                else if (item.getUpper_limit() > Double.parseDouble(bid)) {
                    double total = Double.parseDouble(bid) + item.getUser_increment();
                    itemService.updateItemBid(item_id, String.valueOf(total), String.valueOf(0), String.valueOf(item.getUpper_limit()),
                            String.valueOf(item.getItem_increment()));
                    resp.sendRedirect(req.getContextPath() + "/end_user/autoBidItem.jsp?item_id=" + item_id);
                    return;
                }else if(item.getUpper_limit() == Double.parseDouble(bid)) {
                    double total = Double.parseDouble(bid) + item.getUser_increment();
                    itemService.updateItemBid(item_id,String.valueOf(total), String.valueOf(0), String.valueOf(item.getUser_increment()),
                            String.valueOf(item.getItem_increment()));  
                    return;
                }
            }

            if (upper_limit.length() > 0 && bid_increment.length() > 0) {
                // First bid for that item
                if(Double.parseDouble(bid_increment) < item.getItem_increment()) {
                    resp.sendRedirect(req.getContextPath() + "/end_user/autoBidItem.jsp?item_id=" + item_id
                            + "&error=Your bid increment must be greater than or equal to the current increment!");
                    return;
                }
                if (item.getUpper_limit() == 0 && item.getUser_increment() == 0) {
                    itemService.updateItemBid(item_id, bid, upper_limit, bid_increment,
                            String.valueOf(item.getItem_increment()));
                    resp.sendRedirect(req.getContextPath() + "/end_user/autoBidItem.jsp?item_id=" + item_id);
//                    itemService.updateWinner(item_id, user.getLoginId());
                    return;
                } else if (item.getUpper_limit() > Double.parseDouble(upper_limit)) {
                    itemService.updateItemBid(item_id, upper_limit + String.valueOf(item.getUser_increment()), String.valueOf(item.getUpper_limit()),
                            String.valueOf(item.getUser_increment()), String.valueOf(item.getItem_increment()));
                    resp.sendRedirect(req.getContextPath() + "/end_user/autoBidItem.jsp?item_id=" + item_id);
                    return;
                } else if (item.getUpper_limit() < Double.parseDouble(upper_limit)) {
                    itemService.updateItemBid(item_id, bid + item.getUser_increment(), upper_limit, bid_increment, String.valueOf(item.getItem_increment()));
                    resp.sendRedirect(req.getContextPath() + "/end_user/autoBidItem.jsp?item_id=" + item_id);
//                    itemService.updateWinner(item_id, user.getLoginId());
                    return;
                }
            }

        } catch (SQLException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }

//        
//        try {
//          itemService.updateItemBid(item_id, bid, upper_limit, bid_increment);
//      } catch (SQLException e) {
//          // TODO Auto-generated catch block
//          e.printStackTrace();
//      }

        resp.sendRedirect(req.getContextPath() + "/end_user/item.jsp?item_id=" + item_id);
    }

}
