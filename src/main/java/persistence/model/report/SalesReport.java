package persistence.model.report;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Class to represent a single sales report.
 */
public class SalesReport {
    private int salesReportId;
    private  List<EarningPerItem> earningsPerItem;
    private List<EarningPerBuyer> earningsPerBuyer;
    private Date generatedDate;

    public SalesReport(){
        earningsPerItem = new ArrayList<>();
    }

    // Compute the total earnings from the sold items.
    public double getTotalEarningsFromItems(){
        return earningsPerItem.stream()
                .mapToInt(EarningPerItem::getEarning)
                .sum();

    }

    // Get the best buyer.
    public BestBuyer getBestBuyer(){
        // get the earnings for each buyer.
        List<EarningPerBuyer> earningsPerBuyerCopy = new ArrayList<>(this.earningsPerBuyer);

        // sort the earnings in descending order.
        earningsPerBuyerCopy.sort((e1, e2) -> Integer.compare(e2.getEarning(), e1.getEarning()));

        // if no earnings per buyer are found, then return null. Not possible to get the best buyer.
        if(earningsPerBuyerCopy.isEmpty()){
            return null;
        }

        // get the highest earning per buyer.
        EarningPerBuyer highestEarning = earningsPerBuyerCopy.get(0);

        // create a best buyer object from the highest earning object above.
        BestBuyer bestBuyer = new BestBuyer();
        bestBuyer.setFullName(highestEarning.getFullName());
        bestBuyer.setTotalEarnings(highestEarning.getEarning());

        // return the best buyer.
        return bestBuyer;
    }

    // Return the earnings per item type.
    public List<EarningPerItemType> getEarningsPerItemType(){
        // create the map to store the earnings for each item type.
        Map<String, Integer> earningsPerItemTypeMap = new HashMap<>();

        // Store in the map, the total earning for each item type.
        for (EarningPerItem earningPerItem : earningsPerItem) {

            if(!earningsPerItemTypeMap.containsKey(earningPerItem.getItemName())){
                earningsPerItemTypeMap.put(earningPerItem.getItemName(), earningPerItem.getEarning());
            } else {
                int previousEarning = earningsPerItemTypeMap.get(earningPerItem.getItemName());
                int newEarning = previousEarning + earningPerItem.getEarning();
                earningsPerItemTypeMap.put(earningPerItem.getItemName(), newEarning);
            }
        }

        // extract from the map the total earning for each item types and store them in a list.
        List<EarningPerItemType> earningsPerItemType = new ArrayList<>();
        for (String itemName : earningsPerItemTypeMap.keySet()) {
            EarningPerItemType earningPerItemType = new EarningPerItemType();
            earningPerItemType.setEarning(earningsPerItemTypeMap.get(itemName));
            earningPerItemType.setItemType(itemName);
            earningsPerItemType.add(earningPerItemType);
        }

        // return the list of earnings per item type to the caller.
        return earningsPerItemType;
    }

    public int getSalesReportId() {
        return salesReportId;
    }

    public void setSalesReportId(int salesReportId) {
        this.salesReportId = salesReportId;
    }

    public List<EarningPerItem> getEarningsPerItem() {
        return earningsPerItem;
    }

    public void setEarningsPerItem(List<EarningPerItem> earningsPerItem) {
        this.earningsPerItem = earningsPerItem;
    }


    public List<EarningPerBuyer> getEarningsPerBuyer() {
        return earningsPerBuyer;
    }

    public void setEarningsPerBuyer(List<EarningPerBuyer> earningsPerBuyer) {
        this.earningsPerBuyer = earningsPerBuyer;
    }


    // Get the best selling item.
    public BestSellingItem getBestSellingItem() {
        // if there are not earnings per item, then no best selling item can be found.
        if(this.earningsPerItem.isEmpty()){
            return null;
        }

        // Store the frequency of items sold in a map. The key is the item type
        // and the value is the how many times the item was sold.
        Map<String, Integer> itemTypeCountMap = new HashMap<>();
        for (EarningPerItem earningPerItem : earningsPerItem) {

            if(!itemTypeCountMap.containsKey(earningPerItem.getItemName())){
                itemTypeCountMap.put(earningPerItem.getItemName(), 1);
            } else {
                int previousCount = itemTypeCountMap.get(earningPerItem.getItemName());
                itemTypeCountMap.put(earningPerItem.getItemName(), previousCount + 1);
            }
        }

        // Loop through the map looking for the item that was most sold.
        String bestSellingItemName = null;
        int highestCount = 0;
        for (String itemName : itemTypeCountMap.keySet()) {
            int currentCount = itemTypeCountMap.get(itemName);
            if(currentCount > highestCount){
                bestSellingItemName = itemName;
                highestCount = currentCount;
            }
        }

        // no such item found, so return null.
        if(bestSellingItemName == null){
            return null;
        }


        // Create the best selling item object, and fill in the item name and
        // the number of times it was sold.
        BestSellingItem bestSellingItem = new BestSellingItem();
        bestSellingItem.setCategory(bestSellingItemName);
        bestSellingItem.setCount(highestCount);

        // return the best selling item.
        return bestSellingItem;
    }


    public Date getGeneratedDate() {
        return generatedDate;
    }

    // Return the generated date in a given format.
    public String getGeneratedDateFormatted(){
        DateFormat dateTimeFormat = new SimpleDateFormat("MMM dd, yyyy");
        return dateTimeFormat.format(this.generatedDate);
    }

    public void setGeneratedDate(Date generatedDate) {
        this.generatedDate = generatedDate;
    }
}
