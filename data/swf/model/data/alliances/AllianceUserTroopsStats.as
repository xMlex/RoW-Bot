package model.data.alliances {
import flash.utils.Dictionary;

public class AllianceUserTroopsStats {


    public var attackerPowerByGroup:Dictionary;

    public var defensivePowerByGroup:Dictionary;

    public var intelligencePowerByGroup:Dictionary;

    public var attackingIntelligencePowerByGroup:Dictionary;

    public function AllianceUserTroopsStats() {
        this.attackerPowerByGroup = new Dictionary();
        this.defensivePowerByGroup = new Dictionary();
        this.intelligencePowerByGroup = new Dictionary();
        this.attackingIntelligencePowerByGroup = new Dictionary();
        super();
    }

    public static function fromDto(param1:*):AllianceUserTroopsStats {
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        var _loc5_:* = undefined;
        var _loc6_:* = undefined;
        var _loc2_:AllianceUserTroopsStats = new AllianceUserTroopsStats();
        _loc2_.attackerPowerByGroup = new Dictionary();
        for (_loc3_ in param1.a) {
            _loc2_.attackerPowerByGroup[_loc3_] = TroopsStats.fromDto(param1.a[_loc3_], _loc3_);
        }
        _loc2_.defensivePowerByGroup = new Dictionary();
        for (_loc4_ in param1.d) {
            _loc2_.defensivePowerByGroup[_loc4_] = TroopsStats.fromDto(param1.d[_loc4_], _loc4_);
        }
        _loc2_.intelligencePowerByGroup = new Dictionary();
        for (_loc5_ in param1.i) {
            _loc2_.intelligencePowerByGroup[_loc5_] = TroopsStats.fromDto(param1.i[_loc5_], _loc5_);
        }
        _loc2_.attackingIntelligencePowerByGroup = new Dictionary();
        for (_loc6_ in param1.s) {
            _loc2_.attackingIntelligencePowerByGroup[_loc6_] = TroopsStats.fromDto(param1.s[_loc6_], _loc6_);
        }
        return _loc2_;
    }

    public function isEmpty():Boolean {
        return (this.attackerPowerByGroup == null || this.attackerPowerByGroup.length == 0) && (this.defensivePowerByGroup == null || this.defensivePowerByGroup.length == 0) && (this.intelligencePowerByGroup == null || this.intelligencePowerByGroup.length == 0) && (this.attackingIntelligencePowerByGroup == null || this.attackingIntelligencePowerByGroup.length == 0);
    }

    public function getAttackPower(param1:int = -1):Number {
        var _loc3_:* = undefined;
        var _loc2_:Number = 0;
        for (_loc3_ in this.attackerPowerByGroup) {
            if (_loc3_ == param1 || param1 == -1) {
                _loc2_ = _loc2_ + (this.attackerPowerByGroup[_loc3_] as TroopsStats).power;
            }
        }
        return _loc2_;
    }

    public function getDefencePower(param1:int = -1):int {
        var _loc3_:* = undefined;
        var _loc2_:int = 0;
        for (_loc3_ in this.defensivePowerByGroup) {
            if (_loc3_ == param1 || param1 == -1) {
                _loc2_ = _loc2_ + (this.defensivePowerByGroup[_loc3_] as TroopsStats).power;
            }
        }
        return _loc2_;
    }

    public function getIntelligencePower(param1:int = -1):int {
        var _loc2_:* = undefined;
        var _loc3_:int = 0;
        for (_loc2_ in this.intelligencePowerByGroup) {
            if (_loc2_ == param1 || param1 == -1 || param1 == -3) {
                _loc3_ = _loc3_ + (this.intelligencePowerByGroup[_loc2_] as TroopsStats).power;
            }
        }
        for (_loc2_ in this.attackingIntelligencePowerByGroup) {
            if (_loc2_ == param1 || param1 == -1 || param1 == -2) {
                _loc3_ = _loc3_ + (this.attackingIntelligencePowerByGroup[_loc2_] as TroopsStats).power;
            }
        }
        return _loc3_;
    }

    public function getAttackCount(param1:int = -1):int {
        var _loc3_:* = undefined;
        var _loc2_:int = 0;
        for (_loc3_ in this.attackerPowerByGroup) {
            if (_loc3_ == param1 || param1 == -1) {
                _loc2_ = _loc2_ + (this.attackerPowerByGroup[_loc3_] as TroopsStats).count;
            }
        }
        return _loc2_;
    }

    public function getDefenceCount(param1:int = -1):int {
        var _loc3_:* = undefined;
        var _loc2_:int = 0;
        for (_loc3_ in this.defensivePowerByGroup) {
            if (_loc3_ == param1 || param1 == -1) {
                _loc2_ = _loc2_ + (this.defensivePowerByGroup[_loc3_] as TroopsStats).count;
            }
        }
        return _loc2_;
    }

    public function getIntelligenceCount(param1:int = -1):int {
        var _loc2_:* = undefined;
        var _loc3_:int = 0;
        for (_loc2_ in this.intelligencePowerByGroup) {
            if (_loc2_ == param1 || param1 == -1 || param1 == -3) {
                _loc3_ = _loc3_ + (this.intelligencePowerByGroup[_loc2_] as TroopsStats).count;
            }
        }
        for (_loc2_ in this.attackingIntelligencePowerByGroup) {
            if (_loc2_ == param1 || param1 == -1 || param1 == -2) {
                _loc3_ = _loc3_ + (this.attackingIntelligencePowerByGroup[_loc2_] as TroopsStats).count;
            }
        }
        return _loc3_;
    }
}
}
