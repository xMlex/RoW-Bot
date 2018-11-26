package model.data.units {
import common.ArrayCustom;
import common.GameType;
import common.ObjectUtil;

import configs.Global;

import model.data.scenes.types.info.TroopsTypeId;
import model.data.units.payloads.TradingOfferPayload;
import model.data.units.payloads.TradingPayload;
import model.data.units.payloads.TroopsPayload;
import model.data.units.states.UnitStateCancelationFailed;
import model.data.units.states.UnitStateCanceling;
import model.data.units.states.UnitStateInSector;
import model.data.units.states.UnitStateMoving;
import model.data.units.states.UnitStatePendingArrival;
import model.data.units.states.UnitStatePendingDepartureBack;
import model.data.users.misc.UserResourceFlow;
import model.data.users.troops.Troops;
import model.data.users.troops.TroopsOrderId;
import model.logic.UserManager;
import model.logic.dtoSerializer.DtoDeserializer;

public class Unit {


    public var UnitId:Number;

    public var OwnerUserId:Number;

    public var TargetUserId:Number;

    public var TargetTypeId:int;

    public var StateMovingForward:UnitStateMoving;

    public var StateMovingBack:UnitStateMoving;

    public var StateInTargetSector:UnitStateInSector;

    public var StatePendingArrival:UnitStatePendingArrival;

    public var StatePendingDepartureBack:UnitStatePendingDepartureBack;

    public var StateCanceling:UnitStateCanceling;

    public var StateCancelationFailed:UnitStateCancelationFailed;

    public var tradingPayload:TradingPayload;

    public var tradingOfferPayload:TradingOfferPayload;

    public var troopsPayload:TroopsPayload;

    public var appliedEffectsPowerByTypeId:Object;

    public var progressPercentage:Number = 0;

    public var arrivedInSeconds:Number;

    public function Unit() {
        super();
    }

    public static function fromDto(param1:*):Unit {
        if (param1 == null) {
            return null;
        }
        var _loc2_:Unit = new Unit();
        _loc2_.UnitId = param1.i;
        _loc2_.OwnerUserId = param1.o;
        _loc2_.TargetUserId = param1.t;
        if (param1.u) {
            _loc2_.TargetTypeId = param1.u;
        }
        _loc2_.StateMovingForward = param1.sf == null ? null : UnitStateMoving.fromDto(param1.sf);
        _loc2_.StateMovingBack = param1.sb == null ? null : UnitStateMoving.fromDto(param1.sb);
        _loc2_.StateInTargetSector = param1.ss == null ? null : UnitStateInSector.fromDto(param1.ss);
        _loc2_.StatePendingArrival = param1.sp == null ? null : UnitStatePendingArrival.fromDto(param1.sp);
        _loc2_.StatePendingDepartureBack = param1.sr == null ? null : UnitStatePendingDepartureBack.fromDto(param1.sr);
        _loc2_.StateCanceling = param1.sc == null ? null : UnitStateCanceling.fromDto(param1.sc);
        _loc2_.StateCancelationFailed = param1.sa == null ? null : UnitStateCancelationFailed.fromDto(param1.sa);
        _loc2_.tradingPayload = param1.pd == null ? null : TradingPayload.fromDto(param1.pd);
        _loc2_.tradingOfferPayload = param1.po == null ? null : TradingOfferPayload.fromDto(param1.po);
        _loc2_.troopsPayload = param1.pt == null ? null : TroopsPayload.fromDto(param1.pt);
        _loc2_.appliedEffectsPowerByTypeId = param1.e == null ? null : DtoDeserializer.toObject(param1.e);
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
        var _loc3_:Unit = null;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function get TargetLocationId():Number {
        return -this.TargetUserId;
    }

    public function set TargetLocationId(param1:Number):void {
        this.TargetUserId = -param1;
    }

    public function get TargetIsLocation():Boolean {
        return this.TargetUserId < 0;
    }

    private function ResetState():void {
        this.StateMovingForward = null;
        this.StateMovingBack = null;
        this.StateInTargetSector = null;
        this.StatePendingArrival = null;
        this.StatePendingDepartureBack = null;
        this.StateCanceling = null;
        this.StateCancelationFailed = null;
    }

    public function MoveBack(param1:Date, param2:Number):void {
        this.ResetState();
        this.StateMovingBack = new UnitStateMoving();
        this.StateMovingBack.departureTime = param1;
        this.StateMovingBack.arrivalTime = new Date(param1.time + param2);
    }

    public function StayInSector():void {
        this.ResetState();
        this.StateInTargetSector = new UnitStateInSector();
    }

    public function WaitArrival():void {
        this.ResetState();
        this.StatePendingArrival = new UnitStatePendingArrival();
    }

    public function getOrderId():int {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        if (this.troopsPayload) {
            _loc2_ = !!GameType.isTotalDomination ? int(TroopsTypeId.SectorMissile) : int(TroopsTypeId.SectorMissileStrong);
            if (this.OwnerUserId == UserManager.user.id && this.troopsPayload.troops.get(_loc2_) > 0 && !this.StateMovingForward) {
                _loc1_ = TroopsOrderId.MissileStrike;
            }
            else if (this.OwnerUserId == UserManager.user.id && this.troopsPayload.order != TroopsOrderId.Bunker && this.StateMovingBack != null) {
                _loc1_ = TroopsOrderId.Return;
            }
            else {
                _loc1_ = this.troopsPayload.order;
            }
        }
        else if (this.tradingPayload) {
            if (this.tradingPayload.resources) {
                _loc1_ = TroopsOrderId.Resources;
            }
            else if (this.tradingPayload.drawingPart) {
                _loc1_ = TroopsOrderId.Draws;
            }
            else {
                _loc1_ = -1;
            }
        }
        return _loc1_;
    }

    public function ResetPayloads():void {
        this.tradingPayload = null;
        this.tradingOfferPayload = null;
        this.troopsPayload = null;
    }

    public function MergeTroopsPayload(param1:TroopsPayload):void {
        var _loc2_:TroopsPayload = this.troopsPayload;
        this.troopsPayload = new TroopsPayload();
        this.troopsPayload.order = _loc2_.order;
        this.troopsPayload.troops = Troops.addTroopsS(_loc2_.troops, param1.troops);
    }

    public function MergeTroopsPayloadByTroops(param1:Troops):void {
        var _loc2_:TroopsPayload = this.troopsPayload;
        this.troopsPayload = new TroopsPayload();
        this.troopsPayload.order = _loc2_.order;
        this.troopsPayload.troops = Troops.addTroopsS(_loc2_.troops, param1);
    }

    public function FlushTradingPayload():void {
        var _loc1_:TradingPayload = this.tradingPayload;
        this.tradingPayload = new TradingPayload();
        this.tradingPayload.numberOfCaravans = _loc1_.numberOfCaravans;
        this.tradingPayload.resources = null;
        this.tradingPayload.drawingPart = null;
    }

    public function get arrivedInAsString():String {
        var _loc1_:int = this.arrivedInSeconds / 60 / 60;
        var _loc2_:String = _loc1_ < 10 ? "0" + _loc1_ : _loc1_.toString();
        _loc1_ = this.arrivedInSeconds / 60 % 60;
        _loc2_ = _loc2_ + (_loc1_ < 10 ? ":0" + _loc1_ : ":" + _loc1_);
        _loc1_ = this.arrivedInSeconds % 60;
        _loc2_ = _loc2_ + (_loc1_ < 10 ? ":0" + _loc1_ : ":" + _loc1_);
        return _loc2_;
    }

    public function getArrivalTime():Date {
        if (this.StateMovingForward != null) {
            return this.StateMovingForward.arrivalTime;
        }
        if (this.StateMovingBack != null) {
            return this.StateMovingBack.arrivalTime;
        }
        return null;
    }

    public function getDepartureTime():Date {
        if (this.StateMovingForward != null) {
            return this.StateMovingForward.departureTime;
        }
        if (this.StateMovingBack != null) {
            return this.StateMovingBack.departureTime;
        }
        return null;
    }

    public function possibilityCancelUnitByItem():Boolean {
        return !(this.troopsPayload && this.troopsPayload.order == TroopsOrderId.MissileStrike) && this.StateMovingForward != null && this.StateMovingForward.canceling == false && this.StateMovingBack == null && this.tradingOfferPayload == null && this.allowCancelByCheatgrab && this.OwnerUserId == UserManager.user.id;
    }

    private function get allowCancelByCheatgrab():Boolean {
        var _loc2_:UserResourceFlow = null;
        var _loc3_:Number = NaN;
        var _loc1_:* = true;
        if (Global.ADDITIONAL_ROBBERY_ENABLED && this.tradingOfferPayload == null && this.tradingPayload && this.tradingPayload.resources) {
            _loc2_ = UserManager.user.gameData.worldData.getOrAddResourcesFlow(this.TargetUserId);
            _loc3_ = _loc2_ == null ? Number(0) : Number(_loc2_.getResources(UserManager.user.gameData.normalizationTime));
            _loc1_ = Math.abs(_loc3_ + this.tradingPayload.resources.capacity()) < Global.serverSettings.unit.userResourcesFlowLimit;
        }
        return _loc1_;
    }

    public function get canceling():Boolean {
        if (this.StateMovingForward == null) {
            return false;
        }
        return this.StateMovingForward.canceling;
    }

    public function get moving():Boolean {
        return this.StateMovingBack || this.StateMovingForward;
    }

    public function get pending():Boolean {
        return this.StatePendingArrival || this.StatePendingDepartureBack;
    }

    public function get isMyUnit():Boolean {
        return this.OwnerUserId == UserManager.user.id;
    }

    public function equalOwnerAndTarget(param1:Unit):Boolean {
        return this.TargetTypeId == param1.TargetTypeId && this.TargetUserId == param1.TargetUserId && this.TargetLocationId == param1.TargetLocationId && this.OwnerUserId == param1.OwnerUserId;
    }

    public function directionChanged(param1:Unit):Boolean {
        return this.StateMovingForward != param1.StateMovingForward || this.StateMovingBack != param1.StateMovingBack || this.StateInTargetSector != param1.StateInTargetSector || this.StatePendingArrival != param1.StatePendingArrival || this.StatePendingDepartureBack != param1.StatePendingDepartureBack || this.StateCanceling != param1.StateCanceling || this.StateCancelationFailed != param1.StateCancelationFailed;
    }

    public function clone():Unit {
        return ObjectUtil.trueClone(this) as Unit;
    }

    public function fromClone(param1:Unit):void {
        this.UnitId = param1.UnitId;
        this.OwnerUserId = param1.OwnerUserId;
        this.TargetUserId = param1.TargetUserId;
        this.TargetTypeId = param1.TargetTypeId;
        this.StateMovingForward = param1.StateMovingForward;
        this.StateMovingBack = param1.StateMovingBack;
        this.StateInTargetSector = param1.StateInTargetSector;
        this.StatePendingArrival = param1.StatePendingArrival;
        this.StatePendingDepartureBack = param1.StatePendingDepartureBack;
        this.StateCanceling = param1.StateCanceling;
        this.StateCancelationFailed = param1.StateCancelationFailed;
        this.tradingPayload = param1.tradingPayload;
        this.tradingOfferPayload = param1.tradingOfferPayload;
        this.troopsPayload = param1.troopsPayload;
        this.appliedEffectsPowerByTypeId = param1.appliedEffectsPowerByTypeId;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.UnitId,
            "o": this.OwnerUserId,
            "t": this.TargetUserId,
            "u": this.TargetTypeId,
            "sf": (this.StateMovingForward == null ? null : this.StateMovingForward.toDto()),
            "sb": (this.StateMovingBack == null ? null : this.StateMovingBack.toDto()),
            "ss": (this.StateInTargetSector == null ? null : this.StateInTargetSector.toDto()),
            "sp": (this.StatePendingArrival == null ? null : this.StatePendingArrival.toDto()),
            "sr": (this.StatePendingDepartureBack == null ? null : this.StatePendingDepartureBack.toDto()),
            "sc": (this.StateCanceling == null ? null : this.StateCanceling.toDto()),
            "sa": (this.StateCancelationFailed == null ? null : this.StateCancelationFailed.toDto()),
            "pd": (this.tradingPayload == null ? null : this.tradingPayload.toDto()),
            "po": (this.tradingOfferPayload == null ? null : this.tradingOfferPayload.toDto()),
            "pt": (this.troopsPayload == null ? null : this.troopsPayload.toDto()),
            "e": (this.appliedEffectsPowerByTypeId == null ? null : this.appliedEffectsPowerByTypeId)
        };
        return _loc1_;
    }
}
}
