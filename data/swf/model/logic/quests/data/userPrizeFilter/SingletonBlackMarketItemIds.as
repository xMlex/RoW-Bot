package model.logic.quests.data.userPrizeFilter {
import common.ArrayCustom;
import common.DateUtil;
import common.queries.util.query;

import flash.utils.Dictionary;

import model.data.effects.EffectData;
import model.data.effects.EffectItem;
import model.data.effects.EffectTypeId;
import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.logic.ServerTimeManager;
import model.logic.UserManager;

public class SingletonBlackMarketItemIds {

    private static var _limitedItemsHardCode:Dictionary = new Dictionary();

    {
        _limitedItemsHardCode[BlackMarketItemsTypeId.AdditionalResearcher1C7D] = isActiveAdditionalResearchers;
        _limitedItemsHardCode[BlackMarketItemsTypeId.AdditionalInventoryDestroyer1C7D] = isActiveAdditionalInventoryDestroyers;
        _limitedItemsHardCode[BlackMarketItemsTypeId.EffectUserAttackAndDefensePowerBonus50P7D] = isActiveEffectUserAttackAndDefense;
    }

    public function SingletonBlackMarketItemIds() {
        super();
    }

    public static function isHardCodeLimit(param1:int):Boolean {
        return _limitedItemsHardCode[param1] != null;
    }

    public static function isActiveHardCodeItem(param1:int):Boolean {
        var _loc2_:Boolean = false;
        var _loc3_:Function = _limitedItemsHardCode[param1];
        if (_loc3_ != null) {
            _loc2_ = _loc3_();
        }
        return _loc2_;
    }

    private static function isActiveAdditionalResearchers():Boolean {
        var _loc1_:* = false;
        var _loc2_:ArrayCustom = UserManager.user.gameData.constructionData.additionalResearchersExpireDateTimes;
        var _loc3_:int = activeItemsCount(_loc2_);
        _loc1_ = _loc3_ > 0;
        return _loc1_;
    }

    private static function isActiveAdditionalInventoryDestroyers():Boolean {
        var _loc1_:* = false;
        var _loc2_:ArrayCustom = UserManager.user.gameData.constructionData.additionalInventoryDestroyerExpireDateTimes;
        var _loc3_:int = activeItemsCount(_loc2_);
        _loc1_ = _loc3_ > 0;
        return _loc1_;
    }

    public static function isActiveEffectUserAttackAndDefense():Boolean {
        return isActiveEffectByItemId(EffectTypeId.UserAttackAndDefensePowerBonus);
    }

    private static function isActiveEffectByItemId(param1:int):Boolean {
        var id:int = param1;
        var result:Boolean = false;
        var effectData:EffectData = UserManager.user.gameData.effectData;
        if (effectData != null) {
            result = query(effectData.effectsList).any(function (param1:EffectItem):Boolean {
                return param1.effectTypeId == id && param1.activeState != null;
            });
        }
        return result;
    }

    private static function activeItemsCount(param1:ArrayCustom):int {
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc2_:int = 0;
        if (param1 != null) {
            _loc3_ = param1.length;
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                if (DateUtil.compare(ServerTimeManager.serverTimeNow, param1[_loc4_]) == DateUtil.FIRST_BEFORE) {
                    _loc2_++;
                }
                _loc4_++;
            }
        }
        return _loc2_;
    }
}
}
