package model.data.giftPoints {
public class GiftPointsProgramBonusItem {


    public var effectTypeId:int;

    public var useCount:int;

    public var power:Number;

    public function GiftPointsProgramBonusItem() {
        super();
    }

    public static function fromDto(param1:*):GiftPointsProgramBonusItem {
        var _loc2_:GiftPointsProgramBonusItem = new GiftPointsProgramBonusItem();
        _loc2_.effectTypeId = param1.e;
        _loc2_.useCount = param1.c;
        _loc2_.power = param1.p;
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
