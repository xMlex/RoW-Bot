package model.data.defensiveData {
import model.logic.dtoSerializer.DtoDeserializer;

public class StaticDefensiveInformation {


    public var defensiveObjectHighLevel:int;

    public var highLevelDefensiveObjectXP:int;

    public var defensiveObjectIdToTypeAndLevel:Object;

    public function StaticDefensiveInformation() {
        super();
    }

    public static function fromDto(param1:*):StaticDefensiveInformation {
        if (param1 == null) {
            return null;
        }
        var _loc2_:StaticDefensiveInformation = new StaticDefensiveInformation();
        _loc2_.defensiveObjectHighLevel = param1.dh;
        _loc2_.highLevelDefensiveObjectXP = param1.de;
        _loc2_.defensiveObjectIdToTypeAndLevel = DtoDeserializer.toObject(param1.dt, DefensiveBuildingInfo.fromDto);
        return _loc2_;
    }

    public function isHighLevelDefensiveObject(param1:int):Boolean {
        var _loc2_:DefensiveBuildingInfo = this.defensiveObjectIdToTypeAndLevel[param1];
        if (_loc2_.level >= this.defensiveObjectHighLevel) {
            return true;
        }
        return false;
    }

    public function IsDefensiveObjectLevelEqualOrLess(param1:int, param2:int):Boolean {
        var _loc3_:DefensiveBuildingInfo = this.defensiveObjectIdToTypeAndLevel[param1];
        if (_loc3_.level <= param2) {
            return true;
        }
        return false;
    }
}
}
