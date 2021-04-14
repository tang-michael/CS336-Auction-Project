<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="project.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
	<%
	//Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement st = con.createStatement();
	Statement st1 = con.createStatement();
	Statement st2 = con.createStatement();
	

	String userid = request.getParameter("usr");
	session.putValue("usr", userid);
	String password = request.getParameter("password");

	ResultSet rs = st.executeQuery("SELECT * FROM users");

	boolean exist = false;
	while (rs.next()) {

		if (rs.getString("login_id").equals(userid) && rs.getString("pwd").equals(password)) {
			exist = true;
			break;
		}

	}

	boolean isAdmin = false;

	ResultSet rsAdmin = st1.executeQuery("SELECT * FROM admins");
	

	while (rsAdmin.next()) {
		if (rsAdmin.getString("login_id").equals(userid)) {
			isAdmin = true;
		}
	}

	ResultSet rsCustomerRep = st1.executeQuery("SELECT * FROM customer_representatives");

	boolean isCustomerRep = false;

	while (rsCustomerRep.next()) {
		if (rsCustomerRep.getString("login_id").equals(userid)) {
			isCustomerRep = true;
		}
	}

	if (exist == false) {
		out.println("Invalid password");
		out.println("<p>Return to Login <a href ='index.jsp'>Login</a>.</p> ");
	} else if (exist == true && isAdmin == true) {
		out.println("Welcome " + userid);
		out.println("You are an admin!");
		out.println("<a href='logout.jsp'>Logout</a>");
	} else if (exist == true && isCustomerRep == true) {
		out.println("Welcome " + userid);
		out.println("You are a customer rep!");
		out.println("<a href='logout.jsp'>Logout</a>");
	} else if (exist == true) {
		response.sendRedirect("user.jsp?name=" + userid);
	
	}

	//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
	con.close();
	%>
</body>
</html>