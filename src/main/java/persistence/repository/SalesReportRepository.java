package persistence.repository;

import persistence.model.report.EarningPerBuyer;
import persistence.model.report.EarningPerItem;
import persistence.model.report.SalesReport;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Class that manipulates the "sales_report" table.
 */
public class SalesReportRepository extends Repository {

    // Add a new sales report to the database.
    public void addSalesReport(SalesReport salesReport) throws SQLException {
        String query = "INSERT INTO `sales_reports`(`sales_report_id`, `earnings_per_item`, `earnings_per_buyer`, `generated_date`)" +
                "VALUES (?, ?, ?, ?)";

        PreparedStatement statement = dbConnection.prepareStatement(query);

        statement.setInt(1, 0);
        statement.setString(2, earningsPerItemToString(salesReport.getEarningsPerItem()));
        statement.setString(3, earningsPerBuyerToString(salesReport.getEarningsPerBuyer()));
        statement.setDate(4, new java.sql.Date(salesReport.getGeneratedDate().getTime()));

        statement.execute();
        statement.close();
    }

    // Convert a list of earnings per item to a string, so that it can be stored in the database
    private String earningsPerItemToString(List<EarningPerItem> earningsPerItem){
        return earningsPerItem.stream()
                .map(it -> it.getItemName() + "," +
                        it.getItemBrand() + "," +
                        it.getItemCategory() + "," +
                        it.getEarning())
                .collect(Collectors.joining("\n"));
    }

    // Convert the earnings per buyer to a strng that can be stored in the database.
    private String earningsPerBuyerToString(List<EarningPerBuyer> earningsPerBuyer){
        return earningsPerBuyer.stream()
                .map(it -> it.getFullName() + "," + it.getEarning())
                .collect(Collectors.joining("\n"));
    }

    // Load all the sales reports from the database.
    public List<SalesReport> getSalesReports() throws SQLException {
        String query = "SELECT * FROM `sales_reports`";
        PreparedStatement statement = dbConnection.prepareStatement(query);
        ResultSet resultSet = statement.executeQuery();
        List<SalesReport> salesReports = new ArrayList<>();
        while (resultSet.next()){
            SalesReport salesReport = extractFromResultSet(resultSet);
            salesReports.add(salesReport);
        }

        resultSet.close();
        statement.close();

        return salesReports;
    }

    // Extract a sales report from a query resultset.
    private SalesReport extractFromResultSet(ResultSet resultSet) throws SQLException {
        Date date = resultSet.getDate("generated_date");

        String earningsPerBuyer = resultSet.getString("earnings_per_buyer");
        List<EarningPerBuyer> earningsPerBuyerList = stringToEarningsPerBuyer(earningsPerBuyer);


        String earningsPerItem = resultSet.getString("earnings_per_item");
        List<EarningPerItem> earningsPerItemList = stringToEarningPerItem(earningsPerItem);

        int salesReportId = resultSet.getInt("sales_report_id");

        SalesReport salesReport = new SalesReport();
        salesReport.setGeneratedDate(date);
        salesReport.setEarningsPerBuyer(earningsPerBuyerList);
        salesReport.setEarningsPerItem(earningsPerItemList);
        salesReport.setSalesReportId(salesReportId);

        return salesReport;
    }

    // Convert a well formed string to a list of earning per item list
    // that was stored in the database.
    private List<EarningPerItem> stringToEarningPerItem(String earningsPerItem){
        if(earningsPerItem == null || earningsPerItem.isEmpty()){
            return Collections.emptyList();
        }

        String[] parts = earningsPerItem.split("\n");
        return Arrays.stream(parts).map(part -> {
            String[] earningsPerItemSplit = part.split(",");

            String itemName = earningsPerItemSplit[0];
            String itemBrand = earningsPerItemSplit[1];
            String itemCategory = earningsPerItemSplit[2];
            int earning = Integer.parseInt(earningsPerItemSplit[3]);

            EarningPerItem earningPerItem = new EarningPerItem();
            earningPerItem.setItemName(itemName);
            earningPerItem.setItemBrand(itemBrand);
            earningPerItem.setItemCategory(itemCategory);
            earningPerItem.setEarning(earning);

            return earningPerItem;
        }).collect(Collectors.toList());
    }

    // Convert a well formed string to a list of earnings per buyer objects.
    private List<EarningPerBuyer> stringToEarningsPerBuyer(String earningsBerBuyer){
        if(earningsBerBuyer == null || earningsBerBuyer.isEmpty()){
            return Collections.emptyList();
        }


        String[] parts = earningsBerBuyer.split("\n");
        return Arrays.stream(parts).map(part -> {
            String[] earningPerBuyerParts = part.split(",");

            String fullName = earningPerBuyerParts[0];
            int earning = Integer.parseInt(earningPerBuyerParts[1]);

            EarningPerBuyer earningPerBuyer = new EarningPerBuyer();
            earningPerBuyer.setFullName(fullName);
            earningPerBuyer.setEarning(earning);

            return earningPerBuyer;
        }).collect(Collectors.toList());
    }
}
