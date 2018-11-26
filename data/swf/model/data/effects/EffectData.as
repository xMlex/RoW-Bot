package model.data.effects {
import common.ArrayCustom;
import common.queries.util.query;

import configs.Global;

import flash.utils.Dictionary;

import gameObjects.observableObject.ObservableObject;

import model.data.Resources;
import model.data.User;
import model.data.normalization.INEvent;
import model.data.normalization.INormalizable;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.TroopsGroupId;
import model.data.users.acceleration.NEventEffectsFinished;
import model.data.users.acceleration.NEventPeriodicEffectAction;
import model.logic.StaticDataManager;
import model.logic.UserManager;

public class EffectData extends ObservableObject implements INormalizable {

    public static const CLASS_NAME:String = "EffectData";

    public static const EFFECT_DATA_CHANGED:String = CLASS_NAME + "Changed";

    public static const SOURCE_MODEL_ENABLED:Boolean = Global.EFFECT_SOURCE_MODEL_ENABLED;


    public var dirty:Boolean;

    public var effectsList:ArrayCustom;

    public function EffectData() {
        super();
    }

    public static function fromDto(param1:*):EffectData {
        var _loc2_:EffectData = new EffectData();
        if (param1 == null) {
            _loc2_.effectsList = new ArrayCustom();
        }
        else {
            _loc2_.effectsList = EffectItem.fromDtos(param1.s);
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            if (hasEventHandler(EFFECT_DATA_CHANGED)) {
                dispatchEvent(EFFECT_DATA_CHANGED);
            }
        }
    }

    public function getLightEffectsList():ArrayCustom {
        var _loc2_:EffectItem = null;
        var _loc1_:ArrayCustom = new ArrayCustom();
        for each(_loc2_ in this.effectsList) {
            if (_loc2_.activeState != null) {
                _loc1_.push(_loc2_.toLightEffect());
            }
        }
        return _loc1_;
    }

    public function getEffect(param1:int, param2:Number, param3:Number):EffectItem {
        var _loc4_:EffectItem = null;
        var _loc5_:EffectItem = null;
        for each(_loc5_ in this.effectsList) {
            if (_loc5_.effectTypeId == param1 && _loc5_.ownerUserId == param2 && _loc5_.targetUserId == param3) {
                _loc4_ = _loc5_;
                break;
            }
        }
        return _loc4_;
    }

    public function getEffectWithSource(param1:int, param2:Number, param3:Number, param4:int, param5:int):EffectItem {
        var _loc6_:EffectItem = null;
        var _loc7_:EffectItem = null;
        for each(_loc7_ in this.effectsList) {
            if (_loc7_.effectTypeId == param1 && _loc7_.ownerUserId == param2 && _loc7_.targetUserId == param3 && _loc7_.source & param4 && (param5 == 0 || _loc7_.sourceItemId == param5)) {
                _loc6_ = _loc7_;
                break;
            }
        }
        return _loc6_;
    }

    public function getFirstActiveEffect(param1:int):EffectItem {
        var typeId:int = param1;
        var result:EffectItem = query(this.effectsList).firstOrDefault(function (param1:EffectItem):Boolean {
            return param1.effectTypeId == typeId && param1.activeState != null;
        });
        return result;
    }

    public function getFirstActiveEffectBySource(param1:int, param2:int, param3:int = 0):EffectItem {
        var typeId:int = param1;
        var effectSource:int = param2;
        var sourceItemId:int = param3;
        var result:EffectItem = query(this.effectsList).firstOrDefault(function (param1:EffectItem):Boolean {
            return param1.effectTypeId == typeId && param1.source == effectSource && param1.activeState != null && (sourceItemId == 0 || param1.sourceItemId == sourceItemId);
        });
        return result;
    }

    public function isActiveEffect(param1:int):Boolean {
        var userId:Number = NaN;
        var typeId:int = param1;
        userId = UserManager.user.id;
        return query(this.effectsList).any(function (param1:EffectItem):Boolean {
            return param1.effectTypeId == typeId && param1.targetUserId == userId && param1.activeState != null;
        });
    }

    public function isActiveEffectBySource(param1:int, param2:int, param3:int = 0):Boolean {
        var userId:Number = NaN;
        var typeId:int = param1;
        var effectSource:int = param2;
        var sourceItemId:int = param3;
        userId = UserManager.user.id;
        return query(this.effectsList).any(function (param1:EffectItem):Boolean {
            return param1.effectTypeId == typeId && param1.targetUserId == userId && param1.source == effectSource && param1.activeState != null && (sourceItemId == 0 || param1.sourceItemId == sourceItemId);
        });
    }

    public function getEffectByTypeId(param1:int):EffectItem {
        var _loc3_:EffectItem = null;
        var _loc2_:Number = UserManager.user.id;
        for each(_loc3_ in this.effectsList) {
            if (_loc3_.effectTypeId == param1 && _loc3_.targetUserId == _loc2_) {
                return _loc3_;
            }
        }
        return null;
    }

    public function getEffectsByTypeId(param1:int):Array {
        var _loc2_:Array = null;
        var _loc4_:EffectItem = null;
        var _loc3_:Number = UserManager.user.id;
        for each(_loc4_ in this.effectsList) {
            if (_loc4_.effectTypeId == param1 && _loc4_.targetUserId == _loc3_) {
                if (_loc2_ == null) {
                    _loc2_ = [];
                }
                _loc2_.push(_loc4_);
            }
        }
        return _loc2_;
    }

    public function getResourceMiningBoost():Resources {
        var _loc3_:EffectItem = null;
        var _loc1_:Resources = new Resources();
        var _loc2_:int = 0;
        while (_loc2_ < this.effectsList.length) {
            _loc3_ = this.effectsList[_loc2_];
            if (_loc3_.activeState) {
                switch (_loc3_.effectTypeId) {
                    case EffectTypeId.DragonMoneyProduction:
                        _loc1_.money = _loc1_.money + _loc3_.activeState.power / 100;
                        break;
                    case EffectTypeId.DragonUraniumProduction:
                        _loc1_.uranium = _loc1_.uranium + _loc3_.activeState.power / 100;
                        break;
                    case EffectTypeId.DragonTitaniteProduction:
                        _loc1_.titanite = _loc1_.titanite + _loc3_.activeState.power / 100;
                        break;
                    case EffectTypeId.AllResourcesProductionAcceleration:
                        _loc1_.money = _loc1_.money + _loc3_.activeState.power / 100;
                        _loc1_.uranium = _loc1_.uranium + _loc3_.activeState.power / 100;
                        _loc1_.titanite = _loc1_.titanite + _loc3_.activeState.power / 100;
                }
            }
            _loc2_++;
        }
        return _loc1_;
    }

    public function getBuildingAcceleration():Number {
        var _loc3_:EffectItem = null;
        var _loc1_:Number = 0;
        var _loc2_:int = 0;
        while (_loc2_ < this.effectsList.length) {
            _loc3_ = this.effectsList[_loc2_];
            if (_loc3_.activeState) {
                switch (_loc3_.effectTypeId) {
                    case EffectTypeId.DragonConstructionAcceleration:
                        _loc1_ = _loc1_ + _loc3_.activeState.power;
                }
            }
            _loc2_++;
        }
        return _loc1_;
    }

    public function getResearchAcceleration():Number {
        var _loc3_:EffectItem = null;
        var _loc1_:Number = 0;
        var _loc2_:int = 0;
        while (_loc2_ < this.effectsList.length) {
            _loc3_ = this.effectsList[_loc2_];
            if (_loc3_.activeState) {
                switch (_loc3_.effectTypeId) {
                    case EffectTypeId.DragonResearchAcceleration:
                        _loc1_ = _loc1_ + _loc3_.activeState.power;
                }
            }
            _loc2_++;
        }
        return _loc1_;
    }

    public function getTroopsAcceleration():Dictionary {
        var result:Dictionary = null;
        var item:EffectItem = null;
        var groupId:int = 0;
        var groupId2:int = 0;
        var allTroops:Boolean = false;
        result = new Dictionary();
        var i:int = 0;
        while (i < this.effectsList.length) {
            item = this.effectsList[i];
            if (item.activeState) {
                groupId = -1;
                groupId2 = -1;
                allTroops = false;
                switch (item.effectTypeId) {
                    case EffectTypeId.DragonInfantryTrainingBoost:
                        groupId = TroopsGroupId.INFANTRY;
                        groupId2 = TroopsGroupId.INFANTRY_2;
                        break;
                    case EffectTypeId.DragonArmoredTrainingBoost:
                        groupId = TroopsGroupId.ARMOURED;
                        groupId2 = TroopsGroupId.ARMOURED_2;
                        break;
                    case EffectTypeId.DragonArtilleryTrainingBoost:
                        groupId = TroopsGroupId.ARTILLERY;
                        groupId2 = TroopsGroupId.ARTILLERY_2;
                        break;
                    case EffectTypeId.DragonAirTrainingBoost:
                        groupId = TroopsGroupId.AEROSPACE;
                        groupId2 = TroopsGroupId.AEROSPACE_2;
                        break;
                    case EffectTypeId.AllTroopsTrainingSpeed:
                        allTroops = true;
                }
                if (groupId != -1 || allTroops) {
                    StaticDataManager.forEachElementTypes(function (param1:GeoSceneObjectType):Boolean {
                        return param1.troopsInfo && (param1.troopsInfo.groupId == groupId || param1.troopsInfo.groupId == groupId2 || allTroops);
                    }, function (param1:GeoSceneObjectType):void {
                        if (result[param1.id] == null) {
                            result[param1.id] = 0;
                        }
                        result[param1.id] = result[param1.id] + item.activeState.power;
                    });
                }
            }
            i++;
        }
        return result;
    }

    public function getSectorDefenceBonus():Number {
        if (SOURCE_MODEL_ENABLED) {
            return this.getBonusFromSource(EffectTypeId.SectorDefensePowerBonus, EffectSource.Dragon);
        }
        return this.getBonus(EffectTypeId.DragonSectorDefenceBonus);
    }

    public function getSectorDefenceGlobalBonus():Number {
        if (SOURCE_MODEL_ENABLED) {
            return this.getBonusFromSource(EffectTypeId.SectorDefensePowerBonus, EffectSource.BlackMarketItem);
        }
        return this.getBonus(EffectTypeId.SectorDefensePowerBonus);
    }

    public function getBioplasmConversionAcceleration():Number {
        var _loc3_:EffectItem = null;
        var _loc1_:Number = 0;
        var _loc2_:int = 0;
        while (_loc2_ < this.effectsList.length) {
            _loc3_ = this.effectsList[_loc2_];
            if (_loc3_.activeState) {
                switch (_loc3_.effectTypeId) {
                    case EffectTypeId.DragonBiochipConversionSpeed:
                        _loc1_ = _loc1_ + _loc3_.activeState.power;
                }
            }
            _loc2_++;
        }
        return _loc1_;
    }

    public function getDragonAbilitiesResearchAcceleration():Number {
        return this.getBonus(EffectTypeId.DragonAbilitiesResearchAcceleration);
    }

    public function getDragonHitRefreshTimeAcceleration():Number {
        return this.getBonus(EffectTypeId.DragonHitRefreshTime);
    }

    public function getDragonOffencePowerBoost():Number {
        if (SOURCE_MODEL_ENABLED) {
            return this.getOffencePowerBoostFromSource(EffectSource.Dragon);
        }
        return this.getBonus(EffectTypeId.DragonOffencePowerBoost);
    }

    public function getOffencePowerBoostByItems():Number {
        var _loc1_:Number = NaN;
        var _loc2_:int = 0;
        var _loc3_:EffectItem = null;
        if (SOURCE_MODEL_ENABLED) {
            return this.getOffencePowerBoostFromSource(EffectSource.BlackMarketItem);
        }
        _loc1_ = 0;
        _loc2_ = 0;
        while (_loc2_ < this.effectsList.length) {
            _loc3_ = this.effectsList[_loc2_];
            if (_loc3_.activeState) {
                switch (_loc3_.effectTypeId) {
                    case EffectTypeId.UserAttackAndDefensePowerBonus:
                        _loc1_ = _loc1_ + _loc3_.activeState.power;
                        break;
                    case EffectTypeId.UserAttackPower:
                        _loc1_ = _loc1_ + _loc3_.activeState.power;
                }
            }
            _loc2_++;
        }
        return _loc1_;
    }

    public function getDragonDefencePowerBoost():Number {
        if (SOURCE_MODEL_ENABLED) {
            return this.getDefencePowerBoostFromSource(EffectSource.Dragon);
        }
        return this.getBonus(EffectTypeId.DragonDefensePowerBoost);
    }

    public function getDefencePowerBoostByItems():Number {
        var _loc1_:Number = NaN;
        var _loc2_:int = 0;
        var _loc3_:EffectItem = null;
        if (SOURCE_MODEL_ENABLED) {
            return this.getDefencePowerBoostFromSource(EffectSource.BlackMarketItem);
        }
        _loc1_ = 0;
        _loc2_ = 0;
        while (_loc2_ < this.effectsList.length) {
            _loc3_ = this.effectsList[_loc2_];
            if (_loc3_.activeState) {
                switch (_loc3_.effectTypeId) {
                    case EffectTypeId.UserAttackAndDefensePowerBonus:
                        _loc1_ = _loc1_ + _loc3_.activeState.power;
                        break;
                    case EffectTypeId.UserDefensePower:
                        _loc1_ = _loc1_ + _loc3_.activeState.power;
                }
            }
            _loc2_++;
        }
        return _loc1_;
    }

    public function getOffencePowerBoostFromSource(param1:int):Number {
        var _loc4_:EffectItem = null;
        var _loc2_:Number = 0;
        var _loc3_:int = 0;
        while (_loc3_ < this.effectsList.length) {
            _loc4_ = this.effectsList[_loc3_];
            if (_loc4_.activeState) {
                if (_loc4_.source & param1 && (_loc4_.effectTypeId == EffectTypeId.UserAttackPower || _loc4_.effectTypeId == EffectTypeId.UserAttackAndDefensePowerBonus)) {
                    _loc2_ = _loc2_ + _loc4_.activeState.power;
                }
            }
            _loc3_++;
        }
        return _loc2_;
    }

    public function getDefencePowerBoostFromSource(param1:int):Number {
        var _loc4_:EffectItem = null;
        var _loc2_:Number = 0;
        var _loc3_:int = 0;
        while (_loc3_ < this.effectsList.length) {
            _loc4_ = this.effectsList[_loc3_];
            if (_loc4_.activeState) {
                if (_loc4_.source & param1 && (_loc4_.effectTypeId == EffectTypeId.UserDefensePower || _loc4_.effectTypeId == EffectTypeId.UserAttackAndDefensePowerBonus)) {
                    _loc2_ = _loc2_ + _loc4_.activeState.power;
                }
            }
            _loc3_++;
        }
        return _loc2_;
    }

    public function getTroopsSpeedAcceleration():Number {
        return this.getBonus(EffectTypeId.TroopsSpeedBoost);
    }

    public function getItemPowderingAcceleration():Number {
        return this.getBonus(EffectTypeId.ItemsPowderingAcceleration);
    }

    public function getItemsDustBonus():Number {
        return this.getBonus(EffectTypeId.ItemsDustBonus);
    }

    public function getCaravanSpeedBonus():Number {
        return this.getBonus(EffectTypeId.CaravanSpeedBonus);
    }

    public function getResourcesAccelerationFromSource(param1:int):Number {
        return this.getBonusFromSource(EffectTypeId.AllResourcesProductionAcceleration, param1);
    }

    private function getBonus(param1:int):Number {
        var _loc4_:EffectItem = null;
        var _loc2_:Number = 0;
        var _loc3_:int = 0;
        while (_loc3_ < this.effectsList.length) {
            _loc4_ = this.effectsList[_loc3_];
            if (_loc4_.activeState) {
                if (_loc4_.effectTypeId == param1) {
                    _loc2_ = _loc2_ + _loc4_.activeState.power;
                }
            }
            _loc3_++;
        }
        return _loc2_;
    }

    private function getBonusFromSource(param1:int, param2:int):Number {
        var _loc5_:EffectItem = null;
        var _loc3_:Number = 0;
        var _loc4_:int = 0;
        while (_loc4_ < this.effectsList.length) {
            _loc5_ = this.effectsList[_loc4_];
            if (_loc5_.activeState) {
                if (_loc5_.effectTypeId == param1 && _loc5_.source & param2) {
                    _loc3_ = _loc3_ + _loc5_.activeState.power;
                }
            }
            _loc4_++;
        }
        return _loc3_;
    }

    public function getNearestActiveEffect(param1:int, param2:int):EffectItem {
        var _loc3_:EffectItem = null;
        var _loc4_:Date = null;
        var _loc6_:EffectItem = null;
        var _loc5_:int = 0;
        while (_loc5_ < this.effectsList.length) {
            _loc6_ = this.effectsList[_loc5_];
            if (_loc6_.activeState != null) {
                if (_loc6_.effectTypeId == param1 && _loc6_.source & param2 && (_loc4_ == null || _loc6_.activeState.until.getTime() < _loc4_.getTime())) {
                    _loc4_ = _loc6_.activeState.until;
                    _loc3_ = _loc6_;
                }
            }
            _loc5_++;
        }
        return _loc3_;
    }

    public function removeOldActiveState(param1:Date):void {
        var _loc2_:EffectItem = null;
        var _loc3_:int = this.effectsList.length - 1;
        while (_loc3_ >= 0) {
            _loc2_ = this.effectsList[_loc3_];
            if (_loc2_.activeState && _loc2_.activeState.until.getTime() <= param1.getTime()) {
                if (_loc2_.ownerUserId == UserManager.user.id) {
                    _loc2_.finishedState = _loc2_.activeState;
                }
                _loc2_.activeState = null;
                if (_loc2_.nextState == null && _loc2_.finishedState == null) {
                    this.effectsList.removeItemAt(_loc3_);
                }
            }
            _loc3_--;
        }
    }

    public function removeFinishedState():void {
        var _loc1_:EffectItem = null;
        var _loc2_:int = this.effectsList.length - 1;
        while (_loc2_ >= 0) {
            _loc1_ = this.effectsList[_loc2_];
            if (_loc1_.finishedState) {
                _loc1_.finishedState = null;
                if (_loc1_.nextState == null && _loc1_.activeState == null) {
                    this.effectsList.removeItemAt(_loc2_);
                }
            }
            _loc2_--;
        }
    }

    public function checkFinishedItem():Boolean {
        var _loc3_:EffectItem = null;
        var _loc1_:Boolean = false;
        var _loc2_:int = this.effectsList.length - 1;
        while (_loc2_ >= 0) {
            _loc3_ = this.effectsList[_loc2_];
            if (_loc3_.finishedState) {
                _loc1_ = true;
                break;
            }
            _loc2_--;
        }
        return _loc1_;
    }

    public function getNextFinishedTime():Date {
        var _loc1_:EffectItem = null;
        var _loc2_:Date = null;
        if (this.effectsList.length == 0) {
            return null;
        }
        var _loc3_:int = 0;
        while (_loc3_ < this.effectsList.length) {
            _loc1_ = this.effectsList[_loc3_];
            if (_loc1_.activeState && (_loc2_ == null || _loc1_.activeState.until.getTime() < _loc2_.getTime())) {
                _loc2_ = _loc1_.activeState.until;
            }
            _loc3_++;
        }
        return _loc2_;
    }

    public function addOrChangeEffect(param1:EffectItem):void {
        var _loc2_:EffectItem = null;
        if (SOURCE_MODEL_ENABLED) {
            _loc2_ = this.getEffectWithSource(param1.effectTypeId, param1.ownerUserId, param1.targetUserId, param1.source, param1.sourceItemId);
        }
        else {
            _loc2_ = this.getEffect(param1.effectTypeId, param1.ownerUserId, param1.targetUserId);
        }
        if (_loc2_ == null) {
            _loc2_ = param1;
            this.effectsList.addItem(_loc2_);
        }
        else {
            this.changeEffect(param1);
        }
    }

    public function changeEffect(param1:EffectItem):void {
        var _loc2_:EffectItem = null;
        var _loc3_:int = 0;
        while (_loc3_ < this.effectsList.length) {
            _loc2_ = this.effectsList[_loc3_];
            if (_loc2_.effectTypeId == param1.effectTypeId && _loc2_.ownerUserId == param1.ownerUserId && _loc2_.targetUserId == param1.targetUserId && _loc2_.sourceItemId == param1.sourceItemId) {
                this.effectsList.removeItemAt(_loc3_);
                this.effectsList.addItem(param1);
                break;
            }
            _loc3_++;
        }
    }

    public function deleteEffects(param1:Array):void {
        var _loc2_:int = 0;
        while (_loc2_ < param1.length) {
            this.deleteEffect(param1[_loc2_]);
            _loc2_++;
        }
    }

    public function deleteEffect(param1:EffectItem):void {
        var _loc2_:EffectItem = null;
        var _loc3_:int = this.effectsList.length - 1;
        while (_loc3_ >= 0) {
            _loc2_ = this.effectsList[_loc3_];
            if (_loc2_.effectTypeId == param1.effectTypeId && _loc2_.ownerUserId == param1.ownerUserId && _loc2_.targetUserId == param1.targetUserId) {
                this.effectsList.removeItemAt(_loc3_);
                break;
            }
            _loc3_--;
        }
    }

    public function deleteEffectsByTypeId(param1:Array):void {
        var _loc2_:int = 0;
        while (_loc2_ < param1.length) {
            this.deleteEffectByTypeId(param1[_loc2_]);
            _loc2_++;
        }
    }

    public function deleteEffectByTypeId(param1:int):void {
        var _loc2_:EffectItem = null;
        var _loc3_:int = this.effectsList.length - 1;
        while (_loc3_ >= 0) {
            _loc2_ = this.effectsList[_loc3_];
            if (_loc2_.effectTypeId == param1) {
                this.effectsList.removeItemAt(_loc3_);
                break;
            }
            _loc3_--;
        }
    }

    public function decrementEffectUseCount(param1:int, param2:int):void {
        var _loc3_:EffectItem = this.getFirstActiveEffectBySource(param1, param2);
        if (_loc3_ == null) {
            return;
        }
        if (_loc3_.activeState.usageCount <= 0) {
            return;
        }
        _loc3_.activeState.usageCount--;
        if (_loc3_.source & EffectSource.GiftPointsProgram) {
            UserManager.user.gameData.giftPointsProgramData.refreshAvailableBonuses();
        }
    }

    public function getFirstEffectReadyToAct(param1:Date):EffectItem {
        var _loc2_:EffectItem = null;
        var _loc3_:EffectItem = null;
        if (this.effectsList.length == 0) {
            return null;
        }
        var _loc4_:Date = param1;
        var _loc5_:int = 0;
        while (_loc5_ < this.effectsList.length) {
            _loc2_ = this.effectsList[_loc5_];
            if (_loc2_.activeState != null && _loc2_.activeState.periodicEffectActionState != null && _loc2_.activeState.periodicEffectActionState.nextActionTime != null && _loc2_.activeState.periodicEffectActionState.nextActionTime.getTime() <= _loc4_.getTime() && _loc2_.activeState.periodicEffectActionState.nextActionTime.getTime() <= _loc2_.activeState.until.getTime()) {
                _loc4_ = _loc2_.activeState.periodicEffectActionState.nextActionTime;
                _loc3_ = _loc2_;
            }
            _loc5_++;
        }
        return _loc3_;
    }

    public function getNextEvent(param1:User, param2:Date):INEvent {
        var _loc3_:Date = this.getNextFinishedTime();
        var _loc4_:EffectItem = this.getFirstEffectReadyToAct(param2);
        if (_loc4_ != null && _loc3_ != null) {
            if (_loc3_.getTime() < _loc4_.activeState.periodicEffectActionState.nextActionTime.getTime()) {
                return new NEventEffectsFinished(_loc3_);
            }
            return new NEventPeriodicEffectAction(_loc4_.activeState.periodicEffectActionState.nextActionTime, _loc4_);
        }
        if (_loc4_ != null) {
            return new NEventPeriodicEffectAction(_loc4_.activeState.periodicEffectActionState.nextActionTime, _loc4_);
        }
        return _loc3_ == null ? null : new NEventEffectsFinished(_loc3_);
    }
}
}
