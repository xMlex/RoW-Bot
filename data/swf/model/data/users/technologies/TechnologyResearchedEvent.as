package model.data.users.technologies {
import gameObjects.observableObject.ObservableObject;
import gameObjects.observableObject.ObservableObjectEvent;

public class TechnologyResearchedEvent extends ObservableObjectEvent {


    public var technologyTypeId:int;

    public function TechnologyResearchedEvent(param1:String, param2:ObservableObject, param3:int) {
        super(param1, param2);
        this.technologyTypeId = param3;
    }
}
}
