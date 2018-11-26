package model.data.giftPoints {
public class LightGppBonus {


    public var id:int;

    public var bonusItemsIds:Array;

    public var isActive:Boolean;

    public var activationsCount:int;

    public var bonusActivationType:int;

    public function LightGppBonus() {
        super();
    }

    public static function fromDto(param1:*):LightGppBonus {
        var _loc2_:LightGppBonus = new LightGppBonus();
        _loc2_.id = param1.i;
        _loc2_.bonusItemsIds = param1.e;
        _loc2_.isActive = param1.a;
        _loc2_.activationsCount = param1.c;
        _loc2_.bonusActivationType = param1.t;
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
