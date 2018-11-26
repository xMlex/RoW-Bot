package model.logic.blackMarketModel.applyBehaviours.contexts {
import model.data.map.MapPos;

public class TeleportObjectApplyContext extends ApplyContext {


    public var userNoteId:int;

    public var newMapPos:MapPos;

    public var randomJump:Boolean;

    public var isUnlimited:Boolean = false;

    public function TeleportObjectApplyContext() {
        super();
    }
}
}
