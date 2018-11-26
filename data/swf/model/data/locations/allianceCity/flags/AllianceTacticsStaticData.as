package model.data.locations.allianceCity.flags {
public class AllianceTacticsStaticData {


    public var allianceBuffsTotal:int;

    public var allianceDebuffsTotal:int;

    public var buffsOfSameTypeTotal:int;

    public var debuffsOfSameTypeTotal:int;

    public var allianceEffectTypes:Array;

    public var allianceEffectTypesById:Object;

    public function AllianceTacticsStaticData() {
        super();
    }

    public static function fromDto(param1:*):AllianceTacticsStaticData {
        var _loc2_:AllianceTacticsStaticData = new AllianceTacticsStaticData();
        _loc2_.allianceBuffsTotal = param1.b;
        _loc2_.allianceDebuffsTotal = param1.d;
        _loc2_.buffsOfSameTypeTotal = param1.q;
        _loc2_.debuffsOfSameTypeTotal = param1.w;
        _loc2_.allianceEffectTypes = AllianceTacticsEffectType.fromDtos(param1.t);
        _loc2_.createDictionary();
        return _loc2_;
    }

    private function createDictionary():void {
        var _loc1_:AllianceTacticsEffectType = null;
        this.allianceEffectTypesById = {};
        for each(_loc1_ in this.allianceEffectTypes) {
            this.allianceEffectTypesById[_loc1_.id] = _loc1_;
        }
    }
}
}
