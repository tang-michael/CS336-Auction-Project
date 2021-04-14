<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="project.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Register</title>
    </head>
    <body>
    <%
    try{
        //Get the database connection
        ApplicationDB db = new ApplicationDB(); 
        Connection con = db.getConnection();
    
        //Create a SQL statement
        Statement st = con.createStatement();
        
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String userID = request.getParameter("userid");
        String password = request.getParameter("password");
        
        String query = "INSERT INTO users values (" + "'" + fname + "'," + "'" + lname + "',"  + "'" + userID +"'" + "," + " '" + password + "');";
        System.out.println(query);
        st.executeUpdate(query);
       
        out.println("Thank you for register ! Please <a href='index.jsp'>Login</a> to continue.");
      }   
      catch(Exception e){
          out.println("Unable to create the new user.");
      }
        
    %>
    </body>
</html>