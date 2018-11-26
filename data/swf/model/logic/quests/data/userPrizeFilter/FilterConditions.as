package model.logic.quests.data.userPrizeFilter {
import common.ArrayCustom;
import common.DateUtil;
import common.queries.util.query;

import flash.utils.Dictionary;

import model.data.effects.EffectData;
import model.data.effects.EffectItem;
import model.data.effects.EffectTypeId;
import model.data.users.misc.UserBlackMarketData;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemsNode;

public class FilterConditions {


    public function FilterConditions() {
        super();
    }

    public static function hasBMI(param1:int):Boolean {
        var _loc2_:Boolean = false;
        var _loc3_:UserBlackMarketData = UserManager.user.gameData.blackMarketData;
        var _loc4_:Dictionary = _loc3_.boughtItems;
        var _loc5_:BlackMarketItemsNode = _loc4_[param1];
        if (_loc5_ && _loc5_.paidCount + _loc5_.freeCount > 0) {
            _loc2_ = true;
        }
        return _loc2_;
    }

    public static function isActiveAdditionalResearchers(param1:int):Boolean {
        var _loc2_:* = false;
        var _loc3_:ArrayCustom = UserManager.user.gameData.constructionData.additionalResearchersExpireDateTimes;
        var _loc4_:int = activeItemsCount(_loc3_);
        _loc2_ = _loc4_ > 0;
        return _loc2_;
    }

    public static function isActiveAdditionalInventoryDestroyers(param1:int):Boolean {
        var _loc2_:* = false;
        var _loc3_:ArrayCustom = UserManager.user.gameData.constructionData.additionalInventoryDestroyerExpireDateTimes;
        var _loc4_:int = activeItemsCount(_loc3_);
        _loc2_ = _loc4_ > 0;
        return _loc2_;
    }

    public static function isActiveEffectUserAttackAndDefense(param1:int):Boolean {
        var id:int = param1;
        var result:Boolean = false;
        var effectData:EffectData = UserManager.user.gameData.effectData;
        if (effectData != null) {
            result = query(effectData.effectsList).any(function (param1:EffectItem):Boolean {
                return param1.effectTypeId == EffectTypeId.UserAttackAndDefensePowerBonus && param1.activeState != null;
            });
        }
        return result;
    }

    public static function isWorkersLimit():Boolean {
        return UserManager.user.gameData.constructionData.constructionWorkersCount >= StaticDataManager.constructionData.getMaxWorkersCount();
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
