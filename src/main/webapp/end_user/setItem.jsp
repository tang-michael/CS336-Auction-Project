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
        DbConnectionManager db = new DbConnectionManager();
        Connection con = db.getDbConnection();

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
        double bid_increment = Double.parseDouble(request.getParameter("bidIncrement"));
        double min_Price;
        if(request.getParameter("minPrice").equals("")){
            min_Price = 0;
        }
        else{
            min_Price = Double.parseDouble(request.getParameter("minPrice"));
        }
        String closing_date = request.getParameter("closing_date");
        String closing_time = request.getParameter("closing_time");
    
        ResultSet itemNum = st1.executeQuery("SELECT MAX(i.item_id) FROM item i");
        
        int itemNumber;
        
        if(itemNum != null){
            itemNum.next();
            itemNumber = itemNum.getInt(1) + 1;
        }
        else{
            itemNumber = 1;
        }
        
        st.executeUpdate("INSERT INTO item VALUES(" + itemNumber + ", '" + loginID + "', '" + itemType + "', '"+ brandName + "', " + 0 + ", " + 
                                                      init_Price + ", " + bid_increment + ", " + min_Price + ", '" + closing_date + "', '" + closing_time + "');");
        
        if(itemType.equals("Computer Accessories")){
            String connectivity = request.getParameter("compAccConnec");
            String color = request.getParameter("compAccCol");
            String battery = request.getParameter("compAccBat");
            st1.executeUpdate("INSERT INTO computer_accessories VALUES(" + itemNumber  + ", '" + connectivity + "', '" + 
                               color + "', '" + battery + "');");
        }
        else if(itemType.equals("Computers")){
            String screen_size = request.getParameter("compScreenSize");
            String processor = request.getParameter("compProc");
            String ram = request.getParameter("compRam");
            st2.executeUpdate("INSERT INTO computers VALUES(" + itemNumber + ", '" + screen_size + "', '" + 
                               processor + "', '" + ram + "');");
        }
        else if(itemType.equals("Phones")){
            String wireless_connectivity = request.getParameter("phoneConnec");
            String storage_size = request.getParameter("phoneStorage");
            String camera_features = request.getParameter("phoneCamera");
            st3.executeUpdate("INSERT INTO phones VALUES(" + itemNumber  + ", '" + wireless_connectivity + "', '" +
                               storage_size + "', '" + camera_features + "');");
        }
        else{
            String pixels = request.getParameter("cameraPixel");
            String zoom = request.getParameter("cameraZoom");
            String lenses = request.getParameter("cameraLenses");
            st4.executeUpdate("INSERT INTO cameras VALUES(" + itemNumber  + ", '" + pixels + "', '" + 
                               zoom + "', '" + lenses + "');");
        }
        out.println("Thank you for registering the item.");
        out.println("<p>To go back to the auctions page: <a href=setAuction.jsp>Auctions</a></p>");
                
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