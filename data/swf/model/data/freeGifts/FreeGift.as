package model.data.freeGifts {
import model.data.Resources;
import model.logic.ServerTimeManager;

public class FreeGift {

    public static const DOUBLE_GIFT_TIME:int = 10800000;


    public var fromSocialId:String;

    public var fromFacebookId:String;

    public var requestId:String;

    public var resources:Resources;

    public var time:Date;

    public var fbId:String;

    public var doubleGiftExpired:Boolean;

    public function FreeGift() {
        super();
    }

    public static function fromDto(param1:Object):FreeGift {
        var _loc2_:FreeGift = new FreeGift();
        _loc2_.fromSocialId = param1.f;
        if (param1.fb) {
            _loc2_.fromFacebookId = param1.fb;
        }
        _loc2_.resources = Resources.fromDto(param1.r);
        _loc2_.requestId = param1.i;
        _loc2_.time = new Date(param1.dt);
        if (isDoubleGiftTimeExpired(_loc2_.time)) {
            _loc2_.doubleGiftExpired = param1.x == null ? true : Boolean(param1.x);
        }
        else {
            _loc2_.doubleGiftExpired = false;
        }
        _loc2_.doubleGiftExpired = param1.x == null ? true : Boolean(param1.x);
        return _loc2_;
    }

    public static function fromDtos(param1:Array):Array {
        var _loc2_:Array = [];
        var _loc3_:int = 0;
        while (_loc3_ < param1.length) {
            _loc2_.push(fromDto(param1[_loc3_]));
            _loc3_++;
        }
        return _loc2_;
    }

    private static function isDoubleGiftTimeExpired(param1:Date):Boolean {
        var _loc2_:Number = param1.getTime();
        var _loc3_:Number = ServerTimeManager.serverTimeNow.getTime();
        var _loc4_:Number = _loc3_ - _loc2_;
        return _loc4_ > FreeGift.DOUBLE_GIFT_TIME;
    }
}
}
