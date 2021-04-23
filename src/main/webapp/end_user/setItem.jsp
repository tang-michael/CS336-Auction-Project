<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="persistence.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="../css/core.css" rel="stylesheet" />
<title>Sell Item</title>
</head>
<body>
    <%
    try{
        //Get the database connection
        Connection con = DbConnectionManager.getConnection();

        //Create a SQL statement
        Statement st = con.createStatement();
        Statement st1 = con.createStatement();
        Statement st2 = con.createStatement();
        Statement st3 = con.createStatement();
        Statement st4 = con.createStatement();
        
        String itemType = request.getParameter("type");
        String loginID = request.getParameter("login_id");
        String brandName = request.getParameter("brandName");
        double init_Price = Double.parseDouble(request.getParameter("initPrice"));
        String itemName = request.getParameter("itemName");
        String characteristics = request.getParameter("characteristics");
        int auctionId = Integer.parseInt(request.getParameter("auction_id"));
        double min_Price = Double.parseDouble(request.getParameter("minPrice"));
    
        ResultSet itemNum = st1.executeQuery("SELECT MAX(i.item_id) FROM item i");
        
        int itemNumber;
        
        if(itemNum != null){
            itemNum.next();
            itemNumber = itemNum.getInt(1) + 1;
        }
        else{
            itemNumber = 1;
        }
        
        st.executeUpdate("INSERT INTO item VALUES(" + itemNumber + ", " + auctionId + ", '" + loginID + "', '" + itemType + "', '"+ brandName + "', " + 0 + ", " + init_Price + ", " + min_Price + ", '" + characteristics + "');");
        
        if(itemType.equals("computerAccessories")){
            st1.executeUpdate("INSERT INTO computer_accessories VALUES(" + itemNumber  + ");");
        }
        else if(itemType.equals("computers")){
            st2.executeUpdate("INSERT INTO computers VALUES(" + itemNumber + ");");
        }
        else if(itemType.equals("phones")){
            st3.executeUpdate("INSERT INTO phones VALUES(" + itemNumber  + ");");
        }
        else{
            st4.executeUpdate("INSERT INTO camera VALUES(" + itemNumber  + ");");
        }
        out.println("Thank you for registering the item.");
                
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