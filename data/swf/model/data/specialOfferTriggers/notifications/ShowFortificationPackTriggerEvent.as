package model.data.specialOfferTriggers.notifications {
import model.data.specialOfferTriggers.TriggerEventTypeEnum;
import model.logic.commands.triggers.TriggerClientEventDto;

public class ShowFortificationPackTriggerEvent extends TriggerEvent {

    private static const NAME:String = "ShowDefensivePackTriggerEvent";


    public function ShowFortificationPackTriggerEvent() {
        super();
    }

    override public function get triggerEventDto():TriggerClientEventDto {
        return new TriggerClientEventDto(TriggerEventTypeEnum.SHOW_FORTIFICATION_PACK);
    }

    override protected function get className():String {
        return NAME;
    }
}
}
