<%@ page import="service.UserService" %>
<%@ page import="persistence.model.user.CustomerRepresentative" %>
<%@ page import="java.util.List" %><%
    UserService userService = new UserService();
    List<CustomerRepresentative> customerRepresentativeList = userService.findAllCustomerRepresentatives();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Auction - Cust Reps</title>
    <link href="../css/core.css" rel="stylesheet" />
</head>
<body>
    <div class="navbar">
        <h2 class="navbar-brand">Online Auction System | Admin</h2>
        <div class="nav-links right-nav-links">
            <a href="index.jsp">Reports</a>
            <a class="active-link" href="reps.jsp">View Representatives</a>
            <a href="create_rep.jsp">Add Representative</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h2>Current Customer Representatives</h2>
        <table>
            <thead>
                <tr>
                    <th>No. </th>
                    <th>User ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Hire Date</th>
                </tr>
            </thead>
            <tbody>
              <% for (int i = 0; i < customerRepresentativeList.size(); i++) { %>
                  <tr>
                      <td><%= i + 1 %></td>
                      <td><%= customerRepresentativeList.get(i).getLoginId() %></td>
                      <td><%= customerRepresentativeList.get(i).getFname() %></td>
                      <td><%= customerRepresentativeList.get(i).getLname() %></td>
                      <td><%= customerRepresentativeList.get(i).getHireDateFormatted() %></td>
                  </tr>
            <% } %>

              <% if(customerRepresentativeList.isEmpty()) {%>
                  <tr>
                    <td colspan="5">
                        No customer representatives are present at the moment.
                    </td>

                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>