<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="persistence.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="../css/core.css" rel="stylesheet" />
<title>Bid Item</title>
</head>
<body>
    <%
    try{
        //Get the database connection
        
        DbConnectionManager db = new DbConnectionManager();
        Connection con = db.getDbConnection();

        //Create a SQL statement
        Statement st = con.createStatement();
        Statement st1 = con.createStatement();
        Statement st2 = con.createStatement();
        Statement st3 = con.createStatement();
        
        Double bidPrice = Double.parseDouble(request.getParameter("bid_price"));
        Double bid_increment = Double.parseDouble(request.getParameter("bid_increment"));
        Double current_bid = Double.parseDouble(request.getParameter("current_bid"));
        String loginID = (String)session.getAttribute("user");
        int itemId = Integer.parseInt(request.getParameter("item_id"));
        
        if(bidPrice < bid_increment + current_bid){
            out.println("<p>The bid price is lower than the allowed bid increment</p><br>");
            out.println("<p>Please enter the bid price again at <a href = item.jsp?item_id=" + itemId + ">Bid Item</a></p>");
        }
        
        else{
    
            ResultSet bidNum = st.executeQuery("SELECT MAX(b.bid_id) FROM bid b");
        
            int bidNumber;
        
            if(bidNum != null){
                bidNum.next();
                bidNumber = bidNum.getInt(1) + 1;
            }
            else{
                bidNumber = 1;
            }
        
            st.executeUpdate("INSERT INTO bid VALUES(" + bidNumber + ", '" + loginID + "', " + bidPrice + ", " + itemId + ");"); 
        
            st1.executeUpdate("UPDATE item i SET current_bid = " + bidPrice + "WHERE i.item_id = " + itemId + ";");
        
            ResultSet alertData = st2.executeQuery("SELECT b.login_id, b.item_id AS item_id, i.current_bid AS current_bid " +  
                                                   "FROM bid b, item i " +
                                                   "WHERE b.item_id = " + itemId + 
                                                   " AND i.item_id = " + itemId +
                                                   " AND b.amount < " + bidPrice);
        
            while(alertData.next()){
                st3.executeUpdate("INSERT INTO alerts (login_id, item_id, current_bid) VALUES('" + alertData.getString("login_id") + "', " + alertData.getInt("item_id") + ", " + alertData.getDouble("current_bid") + 
                                  ") ON DUPLICATE KEY UPDATE current_bid = " + alertData.getDouble("current_bid") + ";");
            }
        
            out.println("Thank you for bidding for the item.");
            out.println("<a href = setAuction.jsp> Go to the Auctions Page</a>");
        }
                
        //Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
        con.close();
    }
    catch(Exception e){
        e.printStackTrace();
        out.println("Unable to add the item.");
    }
    %>
</body>
</html>