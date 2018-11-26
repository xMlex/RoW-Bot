package model.data.freeGifts {
import model.data.Resources;

public class FreeGiftsInfo {


    public const showFormLevel:int = 4;

    public var gifts:Array;

    public var sentToIdsToday:Array;

    public var acceptedToday:int;

    public var prodRate:Resources;

    public function FreeGiftsInfo() {
        super();
    }

    public static function fromDto(param1:Object):FreeGiftsInfo {
        var _loc2_:FreeGiftsInfo = new FreeGiftsInfo();
        if (param1.g) {
            _loc2_.gifts = FreeGift.fromDtos(param1.g);
        }
        if (param1.s) {
            _loc2_.sentToIdsToday = param1.s;
        }
        if (param1.t) {
            _loc2_.acceptedToday = param1.t;
        }
        if (param1.b) {
            _loc2_.prodRate = Resources.fromDto(param1.b);
        }
        return _loc2_;
    }
}
}
