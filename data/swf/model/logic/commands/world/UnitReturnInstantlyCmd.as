package model.logic.commands.world {
import common.ArrayCustom;
import common.GameType;

import model.data.Resources;
import model.data.stats.GoldMoneySourceType;
import model.data.units.Unit;
import model.logic.PaymentManager;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.discountOffers.UserDiscountOfferManager;

public class UnitReturnInstantlyCmd extends BaseCmd {


    private var _unit:Unit;

    private var requestDto;

    private var _discount:Number = 0;

    public function UnitReturnInstantlyCmd(param1:Unit) {
        super();
        if (UserDiscountOfferManager.hasDiscount) {
            this._discount = UserDiscountOfferManager.discountInstantUnitReturn();
        }
        this._unit = param1;
        var _loc2_:Object = this._unit.UnitId < 0 ? {
            "i": this._unit.UnitId,
            "t": this._unit.TargetUserId
        } : {"i": this._unit.UnitId};
        this.requestDto = UserRefreshCmd.makeRequestDto(_loc2_);
    }

    public static function getReturnGoldMoneyPrice(param1:Unit):Resources {
        if (!param1 || param1.OwnerUserId != UserManager.user.id || param1.StateMovingBack == null) {
            return new Resources();
        }
        var _loc2_:Number = (param1.StateMovingBack.arrivalTime.time - ServerTimeManager.serverTimeNow.time) / (1000 * 60 * 60);
        if (GameType.isNords) {
            return Resources.fromGoldMoney(Math.ceil(_loc2_) * 50);
        }
        var _loc3_:Number = calcSquare(_loc2_);
        var _loc4_:Number = StaticDataManager.instantObjectMinPrice;
        var _loc5_:Number = StaticDataManager.instantObjectMaxPrice;
        if (_loc3_ < _loc4_) {
            return Resources.fromGoldMoney(_loc4_);
        }
        if (_loc3_ > _loc5_) {
            return Resources.fromGoldMoney(_loc5_);
        }
        return Resources.fromGoldMoney(_loc3_);
    }

    public static function calcSquare(param1:Number):Number {
        return normalizePrice(calcPricePerHourSquare(param1) * param1);
    }

    public static function calcPricePerHourSquare(param1:Number):Number {
        var _loc2_:ArrayCustom = StaticDataManager.instantObjectHours;
        var _loc3_:ArrayCustom = StaticDataManager.instantObjectPricePerHour;
        var _loc4_:Number = _loc2_[0];
        var _loc5_:Number = _loc3_[0];
        var _loc6_:Number = _loc2_[_loc2_.length - 1];
        var _loc7_:Number = _loc3_[_loc3_.length - 1];
        if (param1 <= _loc4_) {
            return _loc5_;
        }
        if (param1 >= _loc6_) {
            return _loc7_;
        }
        var _loc8_:int = 1;
        while (_loc8_ < _loc3_.length) {
            if (param1 <= _loc2_[_loc8_]) {
                if (_loc8_ == _loc3_.length - 1) {
                    return calcYByTwoPoints(_loc2_[_loc8_ - 1], _loc3_[_loc8_ - 1], _loc2_[_loc8_], _loc3_[_loc8_], param1);
                }
                return calcYByThreePoints(_loc2_[_loc8_ - 1], _loc3_[_loc8_ - 1], _loc2_[_loc8_], _loc3_[_loc8_], _loc2_[_loc8_ + 1], _loc3_[_loc8_ + 1], param1);
            }
            _loc8_++;
        }
        return 0;
    }

    private static function calcYByTwoPoints(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number):Number {
        return (param5 - param1) * (param4 - param2) / (param3 - param1) + param2;
    }

    private static function calcYByThreePoints(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number):Number {
        var _loc8_:Number = (param6 - param2) * (param3 - param1) - (param4 - param2) * (param5 - param1);
        var _loc9_:Number = (param5 * param5 - param1 * param1) * (param3 - param1) - (param3 * param3 - param1 * param1) * (param5 - param1);
        var _loc10_:Number = _loc8_ / _loc9_;
        var _loc11_:Number = (param4 - param2 - _loc10_ * (param3 * param3 - param1 * param1)) / (param3 - param1);
        var _loc12_:Number = param2 - _loc10_ * param1 * param1 - _loc11_ * param1;
        return _loc10_ * param7 * param7 + _loc11_ * param7 + _loc12_;
    }

    public static function normalizePrice(param1:Number):Number {
        var _loc2_:Number = StaticDataManager.instantObjectMinPrice;
        var _loc3_:Number = StaticDataManager.instantObjectMaxPrice;
        if (param1 < _loc2_) {
            return _loc2_;
        }
        if (param1 > _loc3_) {
            return _loc3_;
        }
        var _loc4_:Number = Math.ceil(param1 / 5);
        _loc4_ = _loc4_ * 5;
        return _loc4_;
    }

    override public function execute():void {
        new JsonCallCmd("UnitReturnInstantly", this.requestDto).ifResult(function (param1:*):void {
            var _loc4_:* = undefined;
            var _loc2_:* = getReturnGoldMoneyPrice(_unit);
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc4_ = Resources.fromDto(param1.o.p);
                UserManager.user.gameData.account.resources.substract(_loc4_);
                if (_unit.StateMovingBack != null) {
                    _unit.StateMovingBack.arrivalTime = new Date(param1.o.a);
                    UserManager.user.gameData.worldData.dirtyUnitListChanged = true;
                }
            }
            var _loc3_:* = new Object();
            if (_unit.troopsPayload != null) {
                _loc3_ = _unit.troopsPayload.troops != null ? _unit.troopsPayload.troops.countByType : null;
                PaymentManager.addPayment(_loc2_.goldMoney * (1 - _discount), int(UserManager.user.gameData.account.resources.goldMoney), ServerTimeManager.serverTimeNow, GoldMoneySourceType.InstantTroopsReturn, _loc3_);
            }
            else {
                _loc3_[-1] = 1;
                PaymentManager.addPayment(_loc2_.goldMoney * (1 - _discount), int(UserManager.user.gameData.account.resources.goldMoney), ServerTimeManager.serverTimeNow, GoldMoneySourceType.InstantTroopsReturn, _loc3_);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
