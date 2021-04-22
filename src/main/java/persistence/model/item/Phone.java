package persistence.model.item;

/**
 * Class to represent a phone.
 */
public class Phone extends Item {
    public Phone(Item item){
        super(item);
    }

    public String getCategory(){
        return "Phone";
    }
}
