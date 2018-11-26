package model.data.users.trading {
import common.ArrayCustom;
import common.DateUtil;
import common.TimeSpan;
import common.localization.LocaleUtil;

import model.data.units.payloads.TradingPayload;
import model.logic.ServerTimeManager;

public class TradingOffer {


    public var id:Number;

    public var userId:Number;

    public var offerInfo:TradingPayload;

    public var searchInfo:TradingPayload;

    public var time:Date;

    public var deliveryTime:Number;

    public var sortTime:Number;

    public var profit:Number = 0;

    private const OFFERS_LIFE:Number = 259200000;

    private const DAY_SIZE:Number = 86400000;

    private var _isOldOffer:Boolean = false;

    public function TradingOffer() {
        super();
    }

    public static function fromDto(param1:*):TradingOffer {
        var _loc2_:TradingOffer = new TradingOffer();
        _loc2_.id = param1.i;
        _loc2_.userId = param1.u;
        _loc2_.offerInfo = TradingPayload.fromDto(param1.o);
        _loc2_.searchInfo = TradingPayload.fromDto(param1.s);
        _loc2_.time = param1.t == null ? null : new Date(param1.t);
        _loc2_.profit = param1.p;
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
        var _loc3_:TradingOffer = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function isOldOffer():Boolean {
        var _loc1_:Date = ServerTimeManager.serverTimeNow;
        return !this.time || _loc1_.time - this.time.time > this.OFFERS_LIFE;
    }

    public function getDeleteTimeString():String {
        if (!this.time) {
            return "";
        }
        var _loc1_:Date = ServerTimeManager.serverTimeNow;
        var _loc2_:int = int((this.OFFERS_LIFE - _loc1_.time + this.time.time) / this.DAY_SIZE);
        var _loc3_:Number = (this.OFFERS_LIFE - _loc1_.time + this.time.time) % this.DAY_SIZE;
        if (_loc3_ <= 0) {
            return this.generateDaysString(_loc2_);
        }
        var _loc4_:int = _loc3_ / 1000;
        var _loc5_:TimeSpan = DateUtil.timeSpanFromSeconds(_loc4_);
        return this.generateDaysString(_loc2_) + " " + DateUtil.formatTimeSpanHHMMLetters(_loc5_);
    }

    private function generateDaysString(param1:int):String {
        if (param1 == 0) {
            return "";
        }
        if (param1 == 1) {
            return param1 + " " + LocaleUtil.getText("model-data-users-trading-tradingOffer-day1");
        }
        if (param1 == 2 || param1 == 3 || param1 == 4) {
            return param1 + " " + LocaleUtil.getText("model-data-users-trading-tradingOffer-day2");
        }
        return param1 + " " + LocaleUtil.getText("model-data-users-trading-tradingOffer-day5");
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.id,
            "u": this.userId,
            "t": (this.time == null ? null : this.time.time),
            "o": this.offerInfo.toDto(),
            "s": this.searchInfo.toDto()
        };
        return _loc1_;
    }
}
}
