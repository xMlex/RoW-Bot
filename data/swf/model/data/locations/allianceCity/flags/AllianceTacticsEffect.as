package model.data.locations.allianceCity.flags {
public class AllianceTacticsEffect {


    public var typeId:Number;

    public var tournamentPrototypeId:int;

    public var applierAllianceId:Number;

    public var fromTime:Date;

    public var toTime:Date;

    public function AllianceTacticsEffect() {
        super();
    }

    public static function fromDto(param1:*):AllianceTacticsEffect {
        var _loc2_:AllianceTacticsEffect = new AllianceTacticsEffect();
        _loc2_.typeId = param1.e;
        _loc2_.tournamentPrototypeId = param1.t;
        _loc2_.applierAllianceId = param1.a;
        _loc2_.fromTime = !!param1.f ? new Date(param1.f) : null;
        _loc2_.toTime = !!param1.d ? new Date(param1.d) : null;
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
}
}
