package model.data.tournaments {
public class TournamentStatisticsItem {


    public var statsType:int;

    public var value:Number;

    public function TournamentStatisticsItem() {
        super();
    }

    public static function fromDto(param1:*):TournamentStatisticsItem {
        var _loc2_:TournamentStatisticsItem = new TournamentStatisticsItem();
        _loc2_.statsType = param1.s;
        _loc2_.value = param1.p;
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
