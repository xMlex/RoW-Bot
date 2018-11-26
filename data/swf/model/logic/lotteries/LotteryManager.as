package model.logic.lotteries {
import common.queries.util.query;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.Dictionary;

import model.data.lottery.Lottery;
import model.data.lottery.LotteryPrizeInfo;
import model.data.lottery.LotteryTypeInfo;
import model.data.lottery.TicketTypeInfo;
import model.data.lottery.UserLotteryData;
import model.logic.ServerManager;
import model.logic.UserManager;
import model.logic.autoRefresh.AutoRefreshEvent;
import model.logic.autoRefresh.AutoRefreshManager;
import model.logic.commands.lottery.MarkReadLotteryCmd;

public class LotteryManager {

    public static const CLASS_NAME:String = "LotteryManager";

    public static const LOTTERIES_DATA_CHANGED:String = CLASS_NAME + "DataChanged";

    private static var maxRevisionByArray:Array;

    private static var _lotteryTypeInfos:Array;

    private static var _lotteriesArray:Array;

    private static var _deletedLotteriesArray:Array;

    private static var _lotteryPrizeInfos:Array;

    private static var _ticketTypeInfos:Array;

    public static const events:EventDispatcher = new EventDispatcher();


    public function LotteryManager() {
        super();
    }

    public static function addEventHandler(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        events.addEventListener(param1, param2, param3, param4, param5);
    }

    public static function removeEventHandler(param1:String, param2:Function):void {
        events.removeEventListener(param1, param2);
    }

    public static function subscribeForAutoRefresh():void {
        AutoRefreshManager.events.addEventListener(AutoRefreshManager.EVENT_REFRESH_START, autoRefreshStartHandler);
        AutoRefreshManager.events.addEventListener(AutoRefreshManager.EVENT_REFRESH_COMPLETED, autoRefreshCompletedHandler);
    }

    public static function unSubscribeFromAutoRefresh():void {
        AutoRefreshManager.events.removeEventListener(AutoRefreshManager.EVENT_REFRESH_START, autoRefreshStartHandler);
        AutoRefreshManager.events.removeEventListener(AutoRefreshManager.EVENT_REFRESH_COMPLETED, autoRefreshCompletedHandler);
    }

    private static function autoRefreshStartHandler(param1:AutoRefreshEvent):void {
        param1.dto.lottery = getLotteryRefreshInputDto();
    }

    private static function autoRefreshCompletedHandler(param1:AutoRefreshEvent):void {
        if (param1.dto.lottery != null) {
            updateFromDto(param1.dto.lottery);
        }
    }

    public static function initializeLotteries(param1:Array):void {
        _lotteriesArray = merge(_lotteriesArray, param1, lotteryToId);
        LotteryManager.events.dispatchEvent(new Event(LotteryManager.LOTTERIES_DATA_CHANGED));
    }

    public static function initializeLotteryTypeInfos(param1:Array):void {
        _lotteryTypeInfos = merge(_lotteryTypeInfos, param1, lotteryTypeInfoToType);
    }

    public static function initializeLotteryPrizeInfos(param1:Array):void {
        _lotteryPrizeInfos = merge(_lotteryPrizeInfos, param1, lotteryPrizeToPackageId);
    }

    public static function initializeLotteryTicketTypeInfos(param1:Array):void {
        _ticketTypeInfos = param1;
    }

    private static function initializeRevisions(param1:Array):void {
        var _loc2_:* = undefined;
        fillEmptyRevisionArray();
        for each(_loc2_ in param1) {
            maxRevisionByArray[_loc2_.k] = _loc2_.v;
        }
    }

    private static function fillEmptyRevisionArray():void {
        var _loc1_:int = 0;
        if (maxRevisionByArray == null) {
            maxRevisionByArray = [];
            _loc1_ = 0;
            while (_loc1_ < ServerManager.SegmentServerAddresses.length) {
                maxRevisionByArray.push(0);
                _loc1_++;
            }
        }
    }

    public static function updateFromDto(param1:*):void {
        if (param1.r != null && param1.r.length > 0) {
            initializeRevisions(param1.r);
        }
        if (param1.i != null && param1.i.length > 0) {
            initializeLotteryTypeInfos(LotteryTypeInfo.fromDtos(param1.i));
        }
        if (param1.p != null && param1.p.length > 0) {
            initializeLotteryPrizeInfos(LotteryPrizeInfo.fromDtos(param1.p));
        }
        if (param1.l != null && param1.l.length > 0) {
            initializeLotteries(Lottery.fromDtos(param1.l));
        }
    }

    private static function updateRevision():void {
        var revisionsGroupedBySegment:Dictionary = null;
        var segment:* = undefined;
        fillEmptyRevisionArray();
        var allKnownLotteries:Array = _deletedLotteriesArray != null ? _lotteriesArray.concat(_deletedLotteriesArray) : _lotteriesArray;
        if (allKnownLotteries != null) {
            revisionsGroupedBySegment = query(allKnownLotteries).groupBy(function (param1:Lottery):* {
                return param1.segmentId;
            }, function (param1:Lottery):* {
                return param1.revision;
            }).toDictionary();
            for (segment in revisionsGroupedBySegment) {
                maxRevisionByArray[segment] = query(revisionsGroupedBySegment[segment]).max(null, numberComparer);
            }
        }
    }

    public static function getLotteryRefreshInputDto():* {
        updateRevision();
        return {
            "r": maxRevisionByArray,
            "t": getKnownLotteryTypes(),
            "p": getKnownLotteryPrizes()
        };
    }

    public static function getLotteries():Array {
        return _lotteriesArray;
    }

    public static function getLotteryById(param1:int):Lottery {
        var id:int = param1;
        if (_lotteriesArray == null) {
            return null;
        }
        return query(_lotteriesArray).firstOrDefault(function (param1:Lottery):* {
            return param1.id == id;
        });
    }

    public static function getLotteryTypeInfoByType(param1:String):LotteryTypeInfo {
        var type:String = param1;
        if (_lotteryTypeInfos == null) {
            return null;
        }
        return query(_lotteryTypeInfos).firstOrDefault(function (param1:*):Boolean {
            return param1.type == type;
        });
    }

    public static function getLotteryPrizeByPackageId(param1:int):LotteryPrizeInfo {
        var packId:int = param1;
        if (_lotteryPrizeInfos == null) {
            return null;
        }
        return query(_lotteryPrizeInfos).firstOrDefault(function (param1:*):Boolean {
            return param1.packageId == packId;
        });
    }

    public static function getTicketInfoByTicketId(param1:int):TicketTypeInfo {
        var ticketTypeId:int = param1;
        if (_ticketTypeInfos == null) {
            return null;
        }
        return query(_ticketTypeInfos).firstOrDefault(function (param1:*):Boolean {
            return param1.typeId == ticketTypeId;
        });
    }

    public static function getFreeTicketsCountByTicketId(param1:int):int {
        var _loc2_:UserLotteryData = UserManager.user.gameData.lotteryData;
        if (_loc2_ != null && _loc2_.freeTicketsCountByTypeId != null && _loc2_.freeTicketsCountByTypeId[param1] != undefined) {
            return _loc2_.freeTicketsCountByTypeId[param1];
        }
        return 0;
    }

    public static function getActiveLotteries():Array {
        return query(_lotteriesArray).where(function (param1:Lottery):Boolean {
            return param1.isActive;
        }).toArray();
    }

    public static function getMaxAvailableTicketsCountByLotteryId(param1:int):int {
        var _loc2_:Lottery = getLotteryById(param1);
        var _loc3_:UserLotteryData = UserManager.user.gameData.lotteryData;
        var _loc4_:int = _loc3_ != null ? int(_loc3_.getContributedTicketsCountByLotteryId(param1)) : 0;
        var _loc5_:int = _loc2_.maxTicketsPerUser - _loc4_;
        if (_loc5_ == 0) {
            return 0;
        }
        var _loc6_:int = _loc2_.generalTicketsCount - _loc2_.ticketsBought;
        return Math.min(_loc6_, _loc5_);
    }

    public static function getFinishedLotteries():Array {
        var wonLotteries:Array = UserManager.user.gameData.lotteryData.wonLotteries;
        var lostLotteries:Array = UserManager.user.gameData.lotteryData.lostLotteries;
        if (_lotteriesArray == null) {
            _lotteriesArray = [];
        }
        var allLostLotteries:Array = query(_lotteriesArray).where(function (param1:Lottery):Boolean {
            return !param1.isActive && param1.winnerUserId != 0 && !param1.isUserWinner() && param1.isUserRaffled();
        }).toArray();
        if (wonLotteries == null && lostLotteries == null && allLostLotteries == null) {
            return null;
        }
        if (wonLotteries == null) {
            return merge(lostLotteries, allLostLotteries, lotteryToId);
        }
        if (lostLotteries == null) {
            return merge(wonLotteries, allLostLotteries, lotteryToId);
        }
        return merge(lostLotteries.concat(wonLotteries), allLostLotteries, lotteryToId);
    }

    private static function getKnownLotteryTypes():Array {
        if (_lotteryTypeInfos == null) {
            return [];
        }
        return query(_lotteryTypeInfos).select(function (param1:LotteryTypeInfo):String {
            return param1.type;
        }).distinct().toArray();
    }

    private static function getKnownLotteryPrizes():Array {
        if (_lotteryTypeInfos == null) {
            return [];
        }
        return query(_lotteryPrizeInfos).select(function (param1:LotteryPrizeInfo):int {
            return param1.packageId;
        }).distinct().toArray();
    }

    public static function markAsReadLotteries(param1:Array):void {
        new MarkReadLotteryCmd(param1).execute();
    }

    public static function deleteLotteriesByIds(param1:Array):void {
        var _loc3_:int = 0;
        var _loc2_:int = 0;
        while (_loc2_ < param1.length) {
            _loc3_ = 0;
            while (_loc3_ < _lotteriesArray.length) {
                if (_lotteriesArray[_loc3_].id == param1[_loc2_]) {
                    if (_deletedLotteriesArray == null) {
                        _deletedLotteriesArray = [];
                    }
                    _deletedLotteriesArray.push(_lotteriesArray[_loc3_]);
                    _lotteriesArray.splice(_loc3_, 1);
                    break;
                }
                _loc3_++;
            }
            _loc2_++;
        }
    }

    private static function merge(param1:Array, param2:Array, param3:Function):Array {
        if (param2 == null) {
            return param1;
        }
        if (param1 == null) {
            return param2;
        }
        return query(param1).except(param2, param3).concat(param2).toArray();
    }

    private static function lotteryToId(param1:Lottery):int {
        return param1.id;
    }

    private static function lotteryTypeInfoToType(param1:LotteryTypeInfo):String {
        return param1.type;
    }

    private static function lotteryPrizeToPackageId(param1:LotteryPrizeInfo):int {
        return param1.packageId;
    }

    private static function numberComparer(param1:Number, param2:Number):int {
        if (param1 < param2) {
            return -1;
        }
        if (param1 > param2) {
            return 1;
        }
        return 0;
    }
}
}
