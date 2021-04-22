package service;

import persistence.model.Sales;
import persistence.model.bid.Bid;
import persistence.model.item.Item;
import persistence.model.report.EarningPerBuyer;
import persistence.model.report.EarningPerItem;
import persistence.model.report.SalesReport;
import persistence.model.user.EndUser;
import persistence.model.user.User;
import persistence.repository.SalesReportRepository;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class SalesReportService {
    private final BidService bidService = new BidService();
    private final UserService userService = new UserService();
    private final SalesService salesService = new SalesService();
    private final SalesReportRepository salesReportRepository = new SalesReportRepository();

    public List<SalesReport> findAllReports(){
        try {
            return salesReportRepository.getSalesReports();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    // Find a sales report given the sales report id.
    public Optional<SalesReport> findSalesReportById(int salesReportId){
        List<SalesReport> salesReports = findAllReports();
        return salesReports.stream()
                .filter(it -> it.getSalesReportId() == salesReportId)
                .findFirst();
    }

    // Generate the latest sales report.
    private  SalesReport _generateSalesReport() {
        List<Sales> sales = salesService.findSales();
        List<Item> soldItems = sales.stream()
                .map(Sales::getItem)
                .collect(Collectors.toList());

        SalesReport report = new SalesReport();
        report.setSalesReportId(0);
        report.setEarningsPerItem(getEarningsPerItem(soldItems));
        report.setEarningsPerBuyer(getEarningsPerBuyer(soldItems));
        report.setGeneratedDate(new Date());
        return report;
    }

    // Generate the latest sales report and add it to the database.
    public void generateSalesReport(){
        SalesReport salesReport = _generateSalesReport();
        try {
            salesReportRepository.addSalesReport(salesReport);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    // Get the earnings per item fot he sold items.
    private List<EarningPerItem> getEarningsPerItem(List<Item> soldItems){
        return soldItems.stream()
                .map(this::getEarningPerItem)
                .collect(Collectors.toList());
    }

    // Get the earnings per buyer from the sold items.
    private List<EarningPerBuyer> getEarningsPerBuyer(List<Item> soldItems){
        List<EndUser> endUsers = userService.findAllEndUsers();
        List<EndUser> buyers = new ArrayList<>();
        for (EndUser endUser : endUsers) {
            if(userService.isBuyer(endUser)){
                buyers.add(endUser);
            }
        }
        return buyers.stream()
                .map(it ->  getEarningPerBuyer(it, soldItems))
                .collect(Collectors.toList());
    }

    // Get a single earning per buyer, given the buyer and the items sold.
    private EarningPerBuyer getEarningPerBuyer(User buyer, List<Item> soldItems){
        int totalEarnings = 0;
        for (Item soldItem : soldItems) {
            List<Bid> bidsPerItem = findBidsPerItem(soldItem);
            if(bidsPerItem.isEmpty()){
                continue;
            }

            Bid winningBid = bidsPerItem.get(0);
            if(winningBid.getUser().getLoginId().equals(buyer.getLoginId())){
                totalEarnings = totalEarnings + winningBid.getOffer();
            }
        }

        EarningPerBuyer earningPerBuyer = new EarningPerBuyer();
        earningPerBuyer.setEarning(totalEarnings);
        earningPerBuyer.setFullName(buyer.getFullName());
        return earningPerBuyer;
    }

    // Get the earning per item for the given item
    private EarningPerItem getEarningPerItem(Item item){
        List<Bid> bidsPerItem = findBidsPerItem(item);
        EarningPerItem earningPerItem = new EarningPerItem();

        if(bidsPerItem.isEmpty()){
            earningPerItem.setEarning(0);
        } else {
            Bid winningBid = bidsPerItem.get(0);
            earningPerItem.setEarning(winningBid.getOffer());
        }

        earningPerItem.setItemBrand(item.getBrand());
        earningPerItem.setItemCategory(item.getCategory());
        earningPerItem.setItemName(item.getItemType());

        return earningPerItem;
    }


    // Find the bids for the given item.
    private List<Bid> findBidsPerItem(Item item){
        List<Bid> allBids = bidService.findAllBids();

        return allBids.stream()
                .filter(it -> it.getItem().getItemId() == item.getItemId())
                .sorted((bid1, bid2) -> Integer.compare(bid2.getOffer(), bid1.getOffer()))
                .collect(Collectors.toList());
    }
}
