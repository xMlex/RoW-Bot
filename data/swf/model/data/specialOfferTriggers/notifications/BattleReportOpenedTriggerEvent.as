package model.data.specialOfferTriggers.notifications {
import model.data.specialOfferTriggers.TriggerEventTypeEnum;
import model.logic.commands.triggers.TriggerClientEventDto;

public class BattleReportOpenedTriggerEvent extends TriggerEvent {

    private static const NAME:String = "BattleReportOpenedTriggerEvent";


    public function BattleReportOpenedTriggerEvent() {
        super();
    }

    override public function get triggerEventDto():TriggerClientEventDto {
        return new TriggerClientEventDto(TriggerEventTypeEnum.BATTLE_REPORT_OPENED);
    }

    override protected function get className():String {
        return NAME;
    }
}
}
