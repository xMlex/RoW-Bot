package model.data.users.troops {
import common.ArrayCustom;
import common.GameType;

import flash.events.Event;

import gameObjects.observableObject.ObservableObject;
import gameObjects.observableObject.ObservableObjectEvent;

import model.data.User;
import model.data.normalization.INEvent;
import model.data.normalization.INormalizable;
import model.data.scenes.objects.info.ConstructionObjInfo;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.TroopsGroupId;
import model.data.scenes.types.info.TroopsKindId;
import model.data.scenes.types.info.TroopsTypeId;
import model.logic.StaticDataManager;

public class TroopsFactory extends ObservableObject implements INormalizable {

    public static const CLASS_NAME:String = "TroopsFactory";

    public static const ORDER_ADDED:String = CLASS_NAME + "OrderAdded";

    public static const ORDER_REMOVED:String = CLASS_NAME + "OrderRemoved";

    public static const COUNT_CHANGE:String = CLASS_NAME + "CountChange";

    public static const ORDER_SET_TIME:String = CLASS_NAME + "OrderSetTime";

    public static const ORDER_FINISHED:String = CLASS_NAME + "OrderFinished";


    public var nextOrderId:int;

    public var orders:ArrayCustom;

    public var extraTroopsSlots:Array;

    public function TroopsFactory() {
        this.orders = new ArrayCustom();
        super();
    }

    private static function getBuildingFinishedTime(param1:TroopsOrder, param2:Date):Date {
        if (param1.constructionObjInfo.constructionStartTime == null) {
            return null;
        }
        param1.constructionObjInfo.updatePercentage(param2);
        param1.dirtyNormalized = true;
        return param1.constructionObjInfo.constructionFinishTime;
    }

    private static function getMaxOrderSize(param1:GeoSceneObjectType):Number {
        if (GameType.isPirates) {
            if (param1.id == TroopsTypeId.DefensiveInfantryUnit3 || param1.id == TroopsTypeId.DefensiveInfantryUnit3Gold || param1.id == TroopsTypeId.DefensiveInfantryUnit4 || param1.id == TroopsTypeId.DefensiveInfantryUnit4Gold) {
                return 50;
            }
            if (param1.id == TroopsTypeId.IncubatorUnit1 || param1.id == TroopsTypeId.IncubatorUnit1Gold) {
                return 17;
            }
            if (param1.id == TroopsTypeId.IncubatorUnit2 || param1.id == TroopsTypeId.IncubatorUnit2Gold) {
                return 3;
            }
        }
        if (param1.id == TroopsTypeId.SpecialForcesInfantryUnit1 || param1.id == TroopsTypeId.SpecialForcesInfantryUnit1Gold) {
            return 50;
        }
        if (param1.id == TroopsTypeId.SpecialForcesInfantryUnit2 || param1.id == TroopsTypeId.SpecialForcesInfantryUnit2Gold) {
            return 50;
        }
        if (param1.id == TroopsTypeId.SpecialForcesInfantryUnit3 || param1.id == TroopsTypeId.SpecialForcesInfantryUnit3Gold) {
            return 25;
        }
        if (param1.id == TroopsTypeId.SpecialForcesInfantryUnit4 || param1.id == TroopsTypeId.SpecialForcesInfantryUnit4Gold) {
            return 10;
        }
        if (param1.id == TroopsTypeId.IncubatorUnit4 || param1.id == TroopsTypeId.IncubatorUnit4Gold) {
            return 8;
        }
        switch (param1.troopsInfo.groupId) {
            case TroopsGroupId.INFANTRY:
            case TroopsGroupId.INFANTRY_2:
                return 100;
            case TroopsGroupId.ARMOURED:
            case TroopsGroupId.ARMOURED_2:
                return 25;
            case TroopsGroupId.ARTILLERY:
            case TroopsGroupId.ARTILLERY_2:
                return 10;
            case TroopsGroupId.AEROSPACE:
            case TroopsGroupId.AEROSPACE_2:
                return param1.troopsInfo.kindId == TroopsKindId.RECON ? Number(25) : Number(5);
            case TroopsGroupId.AVP:
                return 50;
            default:
                return Number.MAX_VALUE;
        }
    }

    public static function fromDto(param1:*):TroopsFactory {
        var _loc2_:TroopsFactory = new TroopsFactory();
        _loc2_.nextOrderId = param1.i;
        _loc2_.orders = param1.o == null ? null : TroopsOrder.fromDtos(param1.o);
        _loc2_.extraTroopsSlots = param1.s == null ? [] : new Array(param1.s);
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function toDtos(param1:ArrayCustom):Array {
        var _loc3_:TroopsFactory = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function addOrder(param1:GeoSceneObjectType, param2:int, param3:Date, param4:Date):void {
        var _loc6_:TroopsOrder = null;
        var _loc7_:Number = NaN;
        var _loc8_:TroopsOrder = null;
        var _loc5_:Number = getMaxOrderSize(param1);
        while (param2 > 0) {
            _loc6_ = this.getLastOrder(param1.troopsInfo.groupId);
            if (_loc6_ != null && _loc6_.typeId == param1.id && _loc6_.totalCount < _loc5_) {
                _loc7_ = Math.min(_loc5_ - _loc6_.totalCount, param2);
                _loc6_.totalCount = _loc6_.totalCount + _loc7_;
                _loc6_.pendingCount = _loc6_.pendingCount + _loc7_;
                _loc6_.dirtyNormalized = true;
                dispatch(new Event(COUNT_CHANGE));
            }
            else {
                _loc7_ = Math.min(_loc5_, param2);
                _loc8_ = new TroopsOrder(++this.nextOrderId, param1.id, _loc7_);
                _loc8_.constructionObjInfo = new ConstructionObjInfo();
                if (_loc6_ == null) {
                    _loc8_.constructionObjInfo.constructionStartTime = param3;
                    _loc8_.constructionObjInfo.constructionFinishTime = param4;
                }
                this.orders.addItem(_loc8_);
                this.fireOrderAdded(_loc8_.id);
            }
            param2 = param2 - _loc7_;
        }
    }

    public function addOrder2(param1:TroopsOrder):void {
        if (this.getOrder(param1.id) != null) {
            throw new Error("Order with same id already added");
        }
        this.orders.addItem(param1);
        this.fireOrderAdded(param1.id);
    }

    public function removeOrder(param1:TroopsOrder):void {
        var _loc2_:int = this.orders.getItemIndex(param1);
        if (_loc2_ == -1) {
            return;
        }
        var _loc3_:Object = this.orders.removeItemAt(_loc2_);
        if (_loc3_ != null) {
            this.fireOrderRemoved(param1.id);
        }
    }

    public function getOrdersTroopsByGroupId():Object {
        var _loc2_:TroopsOrder = null;
        var _loc1_:Object = {};
        _loc1_[TroopsGroupId.INFANTRY] = 0;
        _loc1_[TroopsGroupId.ARTILLERY] = 0;
        _loc1_[TroopsGroupId.ARMOURED] = 0;
        _loc1_[TroopsGroupId.AEROSPACE] = 0;
        _loc1_[TroopsGroupId.AVP] = 0;
        for each(_loc2_ in this.orders) {
            switch (StaticDataManager.getObjectType(_loc2_.typeId).troopsInfo.groupId) {
                case TroopsGroupId.INFANTRY:
                    _loc1_[TroopsGroupId.INFANTRY] = _loc1_[TroopsGroupId.INFANTRY] + _loc2_.pendingCount;
                    continue;
                case TroopsGroupId.INFANTRY + 1:
                    _loc1_[TroopsGroupId.INFANTRY] = _loc1_[TroopsGroupId.INFANTRY] + _loc2_.pendingCount;
                    continue;
                case TroopsGroupId.ARTILLERY:
                    _loc1_[TroopsGroupId.ARTILLERY] = _loc1_[TroopsGroupId.ARTILLERY] + _loc2_.pendingCount;
                    continue;
                case TroopsGroupId.ARTILLERY + 1:
                    _loc1_[TroopsGroupId.ARTILLERY] = _loc1_[TroopsGroupId.ARTILLERY] + _loc2_.pendingCount;
                    continue;
                case TroopsGroupId.ARMOURED:
                    _loc1_[TroopsGroupId.ARMOURED] = _loc1_[TroopsGroupId.ARMOURED] + _loc2_.pendingCount;
                    continue;
                case TroopsGroupId.ARMOURED + 1:
                    _loc1_[TroopsGroupId.ARMOURED] = _loc1_[TroopsGroupId.ARMOURED] + _loc2_.pendingCount;
                    continue;
                case TroopsGroupId.AEROSPACE:
                    _loc1_[TroopsGroupId.AEROSPACE] = _loc1_[TroopsGroupId.AEROSPACE] + _loc2_.pendingCount;
                    continue;
                case TroopsGroupId.AEROSPACE + 1:
                    _loc1_[TroopsGroupId.AEROSPACE] = _loc1_[TroopsGroupId.AEROSPACE] + _loc2_.pendingCount;
                    continue;
                case TroopsGroupId.AVP:
                    _loc1_[TroopsGroupId.AVP] = _loc1_[TroopsGroupId.AVP] + _loc2_.pendingCount;
                    continue;
                case TroopsGroupId.AVP + 1:
                    _loc1_[TroopsGroupId.AVP] = _loc1_[TroopsGroupId.AVP] + _loc2_.pendingCount;
                    continue;
                default:
                    continue;
            }
        }
        return _loc1_;
    }

    public function getOrders(param1:int, param2:int = 0):Array {
        var _loc5_:TroopsOrder = null;
        var _loc3_:Array = new Array();
        var _loc4_:int = 0;
        for each(_loc5_ in this.orders) {
            if (param2 > 0 && _loc4_ >= param2) {
                break;
            }
            if (StaticDataManager.getObjectType(_loc5_.typeId).troopsInfo.groupId == param1) {
                _loc3_.push(_loc5_);
                _loc4_++;
            }
        }
        return _loc3_;
    }

    public function getFirstOrder(param1:int):TroopsOrder {
        var _loc3_:TroopsOrder = null;
        var _loc2_:int = 0;
        while (_loc2_ < this.orders.length) {
            _loc3_ = this.orders[_loc2_];
            if (StaticDataManager.getObjectType(_loc3_.typeId).troopsInfo.groupId == param1) {
                return _loc3_;
            }
            _loc2_++;
        }
        return null;
    }

    public function getLastOrder(param1:int):TroopsOrder {
        var _loc3_:TroopsOrder = null;
        var _loc2_:int = this.orders.length - 1;
        while (_loc2_ >= 0) {
            _loc3_ = this.orders[_loc2_];
            if (StaticDataManager.getObjectType(_loc3_.typeId).troopsInfo.groupId == param1) {
                return _loc3_;
            }
            _loc2_--;
        }
        return null;
    }

    public function getOrdersInProgress():Array {
        var _loc2_:TroopsOrder = null;
        var _loc1_:Array = new Array();
        for each(_loc2_ in this.orders) {
            if (_loc2_.constructionInfo.constructionStartTime != null) {
                _loc1_.push(_loc2_);
            }
        }
        return _loc1_;
    }

    public function getOrder(param1:Number):TroopsOrder {
        var _loc2_:TroopsOrder = null;
        for each(_loc2_ in this.orders) {
            if (_loc2_.id == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function getNextEvent(param1:User, param2:Date):INEvent {
        var _loc3_:* = this.getNextFinishedOrder(param2);
        return _loc3_ == null ? null : new NEventTroopsFinished(this, _loc3_.order, _loc3_.time);
    }

    private function getNextFinishedOrder(param1:Date):* {
        var _loc4_:TroopsOrder = null;
        var _loc5_:Date = null;
        var _loc2_:TroopsOrder = null;
        var _loc3_:Date = new Date(param1);
        for each(_loc4_ in this.orders) {
            _loc5_ = _loc4_.boostNormalizationTime != null ? _loc4_.boostNormalizationTime : getBuildingFinishedTime(_loc4_, _loc3_);
            if (!(_loc5_ == null || _loc5_ > param1)) {
                _loc2_ = _loc4_;
                param1 = _loc5_;
            }
        }
        return _loc2_ == null ? null : {
            "time": param1,
            "order": _loc2_
        };
    }

    private function fireOrderAdded(param1:int):void {
        this.fireOrderEvent(ORDER_ADDED, param1);
    }

    public function orderSetTime(param1:int):void {
        this.fireOrderEvent(ORDER_SET_TIME, param1);
    }

    private function fireOrderRemoved(param1:int):void {
        this.fireOrderEvent(ORDER_REMOVED, param1);
    }

    private function fireOrderEvent(param1:String, param2:int):void {
        var _loc3_:TroopsOrderEvent = new TroopsOrderEvent(param1, this, param2);
        dispatch(_loc3_);
    }

    public function dispatchEvents():void {
        var _loc1_:TroopsOrder = null;
        for each(_loc1_ in this.orders) {
            _loc1_.dispatchEvents();
        }
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.nextOrderId,
            "o": (this.orders == null ? null : TroopsOrder.toDtos(this.orders))
        };
        return _loc1_;
    }

    public function finishOrder(param1:TroopsOrder):void {
        var _loc2_:ObservableObjectEvent = new ObservableObjectEvent(ORDER_FINISHED, param1);
        dispatch(_loc2_);
    }
}
}
