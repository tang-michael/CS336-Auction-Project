<%@ page import="controller.AttributeKeys" %>
<%@ page import="service.SalesReportService" %>
<%@ page import="persistence.model.report.SalesReport" %>
<%@ page import="java.util.List" %>
<%
    SalesReportService salesReportService = new SalesReportService();
    List<SalesReport> salesReportList = salesReportService.findAllReports();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Auction - Sales Reports</title>
    <link href="../css/core.css" rel="stylesheet" />
</head>
<body>
    <div class="navbar">
        <h2 class="navbar-brand">Online Auction System | Admin</h2>
        <div class="nav-links right-nav-links">
            <a class="active-link" href="index.jsp">Reports</a>
            <a href="reps.jsp">View Representatives</a>
            <a href="create_rep.jsp">Add Representative</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>

    <%
        String error = request.getParameter(AttributeKeys.ERROR_REQUEST_PARAM);
        String info = request.getParameter(AttributeKeys.INFO_REQUEST_PARAM);
        if(error != null){
    %>
    <div class="alert alert-danger"><%= error %></div>
    <%
        }
        if(info != null){
    %>

    <div class="alert alert-info">
        <%= info %>
    </div>

    <%
        }
    %>

    <div class="container">
        <div style="display: flex; justify-content: space-between;">
            <h2>Reports</h2>
            <a style="text-decoration: none" href="${pageContext.request.contextPath}/admin/generate_report"
               class="btn btn-primary">Generate New Report</a>
        </div>
        <div>
            <table>
                <thead>
                    <tr>
                        <th>No. </th>
                        <th>Date Generated</th>
                        <th>View Report</th>
                    </tr>
                </thead>
                <tbody>
                    <% if(salesReportList.isEmpty()) {%>
                        <tr>
                            <td colspan="3">No reports found at the moment.</td>
                        </tr>
                    <% } %>


                    <% for (SalesReport salesReport : salesReportList) { %>
                        <tr>
                            <td><%= salesReport.getSalesReportId() %></td>
                            <td><%= salesReport.getGeneratedDateFormatted() %></td>
                            <td>
                                <a href="sales_report.jsp?salesReportId=<%= salesReport.getSalesReportId()%>">View</a>
                            </td>
                        </tr>
                    <% }%>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>