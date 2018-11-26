package model.data.lottery {
import model.data.UserPrize;

public class LotteryPrizeInfo {


    public var packageId:int;

    public var prize:UserPrize;

    public var goldMoneyPrize:int;

    public var packageTopic:String;

    public function LotteryPrizeInfo() {
        super();
    }

    public static function fromDto(param1:*):LotteryPrizeInfo {
        var _loc2_:LotteryPrizeInfo = new LotteryPrizeInfo();
        _loc2_.packageId = param1.i;
        _loc2_.prize = UserPrize.fromDto(param1.a);
        _loc2_.goldMoneyPrize = param1.g;
        _loc2_.packageTopic = param1.l != null ? param1.l.c : "";
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
