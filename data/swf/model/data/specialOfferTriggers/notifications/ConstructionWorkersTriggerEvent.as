package model.data.specialOfferTriggers.notifications {
import model.data.specialOfferTriggers.TriggerEventTypeEnum;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.commands.triggers.TriggerClientEventDto;

public class ConstructionWorkersTriggerEvent extends TriggerEvent {

    private static const NAME:String = "ConstructionWorkersTriggerEvent";


    public function ConstructionWorkersTriggerEvent() {
        super();
    }

    override public function get triggerEventDto():TriggerClientEventDto {
        var _loc1_:TriggerClientEventDto = new TriggerClientEventDto(TriggerEventTypeEnum.OUT_OF_WORKERS);
        _loc1_.w = UserManager.user.gameData.constructionData.constructionWorkersCount;
        return _loc1_;
    }

    override protected function verification():void {
        var _loc1_:int = StaticDataManager.constructionData.getMaxWorkersCount();
        var _loc2_:int = UserManager.user.gameData.constructionData.constructionWorkersCount;
        respond(_loc2_ <= _loc1_);
    }

    override protected function get className():String {
        return NAME;
    }
}
}
