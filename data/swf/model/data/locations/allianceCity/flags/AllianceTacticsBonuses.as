package model.data.locations.allianceCity.flags {
public class AllianceTacticsBonuses {


    public var buffsCount:int;

    public var debuffsCount:int;

    public var maxDebuffsNumber:int;

    public function AllianceTacticsBonuses() {
        super();
    }

    public static function fromDto(param1:*):AllianceTacticsBonuses {
        var _loc2_:AllianceTacticsBonuses = new AllianceTacticsBonuses();
        _loc2_.buffsCount = param1.b;
        _loc2_.debuffsCount = param1.d;
        if (param1.p == 0) {
            _loc2_.maxDebuffsNumber = 0;
        }
        else {
            _loc2_.maxDebuffsNumber = !!param1.p ? int(param1.p) : -1;
        }
        return _loc2_;
    }

    public static function getIntersection(param1:AllianceTacticsBonuses, param2:AllianceTacticsBonuses):AllianceTacticsBonuses {
        if (param1 == null || param2 == null) {
            return null;
        }
        var _loc3_:AllianceTacticsBonuses = new AllianceTacticsBonuses();
        if (param1.buffsCount > 0 && param2.buffsCount > 0) {
            _loc3_.buffsCount = param2.buffsCount;
        }
        if (param1.debuffsCount > 0 && param2.debuffsCount > 0) {
            _loc3_.debuffsCount = param2.debuffsCount;
        }
        if (param1.maxDebuffsNumber > 0 && param2.maxDebuffsNumber > 0) {
            _loc3_.maxDebuffsNumber = param2.maxDebuffsNumber;
        }
        return _loc3_;
    }

    public function get isImmunity():Boolean {
        return this.maxDebuffsNumber == 0;
    }
}
}
