<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="persistence.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/user.css" rel="stylesheet" type="text/css" />
<link href="../css/core.css" rel="stylesheet" />
<title>Auctions</title>
</head>
<body>

    <%
    
    DbConnectionManager db = new DbConnectionManager();
    Connection con = db.getDbConnection();
    
    Statement stItems = null;
    ResultSet rsItems = null;
    
    Statement st = con.createStatement();
    
    
    String current_user = (String)session.getAttribute("user");
    
    out.println("<p>Welcome " + current_user + "</p>");
    
    out.println("<br>");
    
    out.println("<p>Create a new auction for an Item: <a href = postItem.jsp>Post Item</a></p>");
    
    Statement st1 = con.createStatement();
    ResultSet alertsForUser = st1.executeQuery("SELECT * FROM alerts a " + 
                                               "WHERE a.login_id = '" + session.getAttribute("user") + "';");
    
    Statement st2 = con.createStatement();
    ResultSet winnerAlertsForUser = st2.executeQuery("SELECT * FROM winner_alerts a " + 
            "WHERE a.login_id = '" + session.getAttribute("user") + "';");
    
    int counter = 1;

    while(alertsForUser.next()){
        
        if(counter == 1){
            out.println("<br><p>Alerts: </p>");
        }
        out.println("<p>The item with item id " + alertsForUser.getInt("item_id") + " has a higher bid of $" + alertsForUser.getDouble("current_bid") + " which is higher than you placed.</p><br>");
        
        counter++;
    }
    
    while(winnerAlertsForUser.next()){
        
        if(counter == 1){
            out.println("<br><p>Alerts: </p>");
        }
  
        out.println("<p>You won the auction for item with item id:  " + winnerAlertsForUser.getInt("item_id") + " which has the highest bid of $" + winnerAlertsForUser.getDouble("current_bid") + ".</p><br>");
       
        counter++;
    }
    
    
    
    %>
    <section class="user-heading">
        <h1>Auction</h1>
        <% 
        String sql = "SELECT * FROM item i";
        stItems = con.createStatement(); 
        rsItems = stItems.executeQuery(sql);
        %>
    </section>
    
    <section class="user_items">
        <h3>Current Items</h3>
        <table>
            <thead>
    
                <tr>
                    <th>Item Id</th>
                    <th>Seller</th>
                    <th>Current Bid</th>
                    <th>Item type</th>
                    <th>Brand</th>
                    <th>Initial Price</th>
                    <th>Characteristics</th>
                    <th>Closing Date</th>
                    <th>Closing Time</th>
                </tr>
            </thead>
            <tbody>
                <%
                while (rsItems.next()) {
                    String id = rsItems.getString("item_id");
                    Timestamp currentdate = new Timestamp(System.currentTimeMillis());
                    
                    String closing_date = rsItems.getString("closing_date");
                    String closing_time = rsItems.getString("closing_time");
                    
                    Timestamp closing_date_time = new Timestamp(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(closing_date + " " + closing_time).getTime());
                    
                    if(currentdate.compareTo(closing_date_time) > 0){
                     
                        if(Integer.parseInt(rsItems.getString("current_bid")) >= Integer.parseInt(rsItems.getString("min_price"))){                           
                            //Alert the winner
                            
                            Statement st4 = con.createStatement();
                            Statement st5 = con.createStatement();
                            Statement st6 = con.createStatement();
                            
                            ResultSet winner = st4.executeQuery("SELECT b.login_id AS login_id FROM bid b " + 
                                                               "WHERE b.amount = " + rsItems.getDouble("current_bid") + 
                                                               " AND b.item_id = " + rsItems.getInt("item_id") + ";");

                            while(winner.next()){
                                st5.executeUpdate("INSERT INTO winner_alerts (login_id, item_id, current_bid) VALUES('" + winner.getString("login_id") + "', " + rsItems.getInt("item_id") + ", " +
                                                   rsItems.getDouble("current_bid") + ") ON DUPLICATE KEY UPDATE login_id = '" + winner.getString("login_id") + "';");
                                break;
                            }
                            
                            st6.executeUpdate("DELETE FROM alerts a WHERE a.login_id = '" + rsItems.getString("login_id") + 
                                              "' AND a.item_id = " + rsItems.getInt("item_id") + ";");
                               
                        }
                    }
                %>
                <tr>
                    <td><a href="item.jsp?item_id=<%=id%>"><%=id%></a></td>
                    <td><%=rsItems.getString("login_id")%></td>
                    <td>$<%=rsItems.getString("current_bid")%></td>
                    <td><%=rsItems.getString("item_type")%></td>
                    <td><%=rsItems.getString("brand")%></td>
                    <td>$<%=rsItems.getString("initial_price")%></td>
                    <td><%=rsItems.getString("characteristics")%></td>
                    <td><%=rsItems.getString("closing_date") %></td>
                    <td><%=rsItems.getString("closing_time") %></td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </section>
    <%
    
    out.println("<p>To go back to the homepage: <a href = index.jsp>Home</a></p>");
    con.close();
    %>
</body>
</html>