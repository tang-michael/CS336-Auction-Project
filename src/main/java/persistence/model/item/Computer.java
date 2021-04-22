package persistence.model.item;

/**
 * Class to represent an item.
 */
public class Computer extends Item {
    public Computer(Item item){
        super(item);
    }

    public String getCategory(){
        return "Computer";
    }
}
