package model.data.giftPoints {
public class GiftPointsProgramBonus {


    public var id:int;

    public var costInGiftPoints:int;

    public var bonusItems:Array;

    public var bonusActivationType:int;

    public var depositorGroupId:int;

    public var level:int;

    public var nextBonus:GiftPointsProgramBonus;

    public function GiftPointsProgramBonus() {
        super();
    }

    public static function fromDto(param1:*):GiftPointsProgramBonus {
        var _loc2_:GiftPointsProgramBonus = new GiftPointsProgramBonus();
        _loc2_.id = param1.i;
        _loc2_.costInGiftPoints = param1.p;
        _loc2_.bonusItems = GiftPointsProgramBonusItem.fromDtos(param1.e);
        _loc2_.bonusActivationType = param1.t;
        _loc2_.depositorGroupId = param1.d;
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

    public function get isLastBonus():Boolean {
        return this.nextBonus == null;
    }
}
}
