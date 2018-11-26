package model.data.users.misc {
import common.ArrayCustom;
import common.DateUtil;

import configs.Global;

import model.data.users.DailyResourceFlow;
import model.logic.StaticDataManager;

public class UserResourceFlow {


    public var userId:Number;

    public var resourceCaravansSentToday:int;

    public var dailyResourceFlows:ArrayCustom;

    public function UserResourceFlow() {
        super();
    }

    public static function fromDto(param1:*):UserResourceFlow {
        var _loc2_:UserResourceFlow = new UserResourceFlow();
        _loc2_.userId = param1.i;
        _loc2_.resourceCaravansSentToday = param1.c;
        _loc2_.dailyResourceFlows = param1.x == null ? new ArrayCustom() : DailyResourceFlow.fromDtos(param1.x);
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
        var _loc3_:UserResourceFlow = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function getResources(param1:Date):Number {
        var _loc5_:int = 0;
        var _loc7_:DailyResourceFlow = null;
        var _loc8_:int = 0;
        var _loc9_:Number = NaN;
        var _loc10_:Number = NaN;
        if (this.dailyResourceFlows == null) {
            return 0;
        }
        var _loc2_:Number = StaticDataManager.knownUsersData.userResourceFlowLimitPeriodDays;
        var _loc3_:Number = Global.serverSettings.unit.userResourcesFlowLimit;
        var _loc4_:Number = 0;
        _loc5_ = this.dailyResourceFlows.length - 1;
        while (_loc5_ >= 0) {
            _loc7_ = this.dailyResourceFlows[_loc5_];
            _loc8_ = (DateUtil.getDatePart(param1).time - DateUtil.getDatePart(_loc7_.date).time) / (1000 * 60 * 60 * 24);
            if (_loc8_ >= _loc2_) {
                break;
            }
            _loc4_ = _loc4_ + _loc7_.resources;
            _loc5_--;
        }
        var _loc6_:int = _loc5_;
        while (_loc4_ < -_loc3_ || _loc4_ > _loc3_) {
            if (_loc5_ >= 0) {
                _loc9_ = this.dailyResourceFlows[_loc5_--].resources;
                this.dailyResourceFlows[_loc6_ + 1].resources = this.dailyResourceFlows[_loc6_ + 1].resources + _loc9_;
                _loc4_ = _loc4_ + _loc9_;
            }
            else {
                _loc10_ = _loc4_ < -_loc3_ ? Number(-(_loc3_ + _loc4_)) : Number(_loc3_ - _loc4_);
                this.dailyResourceFlows[_loc6_ + 1].resources = this.dailyResourceFlows[_loc6_ + 1].resources + _loc10_;
                _loc4_ = _loc4_ + _loc10_;
            }
        }
        while (_loc6_-- >= 0) {
            this.dailyResourceFlows.removeItemAt(0);
        }
        return _loc4_;
    }

    public function addResources(param1:Date, param2:Number):void {
        var _loc3_:DailyResourceFlow = this.getOrAddDailyResourceFlow(param1);
        _loc3_.resources = _loc3_.resources + param2;
    }

    private function getOrAddDailyResourceFlow(param1:Date):DailyResourceFlow {
        var _loc2_:DailyResourceFlow = null;
        if (this.dailyResourceFlows == null || this.dailyResourceFlows.length == 0 || this.dailyResourceFlows[this.dailyResourceFlows.length - 1].date.time != DateUtil.getDatePart(param1).time) {
            _loc2_ = new DailyResourceFlow();
            _loc2_.resources = 0;
            _loc2_.date = DateUtil.getDatePart(param1);
            if (this.dailyResourceFlows == null) {
                this.dailyResourceFlows = new ArrayCustom();
            }
            this.dailyResourceFlows.addItem(_loc2_);
        }
        return this.dailyResourceFlows[this.dailyResourceFlows.length - 1];
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.userId,
            "c": this.resourceCaravansSentToday,
            "x": (this.dailyResourceFlows == null ? null : DailyResourceFlow.toDtos(this.dailyResourceFlows))
        };
        return _loc1_;
    }
}
}
