<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="persistence.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="css/item.css" rel="stylesheet" type="text/css" />
<link href="../css/core.css" rel="stylesheet" />
<title>Item</title>
</head>
<body>
    <%
       
        DbConnectionManager db = new DbConnectionManager();
        Connection con = db.getDbConnection();
    
        Statement stItems = null;
        ResultSet rsItems = null;
        
        String sql = "select * from item where item_id = " + request.getParameter("item_id");
        System.out.println(sql);
        stItems = con.createStatement(); 
        rsItems = stItems.executeQuery(sql);
        rsItems.next();
        
        String current_user = request.getParameter("name");
        out.println("<h1>Item</h1>");
    
    %>
    
    <div class="item-body">
        <div class="item-header">
            <b>Seller:</b><%=rsItems.getString("login_id")%>
        </div>
        <br />
        <div class="item-description">
            <b>Item Type:</b><%=rsItems.getString("item_type")%>
            <br />
            <b>Brand:</b> <%=rsItems.getString("brand")%>
            <br />
            <%
            if(rsItems.getString("item_type").equals("Computers")){
                Statement st1 = con.createStatement();
                ResultSet rs1 = st1.executeQuery("SELECT * FROM computers c WHERE c.item_id = " + request.getParameter("item_id") + ";");
                rs1.next();
                out.println("<b>Screen Size:</b> " + rs1.getString("screen_size") + "<br");
                out.println("<b>Processor:</b> " + rs1.getString("processor") + "<br");
                out.println("<b>RAM:</b> " + rs1.getString("ram") + "<br");
            }
            else if(rsItems.getString("item_type").equals("Computer Accessories")){
                Statement st2 = con.createStatement();
                ResultSet rs2 = st2.executeQuery("SELECT * FROM computer_accessories c WHERE c.item_id = " + request.getParameter("item_id") + ";");
                rs2.next();
                out.println("<b>Connectivity:</b> " + rs2.getString("connectivity") + "<br");
                out.println("<b>Color:</b> " + rs2.getString("color") + "<br");
                out.println("<b>Battery:</b> " + rs2.getString("battery") + "<br");
            }
            else if(rsItems.getString("item_type").equals("Phones")){
                Statement st3 = con.createStatement();
                ResultSet rs3 = st3.executeQuery("SELECT * FROM phones p WHERE p.item_id = " + request.getParameter("item_id") + ";");
                rs3.next();
                out.println("<b>Wireless Connectivity:</b> " + rs3.getString("wireless_connectivity") + "<br");
                out.println("<b>Storage Size:</b> " + rs3.getString("storage_size") + "<br");
                out.println("<b>Camera Features:</b> " + rs3.getString("camera_features") + "<br");
            }
            else{
                Statement st4 = con.createStatement();
                ResultSet rs4 = st4.executeQuery("SELECT * FROM cameras c WHERE c.item_id = " + request.getParameter("item_id") + ";");
                rs4.next();
                out.println("<b>MegaPixels:</b> " + rs4.getString("pixels") + "<br");
                out.println("<b>Zoom:</b> " + rs4.getString("zoom") + "<br");
                out.println("<b>Lenses:</b> " + rs4.getString("lenses") + "<br");
            }
                
            %>
        </div>
        <br />
        <div class="item-price">
            <b>Current Bid:</b><%=rsItems.getString("current_bid")%>
            <br />
            <b>Initial Price:</b> <%=rsItems.getString("initial_price")%>
        </div>
        

    </div>
    <br />
    <form action="bidItem.jsp" method="post">
        <%
        out.println("Please enter a bid higher than or equal to $" + ((rsItems.getDouble("current_bid") + rsItems.getDouble("bid_increment"))) + "<br>");
        %>
        Bid:<input type="text" id="bid_price" name="bid_price" required/>
        <br>
        <input type ="hidden" id="item_id" name="item_id" value=<%=request.getParameter("item_id")%>>
        <input type ="hidden" id="bid_increment" name="bid_increment" value=<%=rsItems.getDouble("bid_increment")%>>
        <input type ="hidden" id="current_bid" name="current_bid" value=<%=rsItems.getDouble("current_bid")%>>
        
        <input type ="submit" value = "Submit" />
    </form>
    <%
    con.close();
    %>
</body>
</html>