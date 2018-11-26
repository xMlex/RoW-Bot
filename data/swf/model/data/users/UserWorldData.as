package model.data.users {
import common.ArrayCustom;

import configs.Global;

import gameObjects.observableObject.ObservableObject;

import model.data.Resources;
import model.data.User;
import model.data.normalization.INEvent;
import model.data.normalization.INormalizable;
import model.data.units.Unit;
import model.data.units.filters.UnitFilterOwnerId;
import model.data.units.filters.UnitFilterStateId;
import model.data.units.filters.UnitFilterTypeId;
import model.data.units.payloads.SupportTroops;
import model.data.units.payloads.TradingPayload;
import model.data.units.states.UnitStateMoving;
import model.data.users.misc.UserResourceFlow;
import model.data.users.troops.Troops;
import model.data.users.troops.TroopsOrderId;
import model.logic.StaticDataManager;
import model.logic.StaticKnownUsersData;
import model.logic.units.NEventMissileStrikeAvailable;
import model.logic.units.NEventRobberyAvailable;
import model.logic.units.NEventUnitArrived;

public class UserWorldData extends ObservableObject implements INormalizable {

    public static const CLASS_NAME:String = "UserWorldData";

    public static const UNITS_LIST_CHANGED:String = CLASS_NAME + "UnitsListChanged";

    public static const UNITS_MOVED:String = CLASS_NAME + "UnitsMoved";

    public static const ROBBERY_COUNTER_UPDATED:String = CLASS_NAME + "RobberyCounterUpdated";

    public static const MISSILE_COUNTER_UPDATED:String = CLASS_NAME + "MissileCounterUpdated";


    public var units:ArrayCustom;

    public var robberyCounter:int;

    public var nextAvailableRobberyDate:Date;

    public var missileStrikesCounter:int;

    public var nextAvailableMissileStrikeDate:Date;

    public var drawingCaravansSentToday:int;

    public var resourceCaravansSentToday:int;

    public var resourcesFlow:ArrayCustom;

    public var incomingResourcesToday:Resources;

    public var dirtyUnitListChanged:Boolean = false;

    public var dirtyUnitsMoved:Boolean = false;

    public var dirtyRobberyCounter:Boolean = false;

    public var dirtyMissileStrikeCounter:Boolean = false;

    public var lastMissileStrikeDate:Date;

    public var resourcesRobbed:Number;

    public var lastResourcesRobbedDate:Date;

    public function UserWorldData() {
        super();
    }

    public static function getUnits(param1:User, param2:int = -1, param3:int = -1, param4:int = -1, param5:int = -1):ArrayCustom {
        var _loc7_:Unit = null;
        var _loc6_:ArrayCustom = new ArrayCustom();
        for each(_loc7_ in param1.gameData.worldData.units) {
            if (_loc7_.OwnerUserId != param1.id && _loc7_.troopsPayload != null) {
                if (_loc7_.troopsPayload.order == TroopsOrderId.Intelligence) {
                    continue;
                }
            }
            if ((param2 & UnitFilterTypeId.Trading) != UnitFilterTypeId.Trading) {
                if (_loc7_.tradingPayload != null) {
                    continue;
                }
            }
            if ((param2 & UnitFilterTypeId.Troops) != UnitFilterTypeId.Troops) {
                if (_loc7_.troopsPayload != null) {
                    continue;
                }
            }
            if ((param3 & UnitFilterStateId.Incoming) != UnitFilterStateId.Incoming) {
                if (_loc7_.OwnerUserId == param1.id && (_loc7_.StateMovingBack || _loc7_.StatePendingDepartureBack)) {
                    continue;
                }
                if (_loc7_.TargetUserId == param1.id && _loc7_.StateMovingForward && _loc7_.troopsPayload != null && _loc7_.troopsPayload.order != TroopsOrderId.Bunker) {
                    continue;
                }
            }
            if ((param3 & UnitFilterStateId.Outgoing) != (UnitFilterStateId.Outgoing || _loc7_.StatePendingArrival)) {
                if (_loc7_.OwnerUserId == param1.id && _loc7_.StateMovingForward) {
                    continue;
                }
                if (_loc7_.TargetUserId == param1.id && _loc7_.StateMovingBack && _loc7_.troopsPayload != null && _loc7_.troopsPayload.order != TroopsOrderId.Bunker) {
                    continue;
                }
                if (_loc7_.troopsPayload && _loc7_.troopsPayload.isSupportedBy(param1.id)) {
                    continue;
                }
            }
            if ((param3 & UnitFilterStateId.InThisSector) != UnitFilterStateId.InThisSector) {
                if (_loc7_.TargetUserId == param1.id && _loc7_.StateInTargetSector && _loc7_.troopsPayload != null && _loc7_.troopsPayload.order != TroopsOrderId.Bunker) {
                    continue;
                }
            }
            if ((param3 & UnitFilterStateId.InOtherSector) != UnitFilterStateId.InOtherSector) {
                if (_loc7_.OwnerUserId == param1.id && _loc7_.StateInTargetSector) {
                    continue;
                }
            }
            if ((param4 & UnitFilterOwnerId.ThisUser) != UnitFilterOwnerId.ThisUser) {
                if (_loc7_.OwnerUserId == param1.id) {
                    continue;
                }
            }
            if ((param4 & UnitFilterOwnerId.Ally) != UnitFilterOwnerId.Ally) {
                if (_loc7_.OwnerUserId != param1.id && (_loc7_.tradingPayload || _loc7_.troopsPayload && !_loc7_.troopsPayload.isSupportedBy(param1.id) && _loc7_.troopsPayload.order == TroopsOrderId.Reinforcement)) {
                    continue;
                }
            }
            if ((param4 & UnitFilterOwnerId.Enemy) != UnitFilterOwnerId.Enemy) {
                if (_loc7_.OwnerUserId != param1.id && _loc7_.troopsPayload && !_loc7_.troopsPayload.isSupportedBy(param1.id) && _loc7_.troopsPayload.order != TroopsOrderId.Reinforcement) {
                    continue;
                }
            }
            if (!(_loc7_.troopsPayload != null && !(param5 == _loc7_.troopsPayload.order || param5 == TroopsOrderId.All))) {
                if (!(_loc7_.tradingPayload && _loc7_.tradingPayload.resources && !(param5 == TroopsOrderId.Resources || param5 == TroopsOrderId.All))) {
                    if (!(_loc7_.tradingPayload && _loc7_.tradingPayload.drawingPart && !(param5 == TroopsOrderId.Draws || param5 == TroopsOrderId.All))) {
                        if (!(_loc7_.tradingPayload && (_loc7_.tradingPayload.resources || _loc7_.tradingPayload.drawingPart) && !(param5 == TroopsOrderId.Caravan || param5 == TroopsOrderId.All))) {
                            if (!(_loc7_.tradingPayload && !_loc7_.tradingPayload.resources && !_loc7_.tradingPayload.drawingPart && !(param5 == TroopsOrderId.CaravanEmpty || param5 == TroopsOrderId.All))) {
                                _loc6_.addItem(_loc7_);
                            }
                        }
                    }
                }
            }
        }
        return _loc6_;
    }

    public static function getUnitsForMovingIconsWithAttackAndOccupation(param1:User, param2:int = -1, param3:int = -1, param4:int = -1, param5:int = -1):ArrayCustom {
        var _loc7_:Unit = null;
        var _loc6_:ArrayCustom = new ArrayCustom();
        for each(_loc7_ in param1.gameData.worldData.units) {
            if (_loc7_.OwnerUserId != param1.id && _loc7_.troopsPayload != null) {
                if (_loc7_.troopsPayload.order == TroopsOrderId.Intelligence) {
                    continue;
                }
            }
            if ((param2 & UnitFilterTypeId.Trading) != UnitFilterTypeId.Trading) {
                if (_loc7_.tradingPayload != null) {
                    continue;
                }
            }
            if ((param2 & UnitFilterTypeId.Troops) != UnitFilterTypeId.Troops) {
                if (_loc7_.troopsPayload != null) {
                    continue;
                }
            }
            if ((param3 & UnitFilterStateId.Incoming) != UnitFilterStateId.Incoming) {
                if (_loc7_.OwnerUserId == param1.id && (_loc7_.StateMovingBack || _loc7_.StatePendingDepartureBack)) {
                    continue;
                }
                if (_loc7_.TargetUserId == param1.id && _loc7_.StateMovingForward && _loc7_.troopsPayload != null && _loc7_.troopsPayload.order != TroopsOrderId.Bunker) {
                    continue;
                }
            }
            if ((param3 & UnitFilterStateId.Outgoing) != (UnitFilterStateId.Outgoing || _loc7_.StatePendingArrival)) {
                if (_loc7_.OwnerUserId == param1.id && _loc7_.StateMovingForward) {
                    continue;
                }
                if (_loc7_.TargetUserId == param1.id && _loc7_.StateMovingBack && _loc7_.troopsPayload != null && _loc7_.troopsPayload.order != TroopsOrderId.Bunker) {
                    continue;
                }
                if (_loc7_.troopsPayload && _loc7_.troopsPayload.isSupportedBy(param1.id)) {
                    continue;
                }
            }
            if ((param3 & UnitFilterStateId.InThisSector) != UnitFilterStateId.InThisSector) {
                if (_loc7_.TargetUserId == param1.id && _loc7_.StateInTargetSector && _loc7_.troopsPayload != null && _loc7_.troopsPayload.order != TroopsOrderId.Bunker) {
                    continue;
                }
            }
            if ((param3 & UnitFilterStateId.InOtherSector) != UnitFilterStateId.InOtherSector) {
                if (_loc7_.OwnerUserId == param1.id && _loc7_.StateInTargetSector) {
                    continue;
                }
            }
            if ((param4 & UnitFilterOwnerId.ThisUser) != UnitFilterOwnerId.ThisUser) {
                if (_loc7_.OwnerUserId == param1.id) {
                    continue;
                }
            }
            if ((param4 & UnitFilterOwnerId.Ally) != UnitFilterOwnerId.Ally) {
                if (_loc7_.OwnerUserId != param1.id && (_loc7_.tradingPayload || _loc7_.troopsPayload && !_loc7_.troopsPayload.isSupportedBy(param1.id) && _loc7_.troopsPayload.order == TroopsOrderId.Reinforcement)) {
                    continue;
                }
            }
            if ((param4 & UnitFilterOwnerId.Enemy) != UnitFilterOwnerId.Enemy) {
                if (_loc7_.OwnerUserId != param1.id && _loc7_.troopsPayload && !_loc7_.troopsPayload.isSupportedBy(param1.id) && _loc7_.troopsPayload.order != TroopsOrderId.Reinforcement) {
                    continue;
                }
            }
            if (!(_loc7_.troopsPayload != null && !(param5 == _loc7_.troopsPayload.order || param5 == TroopsOrderId.All || param5 == TroopsOrderId.Occupation && _loc7_.troopsPayload.order == TroopsOrderId.Attack))) {
                if (!(_loc7_.tradingPayload && _loc7_.tradingPayload.resources && !(param5 == TroopsOrderId.Resources || param5 == TroopsOrderId.All))) {
                    if (!(_loc7_.tradingPayload && _loc7_.tradingPayload.drawingPart && !(param5 == TroopsOrderId.Draws || param5 == TroopsOrderId.All))) {
                        if (!(_loc7_.tradingPayload && (_loc7_.tradingPayload.resources || _loc7_.tradingPayload.drawingPart) && !(param5 == TroopsOrderId.Caravan || param5 == TroopsOrderId.All))) {
                            if (!(_loc7_.tradingPayload && !_loc7_.tradingPayload.resources && !_loc7_.tradingPayload.drawingPart && !(param5 == TroopsOrderId.CaravanEmpty || param5 == TroopsOrderId.All))) {
                                _loc6_.addItem(_loc7_);
                            }
                        }
                    }
                }
            }
        }
        return _loc6_;
    }

    public static function unitsToTroops(param1:ArrayCustom, param2:User):Troops {
        var _loc4_:Unit = null;
        var _loc5_:SupportTroops = null;
        var _loc3_:Troops = new Troops();
        for each(_loc4_ in param1) {
            if (_loc4_.troopsPayload != null) {
                if (_loc4_.OwnerUserId == param2.id) {
                    _loc3_.addTroops(_loc4_.troopsPayload.troops);
                }
                else {
                    _loc5_ = _loc4_.troopsPayload.getSupportTroops(param2.id);
                    if (_loc5_) {
                        _loc3_.addTroops(_loc5_.troops);
                    }
                }
            }
        }
        return _loc3_;
    }

    public static function fromDto(param1:*):UserWorldData {
        var _loc2_:UserWorldData = new UserWorldData();
        _loc2_.units = Unit.fromDtos(param1.u);
        _loc2_.robberyCounter = param1.r;
        _loc2_.nextAvailableRobberyDate = param1.d == null ? null : new Date(param1.d);
        _loc2_.missileStrikesCounter = param1.s;
        _loc2_.nextAvailableMissileStrikeDate = param1.k == null ? null : new Date(param1.k);
        _loc2_.drawingCaravansSentToday = param1.x;
        _loc2_.resourceCaravansSentToday = param1.y;
        _loc2_.resourcesFlow = UserResourceFlow.fromDtos(param1.f);
        _loc2_.incomingResourcesToday = param1.g == null ? null : Resources.fromDto(param1.g);
        _loc2_.lastMissileStrikeDate = param1.h == null ? null : new Date(param1.h);
        _loc2_.resourcesRobbed = param1.q == null ? Number(0) : Number(param1.q);
        _loc2_.lastResourcesRobbedDate = param1.v == null ? null : new Date(param1.v);
        return _loc2_;
    }

    public function getUnitById(param1:int, param2:int):Unit {
        var _loc6_:Unit = null;
        var _loc3_:Unit = null;
        var _loc4_:int = this.units.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            _loc6_ = this.units[_loc5_];
            if (_loc6_.UnitId == param1 && _loc6_.OwnerUserId == param2) {
                _loc3_ = _loc6_;
                break;
            }
            _loc5_++;
        }
        return _loc3_;
    }

    public function IncRobberyCounter(param1:Date):void {
        var _loc2_:StaticKnownUsersData = StaticDataManager.knownUsersData;
        this.robberyCounter++;
        if (this.robberyCounter < _loc2_.userRobberyLimit) {
            this.nextAvailableRobberyDate = new Date(param1.time + StaticDataManager.knownUsersData.robberyCountUpdateHours * 60 * 60 * 1000);
        }
        else {
            this.nextAvailableRobberyDate = null;
            this.robberyCounter = _loc2_.userRobberyLimit;
        }
    }

    public function DecRobberyCounter(param1:Date):Boolean {
        if (this.robberyCounter <= 0) {
            if (this.nextAvailableRobberyDate != null) {
                return false;
            }
            this.robberyCounter = StaticDataManager.knownUsersData.userRobberyLimit;
        }
        this.robberyCounter--;
        this.dirtyRobberyCounter = true;
        if (this.nextAvailableRobberyDate == null) {
            this.nextAvailableRobberyDate = new Date(param1.time + StaticDataManager.knownUsersData.robberyCountUpdateHours * 60 * 60 * 1000);
        }
        return true;
    }

    public function IncMissileStrikeCounter(param1:Date):void {
        var _loc2_:StaticKnownUsersData = StaticDataManager.knownUsersData;
        this.missileStrikesCounter++;
        if (this.missileStrikesCounter < _loc2_.missileStrikesLimit) {
            this.nextAvailableMissileStrikeDate = new Date(param1.time + StaticDataManager.knownUsersData.missileCountUpdateHours * 60 * 60 * 1000);
        }
        else {
            this.nextAvailableMissileStrikeDate = null;
            this.missileStrikesCounter = _loc2_.missileStrikesLimit;
        }
    }

    public function DecMissileStrikeCounter(param1:Date):Boolean {
        if (this.missileStrikesCounter <= 0) {
            if (this.nextAvailableMissileStrikeDate != null) {
                return false;
            }
            this.missileStrikesCounter = StaticDataManager.knownUsersData.missileStrikesLimit;
        }
        this.missileStrikesCounter--;
        this.dirtyMissileStrikeCounter = true;
        if (this.nextAvailableMissileStrikeDate == null) {
            this.nextAvailableMissileStrikeDate = new Date(param1.time + StaticDataManager.knownUsersData.missileCountUpdateHours * 60 * 60 * 1000);
        }
        return true;
    }

    public function updateCaravansCounter(param1:UserResourceFlow, param2:TradingPayload):void {
        var _loc3_:StaticKnownUsersData = StaticDataManager.knownUsersData;
        var _loc4_:* = param2.resources != null;
        if (!_loc4_) {
            if (this.drawingCaravansSentToday >= _loc3_.drawingCaravansTotalDailyLimit) {
                throw new Error("Drawing caravans total daily limit reached");
            }
            this.drawingCaravansSentToday++;
        }
        else {
            if (this.resourceCaravansSentToday >= _loc3_.resourceCaravansTotalDailyLimit) {
                throw new Error("Resource caravans total daily limit reached");
            }
            if (param1.resourceCaravansSentToday >= _loc3_.resourceCaravansUserDailyLimit) {
                throw new Error("Resource caravans user daily limit reached");
            }
            this.resourceCaravansSentToday++;
            param1.resourceCaravansSentToday++;
        }
    }

    public function changeResourcesFlow(param1:User, param2:Number, param3:Resources, param4:Boolean):Number {
        return this.changeResourcesFlow2(param1, this.getOrAddResourcesFlow(param2), param3, param4);
    }

    public function changeResourcesFlow2(param1:User, param2:UserResourceFlow, param3:Resources, param4:Boolean):Number {
        return this.changeResourcesFlow4(param1, param2, param3.money + param3.uranium + param3.titanite, param4);
    }

    public function changeResourcesFlow3(param1:User, param2:Number, param3:Number, param4:Boolean):Number {
        return this.changeResourcesFlow4(param1, this.getOrAddResourcesFlow(param2), param3, param4);
    }

    public function changeResourcesFlow4(param1:User, param2:UserResourceFlow, param3:Number, param4:Boolean):Number {
        var _loc5_:Date = param1.gameData.normalizationTime;
        var _loc6_:Number = Global.serverSettings.unit.userResourcesFlowLimit;
        var _loc7_:Number = param2.getResources(_loc5_);
        var _loc8_:Number = _loc6_ - Math.abs(_loc7_ + param3);
        if (!param4 && _loc8_ < 0) {
            throw new Error("User resource flow limit reached");
        }
        param2.addResources(_loc5_, param3);
        if (_loc8_ < 0) {
            param2.addResources(_loc5_, _loc7_ + param3 < 0 ? Number(-_loc8_) : Number(_loc8_));
        }
        return _loc8_;
    }

    public function getResourceFlowRemainder(param1:Number, param2:Date):Number {
        var _loc3_:Number = Global.serverSettings.unit.userResourcesFlowLimit;
        var _loc4_:UserResourceFlow = this.getResourcesFlow(param1);
        if (_loc4_ == null) {
            return _loc3_;
        }
        return _loc3_ - Math.abs(_loc4_.getResources(param2));
    }

    public function getOrAddResourcesFlow(param1:Number):UserResourceFlow {
        var _loc2_:UserResourceFlow = this.getResourcesFlow(param1);
        if (_loc2_ == null) {
            _loc2_ = new UserResourceFlow();
            _loc2_.userId = param1;
            this.resourcesFlow.addItemAt(_loc2_, 0);
            this.shrinkResourcesFlowIfNeeded();
        }
        return _loc2_;
    }

    private function shrinkResourcesFlowIfNeeded():void {
        var _loc1_:Number = StaticDataManager.knownUsersData.resourcesFlowItemsLimit;
        while (this.resourcesFlow.length > _loc1_) {
            this.resourcesFlow.removeItemAt(_loc1_);
        }
    }

    private function getResourcesFlow(param1:Number):UserResourceFlow {
        var _loc2_:UserResourceFlow = null;
        for each(_loc2_ in this.resourcesFlow) {
            if (_loc2_.userId == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function getNextEvent(param1:User, param2:Date):INEvent {
        var _loc3_:* = this.getNextArrivedUnit(param2);
        var _loc4_:Date = this.getNextRobberyAvailableDate(param2);
        var _loc5_:Date = this.getNextMissileStrikeAvailableDate(param2);
        if (_loc3_.unit != null && (_loc4_ == null || _loc3_.time < _loc4_) && (_loc5_ == null || _loc3_.time < _loc5_)) {
            return new NEventUnitArrived(_loc3_.unit, _loc3_.time);
        }
        if (_loc4_ != null && (_loc5_ == null || _loc4_ < _loc5_)) {
            return new NEventRobberyAvailable(_loc4_);
        }
        if (_loc5_ != null) {
            return new NEventMissileStrikeAvailable(_loc5_);
        }
        return null;
    }

    private function getNextArrivedUnit(param1:Date):* {
        var _loc3_:Unit = null;
        var _loc4_:Date = null;
        var _loc2_:Unit = null;
        for each(_loc3_ in this.units) {
            _loc4_ = this.getArrivalTime(_loc3_, param1);
            if (!(_loc4_ == null || _loc4_ > param1)) {
                _loc2_ = _loc3_;
                param1 = _loc4_;
            }
        }
        return {
            "unit": _loc2_,
            "time": param1
        };
    }

    private function getArrivalTime(param1:Unit, param2:Date):Date {
        var _loc3_:UnitStateMoving = null;
        if (param1.StateMovingForward != null) {
            if (param1.StateMovingForward.canceling == false) {
                _loc3_ = param1.StateMovingForward;
            }
        }
        if (param1.StateMovingBack != null) {
            _loc3_ = param1.StateMovingBack;
        }
        if (_loc3_ != null) {
            param1.progressPercentage = (param2.time - _loc3_.departureTime.time) * 100 / (_loc3_.arrivalTime.time - _loc3_.departureTime.time);
            param1.arrivedInSeconds = (_loc3_.arrivalTime.time - param2.time) / 1000;
            this.dirtyUnitsMoved = true;
        }
        return _loc3_ == null ? null : _loc3_.arrivalTime;
    }

    private function getNextRobberyAvailableDate(param1:Date):Date {
        return this.nextAvailableRobberyDate != null && this.nextAvailableRobberyDate <= param1 ? this.nextAvailableRobberyDate : null;
    }

    private function getNextMissileStrikeAvailableDate(param1:Date):Date {
        return this.nextAvailableMissileStrikeDate != null && this.nextAvailableMissileStrikeDate <= param1 ? this.nextAvailableMissileStrikeDate : null;
    }

    public function dispatchEvents():void {
        if (this.dirtyUnitListChanged) {
            this.dirtyUnitListChanged = false;
            dispatchEvent(UNITS_LIST_CHANGED);
        }
        if (this.dirtyUnitsMoved) {
            this.dirtyUnitsMoved = false;
            dispatchEvent(UNITS_MOVED);
        }
        if (this.dirtyRobberyCounter) {
            this.dirtyRobberyCounter = false;
            dispatchEvent(ROBBERY_COUNTER_UPDATED);
        }
        if (this.dirtyMissileStrikeCounter) {
            this.dirtyMissileStrikeCounter = false;
            dispatchEvent(MISSILE_COUNTER_UPDATED);
        }
    }
}
}
