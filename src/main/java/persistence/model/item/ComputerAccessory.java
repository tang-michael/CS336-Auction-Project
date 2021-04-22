package persistence.model.item;

/**
 * Class to represent a computer accessory.
 */
public class ComputerAccessory extends Item {
    public ComputerAccessory(Item item){
        super(item);
    }

    public String getCategory(){
        return "Computer Accessory";
    }
}
