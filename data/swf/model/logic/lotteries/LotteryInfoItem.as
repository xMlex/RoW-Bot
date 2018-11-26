package model.logic.lotteries {
import Utils.Guard;

import model.data.lottery.Lottery;
import model.data.lottery.LotteryPrizeInfo;
import model.data.lottery.LotteryTypeInfo;
import model.data.lottery.UserLotteryData;
import model.logic.UserManager;

public class LotteryInfoItem {


    public var lotteryId:int;

    public var totalGoldMoneyCost:int = 0;

    public var packageId:int = 0;

    public var userContributedTickets:int = 0;

    public var maxTicketsPerUser:int = 0;

    public var contributedTickets:int = 0;

    public var generalTicketsCount:int = 0;

    public var winnerId:int;

    public var isFinished:Boolean;

    public var userIsWinner:Boolean;

    public var hasOnlyGoldMoney:Boolean;

    public var dateFinished:Date;

    public var lotteryType:String;

    public var lotteryName:String;

    public var packageName:String;

    public var imageUrl:String;

    public var allowedTicketIds:Array;

    public function LotteryInfoItem() {
        super();
    }

    public function build(param1:Lottery):void {
        Guard.againstNull(param1);
        if (param1 == null) {
            return;
        }
        var _loc2_:LotteryTypeInfo = LotteryManager.getLotteryTypeInfoByType(param1.lotteryType);
        var _loc3_:LotteryPrizeInfo = LotteryManager.getLotteryPrizeByPackageId(param1.lotteryPrizePackageId);
        this.lotteryId = param1.id;
        this.lotteryType = param1.lotteryType;
        this.contributedTickets = param1.ticketsBought;
        this.generalTicketsCount = param1.generalTicketsCount;
        this.maxTicketsPerUser = param1.maxTicketsPerUser;
        this.winnerId = param1.winnerUserId;
        this.userIsWinner = param1.isUserWinner();
        this.isFinished = param1.dateFinished != null;
        this.dateFinished = param1.dateFinished;
        this.lotteryName = _loc2_.lotteryName;
        this.imageUrl = _loc2_.pictureUrl;
        this.allowedTicketIds = _loc2_.allowedTicketTypeIds;
        this.packageName = _loc3_.packageTopic;
        this.totalGoldMoneyCost = _loc3_.goldMoneyPrize;
        this.packageId = _loc3_.packageId;
        this.hasOnlyGoldMoney = !_loc3_.prize.hasBonusesExceptGoldMoney();
        this.updateContributedByUser();
    }

    private function updateContributedByUser():void {
        var _loc1_:UserLotteryData = UserManager.user.gameData.lotteryData;
        if (_loc1_ != null) {
            this.userContributedTickets = _loc1_.getContributedTicketsCountByLotteryId(this.lotteryId);
        }
    }

    public function clone():LotteryInfoItem {
        var _loc1_:LotteryInfoItem = new LotteryInfoItem();
        _loc1_.lotteryId = this.lotteryId;
        _loc1_.lotteryType = this.lotteryType;
        _loc1_.packageName = this.packageName;
        _loc1_.totalGoldMoneyCost = this.totalGoldMoneyCost;
        _loc1_.userContributedTickets = this.userContributedTickets;
        _loc1_.contributedTickets = this.contributedTickets;
        _loc1_.generalTicketsCount = this.generalTicketsCount;
        _loc1_.isFinished = this.isFinished;
        _loc1_.hasOnlyGoldMoney = this.hasOnlyGoldMoney;
        _loc1_.winnerId = this.winnerId;
        _loc1_.userIsWinner = this.userIsWinner;
        _loc1_.lotteryName = this.lotteryName;
        _loc1_.packageId = this.packageId;
        _loc1_.maxTicketsPerUser = this.maxTicketsPerUser;
        _loc1_.dateFinished = this.dateFinished;
        _loc1_.allowedTicketIds = this.allowedTicketIds;
        _loc1_.imageUrl = this.imageUrl;
        return _loc1_;
    }

    public function isEqual(param1:LotteryInfoItem):Boolean {
        return this.lotteryId == param1.lotteryId && this.userContributedTickets == param1.userContributedTickets && this.contributedTickets == param1.contributedTickets && this.generalTicketsCount == param1.generalTicketsCount && this.maxTicketsPerUser == param1.maxTicketsPerUser && this.packageId == param1.packageId && this.isFinished == param1.isFinished && this.userIsWinner == param1.userIsWinner && this.packageName == param1.packageName && this.hasOnlyGoldMoney == param1.hasOnlyGoldMoney && this.winnerId == param1.winnerId && this.lotteryName == param1.lotteryName && this.imageUrl == param1.imageUrl && this.allowedTicketIds == param1.allowedTicketIds;
    }
}
}
