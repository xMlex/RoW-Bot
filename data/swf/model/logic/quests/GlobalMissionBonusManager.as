package model.logic.quests {
import model.data.UserPrize;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.TroopsTypeId;
import model.data.users.troops.Troops;
import model.logic.BlackMarketTroopsType;
import model.logic.StaticDataManager;
import model.logic.quests.completions.GlobalMissionCurrentState;
import model.logic.quests.completions.QuestCompletion;
import model.logic.quests.data.Quest;
import model.logic.quests.data.QuestState;
import model.logic.quests.data.SelectableBonusSlot;
import model.logic.quests.data.VirtualBonuses;

public class GlobalMissionBonusManager {


    public function GlobalMissionBonusManager() {
        super();
    }

    public static function getCurrentBonus(param1:Quest, param2:QuestState):Array {
        if (param2.completions == null || param2.completions.length == 0) {
            return null;
        }
        var _loc3_:GlobalMissionCurrentState = (param2.completions[0] as QuestCompletion).globalMission;
        if (_loc3_ == null) {
            return null;
        }
        var _loc4_:Number = _loc3_.userBonus;
        if (_loc4_ == 0) {
            return null;
        }
        var _loc5_:Array = param1.selectableBonuses;
        var _loc6_:Array = getSelectableBonuses(_loc5_, _loc4_);
        return _loc6_;
    }

    public static function getVirtualBonuses(param1:Quest, param2:QuestState):Array {
        var _loc7_:SelectableBonusSlot = null;
        var _loc8_:Array = null;
        var _loc9_:UserPrize = null;
        var _loc10_:Number = NaN;
        var _loc11_:VirtualBonuses = null;
        var _loc12_:UserPrize = null;
        var _loc13_:int = 0;
        var _loc14_:* = undefined;
        var _loc3_:Array = [];
        if (param2.completions == null || param2.completions.length == 0) {
            return null;
        }
        var _loc4_:GlobalMissionCurrentState = (param2.completions[0] as QuestCompletion).globalMission;
        if (_loc4_ == null) {
            return null;
        }
        var _loc5_:Number = _loc4_.userBonus;
        var _loc6_:Array = param1.selectableBonuses;
        for each(_loc7_ in _loc6_) {
            if (_loc7_.isDynamic) {
                _loc8_ = [];
                for each(_loc9_ in _loc7_.bonuses) {
                    _loc10_ = getNearestCollectedCount(_loc9_, _loc5_);
                    if (_loc10_ - _loc5_ > 0) {
                        _loc11_ = new VirtualBonuses();
                        _loc12_ = _loc9_.clone();
                        if (_loc12_.troops != null && _loc12_.troops.capacity() > 0) {
                            for (_loc14_ in _loc9_.troops.countByType) {
                                if (_loc14_ == TroopsTypeId.StrategyUnit1 || _loc14_ == TroopsTypeId.StrategyUnit2 || _loc14_ == TroopsTypeId.StrategyUnit3 || _loc14_ == TroopsTypeId.StrategyUnit4 || _loc14_ == TroopsTypeId.StrategyUnit5 || _loc14_ == TroopsTypeId.StrategyUnit6 || _loc14_ == TroopsTypeId.StrategyUnit7 || _loc14_ == TroopsTypeId.StrategyUnit8 || _loc14_ == TroopsTypeId.StrategyUnit9 || _loc14_ == TroopsTypeId.StrategyUnit10 || _loc14_ == TroopsTypeId.StrategyUnit11) {
                                    delete _loc12_.troops.countByType[_loc14_];
                                }
                            }
                        }
                        _loc13_ = UserPrize.createBonusCalc(_loc9_).getPlusBonus(_loc5_);
                        _loc11_.nearestBonus = _loc12_.scaleByCount(_loc13_);
                        if (!_loc7_.skipStrategyUnitsCalc && _loc11_.nearestBonus.troops != null && _loc11_.nearestBonus.troops.capacity() > 0) {
                            addStrategyTroopsIfNeeded(_loc11_.nearestBonus.troops);
                        }
                        _loc11_.diffToNearestBonus = _loc10_ - _loc5_;
                        _loc8_.push(_loc11_);
                    }
                }
                if (_loc8_.length > 0) {
                    _loc3_.push(_loc8_);
                }
            }
        }
        return _loc3_;
    }

    private static function getNearestCollectedCount(param1:UserPrize, param2:int):int {
        return UserPrize.createBonusCalc(param1).getNextItems(param2);
    }

    private static function getSelectableBonuses(param1:Array, param2:int):Array {
        var _loc4_:SelectableBonusSlot = null;
        var _loc5_:SelectableBonusSlot = null;
        var _loc6_:UserPrize = null;
        var _loc7_:UserPrize = null;
        var _loc8_:UserPrize = null;
        var _loc9_:* = undefined;
        var _loc3_:Array = new Array();
        for each(_loc4_ in param1) {
            _loc5_ = new SelectableBonusSlot();
            _loc5_.bonuses = [];
            if (_loc4_.isDynamic) {
                for each(_loc6_ in _loc4_.bonuses) {
                    _loc7_ = _loc6_.clone();
                    if (_loc7_.troops != null && _loc7_.troops.capacity() > 0) {
                        for (_loc9_ in _loc6_.troops.countByType) {
                            if (_loc9_ == TroopsTypeId.StrategyUnit1 || _loc9_ == TroopsTypeId.StrategyUnit2 || _loc9_ == TroopsTypeId.StrategyUnit3 || _loc9_ == TroopsTypeId.StrategyUnit4 || _loc9_ == TroopsTypeId.StrategyUnit5 || _loc9_ == TroopsTypeId.StrategyUnit6 || _loc9_ == TroopsTypeId.StrategyUnit7 || _loc9_ == TroopsTypeId.StrategyUnit8 || _loc9_ == TroopsTypeId.StrategyUnit9 || _loc9_ == TroopsTypeId.StrategyUnit10 || _loc9_ == TroopsTypeId.StrategyUnit11) {
                                delete _loc7_.troops.countByType[_loc9_];
                            }
                        }
                    }
                    _loc8_ = _loc7_.scaleMinMax(param2);
                    if (!_loc4_.skipStrategyUnitsCalc && _loc6_.troops != null && _loc6_.troops.capacity() > 0) {
                        addStrategyTroopsIfNeeded(_loc8_.troops);
                    }
                    if (!_loc8_.isEmpty()) {
                        _loc5_.bonuses.push(_loc8_);
                    }
                }
            }
            if (_loc5_.bonuses.length > 0) {
                _loc3_.push(_loc5_);
            }
        }
        return _loc3_;
    }

    private static function addStrategyTroopsIfNeeded(param1:Troops):void {
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        var _loc5_:GeoSceneObjectType = null;
        var _loc6_:GeoSceneObjectType = null;
        var _loc7_:* = undefined;
        var _loc8_:Boolean = false;
        var _loc9_:GeoSceneObjectType = null;
        var _loc10_:int = 0;
        var _loc11_:BlackMarketTroopsType = null;
        if (param1 == null) {
            return;
        }
        var _loc2_:Array = [];
        for (_loc3_ in param1.countByType) {
            for each(_loc6_ in StaticDataManager.types) {
                if (_loc6_.troopsInfo != null && _loc6_.troopsInfo.supportParameters != null && _loc6_.troopsInfo.supportParameters.supports(_loc3_)) {
                    _loc5_ = _loc6_;
                    break;
                }
            }
            if (_loc5_ != null) {
                _loc7_ = {
                    "troopsTypeId": _loc3_,
                    "count": param1.countByType[_loc3_],
                    "strategyTroopType": _loc5_
                };
                _loc2_.push(_loc7_);
            }
        }
        for each(_loc4_ in _loc2_) {
            if (_loc4_.strategyTroopType != null) {
                _loc8_ = false;
                if (StaticDataManager.blackMarketData.troopTypes != null) {
                    for each(_loc11_ in StaticDataManager.blackMarketData.troopTypes) {
                        if (_loc11_.troopsTypeId == (_loc4_.strategyTroopType as GeoSceneObjectType).id) {
                            _loc8_ = true;
                        }
                    }
                }
                if (_loc8_) {
                    _loc9_ = _loc4_.strategyTroopType as GeoSceneObjectType;
                    _loc10_ = _loc4_.count / _loc9_.troopsInfo.supportParameters.capacity;
                    if (_loc10_ > 0) {
                        param1.addTroops2((_loc4_.strategyTroopType as GeoSceneObjectType).id, _loc10_);
                    }
                }
            }
        }
    }
}
}
