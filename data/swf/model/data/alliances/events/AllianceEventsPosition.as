package model.data.alliances.events {
public class AllianceEventsPosition {


    public var eventType:Object;

    public var isActive:Object;

    public var minScores:Number;

    public var maxScores:Number;

    public function AllianceEventsPosition() {
        super();
    }

    public static function fromDto(param1:*):AllianceEventsPosition {
        var _loc2_:AllianceEventsPosition = new AllianceEventsPosition();
        _loc2_.eventType = param1.t;
        _loc2_.isActive = param1.a;
        _loc2_.minScores = param1.l;
        _loc2_.maxScores = param1.h;
        return _loc2_;
    }

    public function toDto():* {
        return {
            "t": this.eventType,
            "a": this.isActive,
            "l": this.minScores,
            "h": this.maxScores
        };
    }
}
}
