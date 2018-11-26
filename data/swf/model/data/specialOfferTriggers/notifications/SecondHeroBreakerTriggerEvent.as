package model.data.specialOfferTriggers.notifications {
import configs.Global;

import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.data.specialOfferTriggers.TriggerEventTypeEnum;
import model.logic.StaticConstructionData;
import model.logic.UserManager;
import model.logic.blackMarketModel.refreshableBehaviours.itemCounts.BlackMarketItemCount;
import model.logic.commands.triggers.TriggerClientEventDto;
import model.logic.inventory.InventoryManager;

public class SecondHeroBreakerTriggerEvent extends TriggerEvent {

    private static const NAME:String = "SecondHeroBreakerTriggerEvent";


    public function SecondHeroBreakerTriggerEvent() {
        super();
    }

    override public function get triggerEventDto():TriggerClientEventDto {
        var _loc1_:TriggerClientEventDto = new TriggerClientEventDto(TriggerEventTypeEnum.SECOND_HERO_BREAKER_TRIGGER_EVENT);
        _loc1_.w = StaticConstructionData.INVENTORY_DESTROYER_DEFAULT_COUNT;
        _loc1_.g = UserManager.user.gameData.inventoryData.dustAmount;
        return _loc1_;
    }

    override protected function verification():void {
        if (!Global.ADDITIONAL_INVENTORY_DESTROYER_ENABLED) {
            return;
        }
        var _loc1_:BlackMarketItemCount = new BlackMarketItemCount(BlackMarketItemsTypeId.AdditionalInventoryDestroyer1C7D);
        _loc1_.refresh();
        if (_loc1_.value > 0) {
            return;
        }
        var _loc2_:int = InventoryManager.instance.powderingItems.length;
        if (_loc2_ > 0) {
            respond(true);
        }
    }

    override protected function get className():String {
        return NAME;
    }
}
}
