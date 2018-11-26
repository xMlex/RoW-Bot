package model.data.specialOfferTriggers.notifications {
import model.data.acceleration.types.BoostTypeId;
import model.data.specialOfferTriggers.TriggerEventTypeEnum;
import model.logic.UserManager;
import model.logic.commands.triggers.TriggerClientEventDto;

public class BoostTechnologyTriggerEvent extends TriggerEvent {

    private static const NAME:String = "BoostTechnologyTriggerEvent";


    private var _boostId:int;

    private var _triggerEventType:int;

    public function BoostTechnologyTriggerEvent(param1:int) {
        super();
        this._boostId = param1;
    }

    override public function get triggerEventDto():TriggerClientEventDto {
        return new TriggerClientEventDto(this._triggerEventType);
    }

    override protected function verification():void {
        this._triggerEventType = TriggerEventTypeEnum.BOOST_RESEARCH;
        var _loc1_:* = UserManager.user.gameData.technologyCenter.technologiesResearching > 1;
        respond(_loc1_ && this._boostId == BoostTypeId.INSTANT_TECHNOLOGY || this._boostId == BoostTypeId.DRAGON_ABILITY);
    }

    override protected function get className():String {
        return NAME;
    }
}
}
