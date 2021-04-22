package persistence.model.bid;

/**
 * Enum to represent a bid status.
 */
public enum  BidStatus {
    LEGAL("Legal"), ILLEGAL("Illegal"), UNKNOWN ("Uknown");

    private final String description;

    BidStatus(String description){
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
