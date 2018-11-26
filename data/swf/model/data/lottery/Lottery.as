package model.data.lottery {
import model.data.User;
import model.data.UserPrize;
import model.logic.ServerTimeManager;
import model.logic.UserManager;

public class Lottery {


    public var id:int;

    public var segmentId:int;

    public var revision:Number;

    public var lotteryType:String;

    public var dateDeadline:Date;

    public var dateFinished:Date;

    public var ticketsBought:int;

    public var maxTicketsPerUser:int;

    public var generalTicketsCount:int;

    public var userPrize:UserPrize;

    public var winnerUserId:int;

    public var lotteryPrizePackageId:int;

    public function Lottery() {
        super();
    }

    public static function fromDto(param1:*):Lottery {
        var _loc2_:Lottery = new Lottery();
        _loc2_.id = param1.i;
        _loc2_.segmentId = param1.s;
        _loc2_.revision = param1.r;
        _loc2_.lotteryType = param1.n;
        _loc2_.dateDeadline = param1.d == null ? null : new Date(param1.d);
        _loc2_.dateFinished = param1.z == null ? null : new Date(param1.z);
        _loc2_.maxTicketsPerUser = param1.m;
        _loc2_.ticketsBought = param1.b;
        _loc2_.generalTicketsCount = param1.t;
        _loc2_.userPrize = UserPrize.fromDto(param1.p);
        _loc2_.winnerUserId = param1.w;
        _loc2_.lotteryPrizePackageId = param1.e;
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

    public function get isActive():Boolean {
        if (this.dateFinished != null) {
            return false;
        }
        if (this.dateDeadline == null) {
            return true;
        }
        return this.dateDeadline.time > ServerTimeManager.serverTimeNow.time;
    }

    public function isUserRaffled():Boolean {
        var _loc1_:User = UserManager.user;
        if (_loc1_.gameData.lotteryData != null) {
            return _loc1_.gameData.lotteryData.getContributedTicketsCountByLotteryId(this.id) > 0;
        }
        return false;
    }

    public function isUserWinner():Boolean {
        return this.winnerUserId == UserManager.user.id;
    }
}
}
