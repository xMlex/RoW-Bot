package model.data.specialOfferTriggers.notifications {
import model.data.specialOfferTriggers.TriggerEventTypeEnum;
import model.logic.commands.triggers.TriggerClientEventDto;

public class SkillTreeOpenedTriggerEvent extends TriggerEvent {

    private static const NAME:String = "SkillTreeOpenedTriggerEvent";


    public function SkillTreeOpenedTriggerEvent() {
        super();
    }

    override public function get triggerEventDto():TriggerClientEventDto {
        return new TriggerClientEventDto(TriggerEventTypeEnum.SKILL_TREE_OPENED);
    }

    override protected function get className():String {
        return NAME;
    }
}
}
