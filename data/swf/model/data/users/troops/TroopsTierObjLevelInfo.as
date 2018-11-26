package model.data.users.troops {
import common.IEquatable;

import gameObjects.observableObject.ObservableObject;

import model.data.scenes.objects.info.ConstructionObjInfo;
import model.data.scenes.types.info.TroopsTier;
import model.data.scenes.types.info.TroopsTierTypeLevelInfo;
import model.logic.StaticDataManager;
import model.logic.UserManager;

public class TroopsTierObjLevelInfo extends ObservableObject implements IEquatable {

    public static const CLASS_NAME:String = "TroopsTierObjLevelInfo";

    public static const STATUS_UPDATED:String = CLASS_NAME + "StatusUpdated";


    public var constructionInfo:ConstructionObjInfo;

    public var attackBonus:int;

    public var defenceBonus:int;

    public var speedBonus:int;

    public var capacityBonus:int;

    public var unAppliedPoints:int;

    public var dirty:Boolean;

    public function TroopsTierObjLevelInfo() {
        super();
    }

    public static function fromDto(param1:*):TroopsTierObjLevelInfo {
        var _loc2_:TroopsTierObjLevelInfo = empty();
        _loc2_.constructionInfo = param1.c != null ? ConstructionObjInfo.fromDto(param1.c) : null;
        _loc2_.attackBonus = param1.a;
        _loc2_.defenceBonus = param1.d;
        _loc2_.speedBonus = param1.s;
        _loc2_.capacityBonus = param1.p;
        _loc2_.unAppliedPoints = param1.u;
        return _loc2_;
    }

    public static function empty():TroopsTierObjLevelInfo {
        return new TroopsTierObjLevelInfo();
    }

    public function get inProgress():Boolean {
        return this.constructionInfo != null && this.constructionInfo.constructionStartTime != null;
    }

    public function getProgressPercentage():Number {
        return this.constructionInfo.progressPercentage;
    }

    public function dispatchEvents():void {
        if (!this.dirty) {
            return;
        }
        this.dirty = false;
        dispatchEvent(STATUS_UPDATED);
    }

    public function hasAnyBonuses():Boolean {
        return this.attackBonus != 0 || this.defenceBonus != 0 || this.speedBonus != 0 || this.capacityBonus != 0;
    }

    public function isLowerOrEqualLevel(param1:int):Boolean {
        return this.constructionInfo == null || this.constructionInfo.level <= param1;
    }

    public function finishUpgrade():void {
        this.constructionInfo.level++;
        this.constructionInfo.constructionFinishTime = null;
        this.constructionInfo.constructionStartTime = null;
    }

    public function normalizeResourcesAfterUpgrade(param1:int):void {
        var _loc2_:TroopsTier = null;
        var _loc3_:TroopsTierTypeLevelInfo = null;
        _loc2_ = StaticDataManager.troopsTiersData.getTierById(param1);
        _loc3_ = _loc2_.getLevelInfo(this.constructionInfo.level - 1);
        this.unAppliedPoints = this.unAppliedPoints + _loc3_.upgradePoints;
        UserManager.user.gameData.troopsData.subtractExp(param1, _loc3_.battleExperienceRequired);
    }

    public function update(param1:TroopsTierObjLevelInfo):void {
        this.attackBonus = param1.attackBonus;
        this.defenceBonus = param1.defenceBonus;
        this.speedBonus = param1.speedBonus;
        this.capacityBonus = param1.capacityBonus;
        this.unAppliedPoints = param1.unAppliedPoints;
        if (param1.constructionInfo != null) {
            if (this.constructionInfo == null) {
                this.constructionInfo = new ConstructionObjInfo();
            }
            this.constructionInfo.level = param1.constructionInfo.level;
            this.constructionInfo.constructionStartTime = param1.constructionInfo.constructionStartTime;
            this.constructionInfo.constructionFinishTime = param1.constructionInfo.constructionFinishTime;
        }
    }

    public function isEqual(param1:*):Boolean {
        var _loc2_:TroopsTierObjLevelInfo = param1 as TroopsTierObjLevelInfo;
        if (_loc2_ == null) {
            return false;
        }
        return this.attackBonus == _loc2_.attackBonus && this.defenceBonus == _loc2_.defenceBonus && this.speedBonus == _loc2_.speedBonus && this.capacityBonus == _loc2_.capacityBonus && this.unAppliedPoints == _loc2_.unAppliedPoints && (this.constructionInfo == null && _loc2_.constructionInfo == null || this.constructionInfo != null && this.constructionInfo.isEqual(_loc2_.constructionInfo));
    }
}
}
