package model.data.lottery {
import common.queries.util.query;

import gameObjects.observableObject.ObservableObject;

import model.data.User;
import model.data.normalization.INEvent;
import model.data.normalization.INormalizable;
import model.logic.ServerTimeManager;
import model.logic.lotteries.LotteryManager;

public class UserLotteryData extends ObservableObject implements INormalizable {

    public static const CLASS_NAME:String = "UserLotteryData";

    public static const USER_LOTTERY_DATA_CHANGED:String = CLASS_NAME + "DataChanged";

    public static const CONTRIBUTED_TICKETS_DATA_CHANGED:String = CLASS_NAME + "TicketsDataChanged";


    public var freeTicketsCountByTypeId:Object;

    public var contributedTicketTypesCountByLotteryId:Object;

    public var wonLotteries:Array;

    public var lostLotteries:Array;

    public var dirty:Boolean;

    public var ticketsDirty:Boolean;

    public var lastMainWindowIconEntryDate:Date;

    public function UserLotteryData() {
        super();
    }

    public static function fromDto(param1:*):UserLotteryData {
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        var _loc2_:UserLotteryData = new UserLotteryData();
        _loc2_.freeTicketsCountByTypeId = {};
        for (_loc3_ in param1.b) {
            _loc2_.freeTicketsCountByTypeId[_loc3_] = param1.b[_loc3_];
        }
        _loc2_.contributedTicketTypesCountByLotteryId = {};
        for (_loc4_ in param1.c) {
            _loc2_.contributedTicketTypesCountByLotteryId[_loc4_] = TicketCount.fromDtos(param1.c[_loc4_]);
        }
        if (param1.p != null) {
            _loc2_.wonLotteries = Lottery.fromDtos(param1.p);
        }
        if (param1.l != null) {
            _loc2_.lostLotteries = Lottery.fromDtos(param1.l);
        }
        if (param1.t != null) {
            LotteryManager.initializeLotteryTypeInfos(LotteryTypeInfo.fromDtos(param1.t));
        }
        if (param1.z != null) {
            LotteryManager.initializeLotteryPrizeInfos(LotteryPrizeInfo.fromDtos(param1.z));
        }
        if (param1.i != null) {
            _loc2_.lastMainWindowIconEntryDate = new Date(param1.i);
        }
        return _loc2_;
    }

    public function updateLotteryDataFromDto(param1:*):UserLotteryData {
        var _loc2_:* = undefined;
        var _loc3_:* = undefined;
        if (param1.b != null) {
            this.freeTicketsCountByTypeId = {};
            for (_loc2_ in param1.b) {
                this.freeTicketsCountByTypeId[_loc2_] = param1.b[_loc2_];
            }
        }
        if (param1.c != null) {
            this.contributedTicketTypesCountByLotteryId = {};
            for (_loc3_ in param1.c) {
                this.contributedTicketTypesCountByLotteryId[_loc3_] = TicketCount.fromDtos(param1.c[_loc3_]);
            }
        }
        return this;
    }

    public function getContributedTicketsCountByLotteryId(param1:int):int {
        var arrayOfTicketsCountByType:Array = null;
        var lotteryId:int = param1;
        if (this.contributedTicketTypesCountByLotteryId != null && this.contributedTicketTypesCountByLotteryId[lotteryId] != null) {
            arrayOfTicketsCountByType = this.contributedTicketTypesCountByLotteryId[lotteryId];
            return query(arrayOfTicketsCountByType).sum(function (param1:TicketCount):* {
                return param1.freeCount + param1.paidCount;
            });
        }
        return 0;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            dispatchEvent(USER_LOTTERY_DATA_CHANGED);
            this.dirty = false;
        }
        if (this.ticketsDirty) {
            dispatchEvent(CONTRIBUTED_TICKETS_DATA_CHANGED);
            this.ticketsDirty = false;
        }
    }

    public function getNextEvent(param1:User, param2:Date):INEvent {
        var _loc3_:Array = null;
        var _loc4_:* = null;
        var _loc5_:Lottery = null;
        if (this.contributedTicketTypesCountByLotteryId == null || LotteryManager.getLotteries() == null) {
            return null;
        }
        for (_loc4_ in this.contributedTicketTypesCountByLotteryId) {
            _loc5_ = LotteryManager.getLotteryById(parseInt(_loc4_));
            if (_loc5_ != null) {
                if (_loc5_.dateFinished != null && _loc5_.winnerUserId == 0 && _loc5_.dateFinished.time <= ServerTimeManager.serverTimeNow.time) {
                    if (_loc3_ == null) {
                        _loc3_ = [];
                    }
                    _loc3_.push(_loc5_.id);
                }
            }
        }
        if (_loc3_ != null) {
            return new NEventReturnGoldMoneyForExpiredLotteries(_loc3_, param2);
        }
        return null;
    }
}
}
