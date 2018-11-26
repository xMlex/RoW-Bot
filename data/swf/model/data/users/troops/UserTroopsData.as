package model.data.users.troops {
import gameObjects.observableObject.ObservableObject;

public class UserTroopsData extends ObservableObject {

    public static const TIER_DATA_CHANGED:String = "tier_data_changed";

    public static const TIERS_UPGRADED:String = "tiers_upgraded";


    public var troops:Troops;

    public var troopsFactory:TroopsFactory;

    public var missileStorage:Troops;

    public var battleExperienceByTroopsTierId:Object;

    public var tiersLevelInfoByTierId:Object;

    public var tierDataDirty:Boolean;

    public var upgradeTierDirty:Boolean;

    public function UserTroopsData() {
        super();
    }

    public static function fromDto(param1:*):UserTroopsData {
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        var _loc2_:UserTroopsData = new UserTroopsData();
        _loc2_.troops = Troops.fromDto(param1.r);
        _loc2_.troopsFactory = TroopsFactory.fromDto(param1.f);
        _loc2_.missileStorage = param1.m == null ? new Troops() : Troops.fromDto(param1.m);
        if (param1.x != null) {
            _loc2_.battleExperienceByTroopsTierId = {};
            for (_loc3_ in param1.x) {
                _loc2_.battleExperienceByTroopsTierId[_loc3_] = param1.x[_loc3_];
            }
        }
        if (param1.v != null) {
            _loc2_.tiersLevelInfoByTierId = {};
            for (_loc4_ in param1.v) {
                _loc2_.tiersLevelInfoByTierId[_loc4_] = TroopsTierObjLevelInfo.fromDto(param1.v[_loc4_]);
            }
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        this.troopsFactory.dispatchEvents();
        this.troops.dispatchEvents();
        this.missileStorage.dispatchEvents();
        this.dispatchTierDataChanged();
    }

    public function dispatchTierDataChanged():void {
        var _loc1_:TroopsTierObjLevelInfo = null;
        if (this.tierDataDirty) {
            this.tierDataDirty = false;
            dispatchEvent(TIER_DATA_CHANGED);
        }
        if (this.upgradeTierDirty) {
            this.upgradeTierDirty = false;
            dispatchEvent(TIERS_UPGRADED);
        }
        for each(_loc1_ in this.tiersLevelInfoByTierId) {
            _loc1_.dispatchEvents();
        }
    }

    public function updateTier(param1:int, param2:TroopsTierObjLevelInfo):void {
        this.updateOneTierLevelInfo(param1, param2);
        this.tierDataDirty = true;
        this.dispatchTierDataChanged();
    }

    public function updateTiers(param1:UserTroopsData):void {
        this.battleExperienceByTroopsTierId = param1.battleExperienceByTroopsTierId;
        this.updateTierObjLevelInfos(param1);
        this.tierDataDirty = true;
        this.dispatchTierDataChanged();
    }

    public function subtractExp(param1:int, param2:Number):void {
        if (param2 < this.battleExperienceByTroopsTierId[param1]) {
            this.battleExperienceByTroopsTierId[param1] = this.battleExperienceByTroopsTierId[param1] - param2;
        }
        else {
            this.battleExperienceByTroopsTierId[param1] = 0;
        }
        this.tierDataDirty = true;
    }

    public function hasUpgradingTiers():Boolean {
        var _loc1_:TroopsTierObjLevelInfo = null;
        var _loc2_:* = null;
        if (this.tiersLevelInfoByTierId == null) {
            return false;
        }
        for (_loc2_ in this.tiersLevelInfoByTierId) {
            _loc1_ = this.tiersLevelInfoByTierId[_loc2_];
            if (_loc1_.inProgress) {
                return true;
            }
        }
        return false;
    }

    public function getTroopsTierLevelInfoByTierId(param1:int):TroopsTierObjLevelInfo {
        var _loc2_:TroopsTierObjLevelInfo = this.tiersLevelInfoByTierId != null && this.tiersLevelInfoByTierId[param1] != null ? this.tiersLevelInfoByTierId[param1] : TroopsTierObjLevelInfo.empty();
        return _loc2_;
    }

    private function updateTierObjLevelInfos(param1:UserTroopsData):void {
        var _loc2_:* = null;
        var _loc3_:TroopsTierObjLevelInfo = null;
        for (_loc2_ in param1.tiersLevelInfoByTierId) {
            _loc3_ = param1.tiersLevelInfoByTierId[_loc2_];
            this.updateOneTierLevelInfo(int(_loc2_), _loc3_);
        }
        for (_loc2_ in this.tiersLevelInfoByTierId) {
            if (param1.tiersLevelInfoByTierId[_loc2_] == undefined) {
                delete this.tiersLevelInfoByTierId[_loc2_];
            }
        }
    }

    private function updateOneTierLevelInfo(param1:int, param2:TroopsTierObjLevelInfo):void {
        if (this.tiersLevelInfoByTierId == null) {
            this.tiersLevelInfoByTierId = {};
        }
        var _loc3_:TroopsTierObjLevelInfo = this.tiersLevelInfoByTierId[param1];
        if (_loc3_ == null) {
            this.tiersLevelInfoByTierId[param1] = param2;
        }
        else if (!_loc3_.isEqual(param2)) {
            _loc3_.update(param2);
            _loc3_.dirty = true;
        }
    }
}
}
