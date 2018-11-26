package model.data.locations.allianceCity.flags {
public class AllianceCityFlagLocation {


    public var tournamentPrototypeId:int;

    public var currentLocationAllianceId:Number;

    public var currentLocationCityId:Number;

    public function AllianceCityFlagLocation() {
        super();
    }

    public static function fromDto(param1:*):AllianceCityFlagLocation {
        var _loc2_:AllianceCityFlagLocation = new AllianceCityFlagLocation();
        _loc2_.tournamentPrototypeId = param1.t;
        _loc2_.currentLocationAllianceId = param1.a;
        _loc2_.currentLocationCityId = param1.c;
        return _loc2_;
    }

    public static function fromDtos(param1:*):Vector.<AllianceCityFlagLocation> {
        var _loc3_:* = undefined;
        var _loc2_:Vector.<AllianceCityFlagLocation> = new Vector.<AllianceCityFlagLocation>(0);
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
