package model.data.alliances {
import common.ArrayCustom;

import model.data.alliances.events.AllianceEventsPosition;

public class AllianceEventsDto {


    public var posLow:AllianceEventsPosition;

    public var posHigh:AllianceEventsPosition;

    public var events:ArrayCustom;

    public var moreItems:Boolean;

    public var noteInitialized:Boolean;

    public function AllianceEventsDto() {
        super();
    }

    public static function fromDto(param1:*):AllianceEventsDto {
        var _loc2_:AllianceEventsDto = new AllianceEventsDto();
        _loc2_.events = param1.e == null ? new ArrayCustom() : AllianceEvent.fromDtos(param1.e);
        _loc2_.moreItems = param1.m == null ? false : Boolean(param1.m);
        _loc2_.posLow = param1.p == null ? null : AllianceEventsPosition.fromDto(param1.p);
        _loc2_.posHigh = param1.b == null ? null : AllianceEventsPosition.fromDto(param1.b);
        _loc2_.noteInitialized = param1.n == null ? false : Boolean(param1.n);
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
