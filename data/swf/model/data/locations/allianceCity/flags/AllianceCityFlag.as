package model.data.locations.allianceCity.flags {
public class AllianceCityFlag {


    public var tournamentPrototypeId:int;

    public var ownerAllianceId:Number;

    public var ownerCityId:Number;

    public var league:int;

    public var points:Number;

    public function AllianceCityFlag() {
        super();
    }

    public static function fromDto(param1:*):AllianceCityFlag {
        var _loc2_:AllianceCityFlag = new AllianceCityFlag();
        _loc2_.tournamentPrototypeId = param1.t;
        _loc2_.ownerAllianceId = param1.o;
        _loc2_.ownerCityId = param1.c;
        _loc2_.league = param1.l;
        _loc2_.points = param1.p;
        return _loc2_;
    }

    public static function fromDtos(param1:*):Vector.<AllianceCityFlag> {
        var _loc3_:* = undefined;
        var _loc2_:Vector.<AllianceCityFlag> = new Vector.<AllianceCityFlag>(0);
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
