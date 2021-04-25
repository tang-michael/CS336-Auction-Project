<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="persistence.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="../css/core.css" rel="stylesheet" />
<title>Delete Account</title>
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
        Statement st5 = con.createStatement();
        Statement st6 = con.createStatement();
        
        
        out.println("<p>Please make sure that you have no pending auctions and bids before deleting your account.</p><br>");
        
        st.executeUpdate("DELETE FROM sellers s WHERE s.login_id = '" + (String)session.getAttribute("user") + "';");
        
        st1.executeUpdate("DELETE FROM buyer b WHERE b.login_id = '" + (String)session.getAttribute("user") + "';");
        
        st2.executeUpdate("DELETE FROM bid b WHERE b.login_id = '" + (String)session.getAttribute("user") + "';");
        
        st3.executeUpdate("DELETE FROM item i WHERE i.login_id = '" + (String)session.getAttribute("user") + "';");
        
        st4.executeUpdate("DELETE FROM summary_sales_report s WHERE s.login_id = '" + (String)session.getAttribute("user") + "';");
        
        st5.executeUpdate("DELETE FROM end_user u WHERE u.login_id = '" + (String)session.getAttribute("user") + "';");
        
        st6.executeUpdate("DELETE FROM users u WHERE u.login_id = '" + (String)session.getAttribute("user") + "';");
        
        response.sendRedirect("successDelete.jsp");   
                
        //Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
        con.close();
    }
    catch(Exception e){
        e.printStackTrace();
        out.println("Unable to delete the user account.");
    }
    %>
</body>
</html>