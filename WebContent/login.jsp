<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="project.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
    <%
    try{
        
        //Get the database connection
        ApplicationDB db = new ApplicationDB(); 
        Connection con = db.getConnection();
        
        //Create a SQL statement
        Statement st = con.createStatement();
        
        String userid = request.getParameter("usr");
        session.putValue("usr",userid);
        String password = request.getParameter("password");
    
        ResultSet rs = st.executeQuery("SELECT * FROM users where login_id = " + "'" + userid + "'" +  " and pwd = " + "'" + password + "'");
    
        rs.next();
        
        if(rs.getString("pwd").equals(password) && rs.getString("login_id").equals(userid)){
            out.println("Welcome " +userid);
        }
        
        //Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
        con.close();
        
    }
    catch (Exception e) {
        out.println("Invalid password or username.");
    }
    
    
%>
</body>
</html>