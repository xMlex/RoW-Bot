package model.logic.serverBoost {
import common.queries.util.query;

import flash.events.Event;
import flash.events.EventDispatcher;

import model.data.globalEvent.GlobalEvent;
import model.data.users.misc.UserBlackMarketData;
import model.logic.ServerTimeManager;
import model.logic.TimerManager;
import model.logic.UserManager;
import model.logic.globalEvents.GlobalEventItem;

public class ServerBoostManager {

    public static const ACTIVE_SERVER_BOOST_COMPLETED:String = "ActiveCompletedServerBoost";

    public static const UPCOMING_SERVER_BOOST_COMPLETED:String = "UpcomingServerBoostCompleted";

    private static var _activeServerBoostObjects:Array;

    private static var _upcomingServerBoostObjects:Array;

    private static var _eventDispatcher:EventDispatcher = new EventDispatcher();

    private static var _activeServerBoosts:Array;

    private static var _upcomingServerBoosts:Array;


    public function ServerBoostManager() {
        super();
    }

    public static function get eventDispatcher():EventDispatcher {
        return _eventDispatcher;
    }

    public static function set activeServerBoosts(param1:Array):void {
        _activeServerBoosts = param1;
        buildActiveServerBoostObjectsArray();
        if (_activeServerBoosts != null && _activeServerBoosts.length > 0) {
            subscribeOnTimerTick();
        }
    }

    public static function set upcomingServerBoosts(param1:Array):void {
        _upcomingServerBoosts = param1;
        buildUpcomingServerBoostObjectsArray();
        if (_upcomingServerBoosts != null && _upcomingServerBoosts.length > 0) {
            subscribeOnTimerTick();
        }
    }

    public static function get hasServerBoost():Boolean {
        return _activeServerBoostObjects != null && _activeServerBoostObjects.length > 0 || _upcomingServerBoostObjects != null && _upcomingServerBoostObjects.length > 0;
    }

    public static function get hasActiveServerBoost():Boolean {
        buildActiveServerBoostObjectsArray();
        return _activeServerBoostObjects.length > 0;
    }

    public static function get hasUpcomingServerBoost():Boolean {
        buildUpcomingServerBoostObjectsArray();
        return _upcomingServerBoostObjects.length > 0;
    }

    public static function getActiveServerBoostsArray():Array {
        buildActiveServerBoostObjectsArray();
        return _activeServerBoostObjects;
    }

    public static function getUpcomingServerBoostsArray():Array {
        buildUpcomingServerBoostObjectsArray();
        return _upcomingServerBoostObjects;
    }

    private static function subscribeOnTimerTick():void {
        TimerManager.addTickListener(timerHandler);
    }

    private static function unSubscribeOnTimerTick():void {
        TimerManager.removeTickListener(timerHandler);
    }

    private static function timerHandler():void {
        updateTimer();
    }

    private static function updateTimer():void {
        if (hasServerBoost) {
            refreshActiveBoosts();
            refreshUpcomingBoosts();
        }
        else {
            unSubscribeOnTimerTick();
            eventDispatcher.dispatchEvent(new Event(ACTIVE_SERVER_BOOST_COMPLETED));
        }
    }

    private static function refreshActiveBoosts():void {
        var _loc2_:GlobalEvent = null;
        var _loc4_:UserBlackMarketData = null;
        var _loc5_:int = 0;
        if (_activeServerBoosts == null) {
            return;
        }
        var _loc1_:Date = ServerTimeManager.serverTimeNow;
        var _loc3_:int = _activeServerBoosts.length - 1;
        while (_loc3_ >= 0) {
            _loc2_ = _activeServerBoosts[_loc3_];
            if (_loc1_.time > _loc2_.dateFilter.dateTo.time) {
                _activeServerBoosts.splice(_loc3_, 1);
            }
            _loc3_--;
        }
        if (_activeServerBoostObjects.length > 0) {
            _loc4_ = UserManager.user.gameData.blackMarketData;
            _loc5_ = _activeServerBoostObjects.length - 1;
            while (_loc5_ >= 0) {
                if (_activeServerBoostObjects[_loc5_] != null) {
                    if (_loc1_.time > _activeServerBoostObjects[_loc5_].dateFilter.dateTo.time) {
                        _activeServerBoostObjects.splice(_loc5_, 1);
                        _loc4_.dirty = true;
                        _loc4_.dispatchEvents();
                        eventDispatcher.dispatchEvent(new Event(ACTIVE_SERVER_BOOST_COMPLETED));
                    }
                }
                _loc5_--;
            }
        }
    }

    private static function refreshUpcomingBoosts():void {
        var _loc2_:GlobalEvent = null;
        var _loc4_:int = 0;
        if (_upcomingServerBoosts == null) {
            return;
        }
        var _loc1_:Date = ServerTimeManager.serverTimeNow;
        var _loc3_:int = _upcomingServerBoosts.length - 1;
        while (_loc3_ >= 0) {
            _loc2_ = _upcomingServerBoosts[_loc3_];
            if (_loc1_.time > _loc2_.dateFilter.dateFrom.time) {
                _upcomingServerBoosts.splice(_loc3_, 1);
                _activeServerBoosts.push(_loc2_);
            }
            _loc3_--;
        }
        if (_upcomingServerBoostObjects.length > 0) {
            _loc4_ = _upcomingServerBoostObjects.length - 1;
            while (_loc4_ >= 0) {
                if (_upcomingServerBoostObjects[_loc4_] != null) {
                    if (_loc1_.time > _upcomingServerBoostObjects[_loc4_].dateFilter.dateFrom.time) {
                        _activeServerBoostObjects.push(_upcomingServerBoostObjects[_loc4_]);
                        _upcomingServerBoostObjects.splice(_loc4_, 1);
                        eventDispatcher.dispatchEvent(new Event(UPCOMING_SERVER_BOOST_COMPLETED));
                    }
                }
                _loc4_--;
            }
        }
    }

    public static function getServerBoostValueByTypeId(param1:int):Number {
        var typeId:int = param1;
        var boostValue:Number = 0;
        if (hasActiveServerBoost) {
            boostValue = query(_activeServerBoosts).where(function (param1:GlobalEvent):Boolean {
                return param1.globalEventServerBoostData.typeId == typeId;
            }).sum(function (param1:GlobalEvent):Number {
                return param1.globalEventServerBoostData.boostValue;
            });
        }
        return boostValue;
    }

    public static function getServerBoostObjectByTypeId(param1:int):GlobalEventItem {
        var result:GlobalEventItem = null;
        var typeId:int = param1;
        if (hasActiveServerBoost) {
            result = query(_activeServerBoostObjects).firstOrDefault(function (param1:GlobalEventItem):Boolean {
                return param1.typeIds[0] == typeId;
            });
        }
        return result;
    }

    public static function buildActiveServerBoostObjectsArray():void {
        var _loc1_:GlobalEventItem = null;
        var _loc2_:GlobalEvent = null;
        if (_activeServerBoostObjects != null) {
            return;
        }
        _activeServerBoostObjects = [];
        for each(_loc2_ in _activeServerBoosts) {
            _loc1_ = new GlobalEventItem();
            _loc1_.id = _loc2_.id;
            _loc1_.isUpcoming = false;
            _loc1_.iconUrl = _loc2_.globalEventServerBoostData.iconUrl;
            _loc1_.typeIds = [_loc2_.globalEventServerBoostData.typeId];
            _loc1_.value = _loc2_.globalEventServerBoostData.boostValue;
            _loc1_.pictureUrl = _loc2_.globalEventServerBoostData.activeEventPictureUrl;
            _loc1_.text = _loc2_.globalEventServerBoostData.activeEventText;
            _loc1_.dateFilter = _loc2_.dateFilter;
            _activeServerBoostObjects.push(_loc1_);
        }
        _activeServerBoostObjects = sortServerBoostsArray(_activeServerBoostObjects);
    }

    public static function buildUpcomingServerBoostObjectsArray():void {
        var _loc1_:GlobalEventItem = null;
        var _loc2_:GlobalEvent = null;
        if (_upcomingServerBoostObjects != null) {
            return;
        }
        _upcomingServerBoostObjects = [];
        for each(_loc2_ in _upcomingServerBoosts) {
            _loc1_ = new GlobalEventItem();
            _loc1_.id = _loc2_.id;
            _loc1_.isUpcoming = true;
            _loc1_.iconUrl = _loc2_.globalEventServerBoostData.iconUrl;
            _loc1_.typeIds = [_loc2_.globalEventServerBoostData.typeId];
            _loc1_.value = _loc2_.globalEventServerBoostData.boostValue;
            _loc1_.pictureUrl = _loc2_.globalEventServerBoostData.activeEventPictureUrl;
            _loc1_.text = _loc2_.globalEventServerBoostData.activeEventText;
            _loc1_.dateFilter = _loc2_.dateFilter;
            _upcomingServerBoostObjects.push(_loc1_);
        }
        _upcomingServerBoostObjects = sortServerBoostsArray(_upcomingServerBoostObjects);
    }

    public static function sortServerBoostsArray(param1:Array):Array {
        var array:Array = param1;
        return query(array).where(function (param1:GlobalEventItem):Boolean {
            return param1.dateFilter != null && param1.dateFilter.dateTo != null;
        }).orderBy(function (param1:GlobalEventItem):Date {
            return param1.dateFilter.dateTo;
        }).toArray();
    }
}
}
