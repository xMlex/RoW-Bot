package model.data.effects {
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.effects.DependentEffectsBuilder;

public class EffectsManager {


    public function EffectsManager() {
        super();
    }

    public static function addEffect(param1:EffectItem):void {
        UserManager.user.gameData.effectData.addOrChangeEffect(param1);
        UserManager.user.gameData.effectData.dirty = true;
        UserManager.user.gameData.effectData.dispatchEvents();
    }

    public static function addEffects(param1:Array):void {
        var _loc2_:EffectItem = null;
        for each(_loc2_ in param1) {
            UserManager.user.gameData.effectData.addOrChangeEffect(_loc2_);
        }
        UserManager.user.gameData.effectData.dirty = true;
        UserManager.user.gameData.effectData.dispatchEvents();
    }

    public static function deleteEffects(param1:Array):void {
        UserManager.user.gameData.effectData.deleteEffects(param1);
        UserManager.user.gameData.effectData.dirty = true;
        UserManager.user.gameData.effectData.dispatchEvents();
    }

    public static function deleteDependentEffectsByItemTypeId(param1:int):void {
        var _loc3_:Array = null;
        var _loc2_:BlackMarketItemRaw = StaticDataManager.blackMarketData.itemsById[param1];
        if (_loc2_) {
            _loc3_ = DependentEffectsBuilder.getList(_loc2_.effectData.effectTypeId);
            if (_loc3_ != null) {
                UserManager.user.gameData.effectData.deleteEffectsByTypeId(_loc3_);
                UserManager.user.gameData.effectData.dirty = true;
                UserManager.user.gameData.effectData.dispatchEvents();
            }
        }
    }
}
}
