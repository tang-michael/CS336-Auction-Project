package persistence.model.item;

/**
 * Class to represent a camera.
 */
public class Camera extends Item {
    public Camera(Item item){
        super(item);
    }

    public String getCategory(){
        return "Camera";
    }
}
