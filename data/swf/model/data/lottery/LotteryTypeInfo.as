package model.data.lottery {
public class LotteryTypeInfo {

    public static const ALL_TYPES:String = "All";

    public static const QUICK_TYPE_LOTTERY:String = "Express";

    public static const LUCKY_TYPE_LOTTERY:String = "Standard";

    public static const MEGA_TYPE_LOTTERY:String = "Epic";


    public var type:String;

    public var pictureUrl:String;

    public var lotteryName:String;

    public var isActive:Boolean;

    public var cooldownHours:Number;

    public var durationHours:Number;

    public var generalTicketsCount:int;

    public var maxTicketsCountPerPerson:int;

    public var allowedTicketTypeIds:Array;

    public function LotteryTypeInfo() {
        super();
    }

    public static function fromDto(param1:*):LotteryTypeInfo {
        var _loc2_:LotteryTypeInfo = new LotteryTypeInfo();
        _loc2_.type = param1.n;
        _loc2_.pictureUrl = param1.u;
        if (param1.l != null) {
            _loc2_.lotteryName = param1.l.c;
        }
        _loc2_.isActive = param1.a;
        _loc2_.cooldownHours = param1.c;
        _loc2_.durationHours = param1.d;
        _loc2_.generalTicketsCount = param1.t;
        _loc2_.maxTicketsCountPerPerson = param1.m;
        _loc2_.allowedTicketTypeIds = param1.i;
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
