<%@ page import="service.SalesReportService" %>
<%@ page import="persistence.model.report.SalesReport" %>
<%@ page import="java.util.Optional" %>
<%@ page import="persistence.model.report.EarningPerItem" %>
<%@ page import="persistence.model.report.EarningPerItemType" %>
<%@ page import="persistence.model.report.EarningPerBuyer" %>
<%
    String salesReportId = request.getParameter("salesReportId");
    int parsedSalesReportId;
    try {
        parsedSalesReportId = Integer.parseInt(salesReportId);
    } catch (Exception e){
        parsedSalesReportId = -1;
    }

    SalesReportService salesReportService = new SalesReportService();
    Optional<SalesReport> salesReportOptional = salesReportService.findSalesReportById(parsedSalesReportId);
    if(salesReportOptional.isEmpty()){
        response.sendRedirect("index.jsp?error=No such report.");
        return;
    }

    SalesReport currentSalesReport = salesReportOptional.get();
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
            <a href="reps.jsp">View Representatives</a>
            <a href="create_rep.jsp">Add Representative</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>

    <div class="container" style="margin-bottom: 3rem;">
        <div style="display: flex; justify-content: space-between;">
            <h2>Report: <%= currentSalesReport.getSalesReportId() %></h2>
            <h2><%= currentSalesReport.getGeneratedDateFormatted() %></h2>
        </div>
        <div>
            <table>
                <thead>
                    <tr>
                        <th>Total Earnings</th>
                        <td>$ <%= currentSalesReport.getTotalEarningsFromItems() %></td>
                    </tr>
                </thead>
            </table>

            <table>
                <thead>
                    <tr>
                        <th colspan="4">Total Earnings Per Item</th>
                    </tr>
                    <tr>
                        <th>Item Name</th>
                        <th>Item Category</th>
                        <th>Item Brand</th>
                        <th>Earning</th>
                    </tr>

                    <% if(currentSalesReport.getEarningsPerItem().isEmpty()) { %>
                        <tr>
                            <td colspan="6">No earnings per item found</td>
                        </tr>
                    <% } %>

                    <% for (EarningPerItem earningPerItem : currentSalesReport.getEarningsPerItem()) { %>
                        <tr>
                            <td><%= earningPerItem.getItemName()%></td>
                            <td><%= earningPerItem.getItemCategory()%></td>
                            <td><%= earningPerItem.getItemBrand()%></td>
                            <td style="color: green;">$ <%=earningPerItem.getEarning()%></td>
                        </tr>
                    <% } %>
            </table>

            <table>
                    <tr>
                        <th colspan="3">Earnings Per Item Type</th>
                    </tr>
                    <tr>
                        <th>Item Category</th>
                        <th>Earning</th>
                    </tr>
                <% if(currentSalesReport.getEarningsPerItemType().isEmpty()) {%>
                <tr>
                    <td colspan="2">No earnings per item found.</td>
                </tr>
                <% } %>

                <% for (EarningPerItemType earningPerItemType : currentSalesReport.getEarningsPerItemType()) { %>
                    <tr>
                        <td><%= earningPerItemType.getItemType()%></td>
                        <td style="color: green;">$<%= earningPerItemType.getEarning()%></td>
                    </tr>
                <% } %>
            </table>

             <table>
                <thead>
                    <tr>
                        <th colspan="2">Earnings Per Buyer</th>
                    </tr>
                    <tr>
                        <th>Full Name</th>
                        <th>Earning</th>
                    </tr>
                    <% if(currentSalesReport.getEarningsPerBuyer().isEmpty()) {%>
                        <tr>
                            <td colspan="5">No earnings per buyer found.</td>
                        </tr>
                    <% } %>

                    <% for (EarningPerBuyer earningPerBuyer : currentSalesReport.getEarningsPerBuyer()) {%>
                        <tr>
                            <td><%= earningPerBuyer.getFullName()%></td>
                            <td style="color: green;">$<%= earningPerBuyer.getEarning()%></td>
                        </tr>
                    <% } %>
            </table>

            <table>
                <thead>
                    <tr>
                        <th colspan="2">Best Selling Item</th>
                    </tr>
                    <tr>
                        <th>Item Category</th>
                        <th>Items Sold</th>
                    </tr>
                    <% if(currentSalesReport.getBestSellingItem() == null){ %>
                    <tr>
                        <td colspan="2">No best selling item found</td>
                    </tr>
                    <% } else {%>
                    <tr>
                        <td><%=currentSalesReport.getBestSellingItem().getCategory()%></td>
                        <td><%= currentSalesReport.getBestSellingItem().getCount()%></td>
                    </tr>
                    <% } %>
            </table>

            <table>
                <thead>
                    <tr>
                        <th colspan="2">Best Buyer</th>
                    </tr>
                    <tr>
                        <th>Full Name</th>
                        <th>Total Earning</th>
                    </tr>
                    <% if(currentSalesReport.getBestBuyer() == null) {%>
                    <tr>
                        <td colspan="2">No best buyer found.</td>
                    </tr>
                    <% } else { %>
                    <tr>
                        <td><%= currentSalesReport.getBestBuyer().getFullName()%></td>
                        <td style="color: green;">$<%= currentSalesReport.getBestBuyer().getTotalEarnings()%></td>
                    </tr>
                    <% } %>
            </table>
        </div>
    </div>
</body>

</html>