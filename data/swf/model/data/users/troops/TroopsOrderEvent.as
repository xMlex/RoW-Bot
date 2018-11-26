package model.data.users.troops {
import gameObjects.observableObject.ObservableObject;
import gameObjects.observableObject.ObservableObjectEvent;

public class TroopsOrderEvent extends ObservableObjectEvent {


    public var troopsOrderId:int;

    public function TroopsOrderEvent(param1:String, param2:ObservableObject, param3:int) {
        super(param1, param2);
        this.troopsOrderId = param3;
    }
}
}
