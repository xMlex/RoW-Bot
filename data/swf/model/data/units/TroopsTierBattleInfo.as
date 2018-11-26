package model.data.units {
import common.queries.util.query;

public class TroopsTierBattleInfo {


    public var tierId:int;

    public var level:int;

    public var experience:Number;

    public var experienceTierTotalBefore:Number;

    public var experienceTierTotalAfter:Number;

    public var troopsExperience:Array;

    public function TroopsTierBattleInfo() {
        super();
    }

    public static function fromDto(param1:*):TroopsTierBattleInfo {
        var _loc2_:TroopsTierBattleInfo = new TroopsTierBattleInfo();
        _loc2_.tierId = param1.i;
        _loc2_.level = param1.l;
        _loc2_.experience = param1.e != null ? Number(param1.e) : Number(0);
        _loc2_.experienceTierTotalBefore = param1.b != null ? Number(param1.b) : Number(0);
        _loc2_.experienceTierTotalAfter = param1.t != null ? Number(param1.t) : Number(0);
        _loc2_.troopsExperience = param1.u != null ? TroopsExperience.fromDtos(param1.u) : null;
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function createSimple(param1:int, param2:int):TroopsTierBattleInfo {
        var _loc3_:TroopsTierBattleInfo = new TroopsTierBattleInfo();
        _loc3_.tierId = param1;
        _loc3_.level = param2;
        return _loc3_;
    }

    public function getExperienceByUnit(param1:int):TroopsExperience {
        var unitTypeId:int = param1;
        if (this.troopsExperience == null) {
            return null;
        }
        return query(this.troopsExperience).firstOrDefault(function (param1:TroopsExperience):Boolean {
            return param1.typeId == unitTypeId;
        });
    }

    public function clone():TroopsTierBattleInfo {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc1_:TroopsTierBattleInfo = new TroopsTierBattleInfo();
        _loc1_.experience = this.experience;
        _loc1_.experienceTierTotalBefore = this.experienceTierTotalBefore;
        _loc1_.experienceTierTotalAfter = this.experienceTierTotalAfter;
        _loc1_.level = this.level;
        _loc1_.tierId = this.tierId;
        if (this.troopsExperience != null) {
            _loc2_ = this.troopsExperience.length;
            _loc1_.troopsExperience = [];
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _loc1_.troopsExperience.push(this.troopsExperience[_loc3_].clone());
                _loc3_++;
            }
        }
        return _loc1_;
    }
}
}
