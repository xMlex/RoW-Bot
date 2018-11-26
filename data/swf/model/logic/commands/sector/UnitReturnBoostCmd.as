package model.logic.commands.sector {
import common.DateUtil;

import flash.utils.Dictionary;

import model.data.normalization.Normalizer;
import model.data.units.Unit;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class UnitReturnBoostCmd extends BaseCmd {


    private var _unit:Unit;

    private var _itemId:int;

    private var _itemCount:int;

    private var requestDto;

    public function UnitReturnBoostCmd(param1:Unit, param2:int = 0, param3:int = 1) {
        super();
        this._unit = param1;
        this._itemId = param2;
        this._itemCount = param3;
        var _loc4_:Object = this._unit.UnitId < 0 ? {
            "i": this._unit.UnitId,
            "b": this._itemId,
            "c": this._itemCount,
            "t": this._unit.TargetUserId
        } : {
            "i": this._unit.UnitId,
            "b": this._itemId,
            "c": this._itemCount
        };
        this.requestDto = UserRefreshCmd.makeRequestDto(_loc4_);
    }

    override public function execute():void {
        new JsonCallCmd("UnitReturnBoost", this.requestDto).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc6_:* = undefined;
            var _loc7_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user.gameData;
                if (_unit.StateMovingBack != null) {
                    _loc3_ = StaticDataManager.blackMarketData.itemsById[_itemId];
                    if (_loc3_) {
                        _loc4_ = _loc3_.boostData.timeSeconds * _itemCount;
                        _loc5_ = _unit.StateMovingBack.arrivalTime.time - _loc4_ * 1000;
                        _loc6_ = new Date(_loc5_);
                        _unit.StateMovingBack.arrivalTime = DateUtil.getTimeBetween(_loc6_, _loc2_.normalizationTime) < 0 ? _loc6_ : _loc2_.normalizationTime;
                        if (_unit.StateMovingBack.arrivalTime > _loc2_.normalizationTime) {
                            _loc7_ = _unit.StateMovingBack.departureTime.time - _loc4_ * 1000;
                            _unit.StateMovingBack.departureTime = new Date(_loc7_);
                        }
                        updateBoughtData(_loc3_.id, _itemCount);
                    }
                    Normalizer.normalize(UserManager.user);
                    UserManager.user.gameData.worldData.dirtyUnitListChanged = true;
                    UserManager.user.gameData.updateObjectsBuyStatus(true);
                    UserManager.user.gameData.dispatchEvents();
                }
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }

    private function updateBoughtData(param1:int, param2:int):void {
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc3_:Dictionary = UserManager.user.gameData.blackMarketData.boughtItems;
        if (_loc3_[param1].freeCount + _loc3_[param1].paidCount == param2) {
            delete _loc3_[param1];
        }
        if (_loc3_[param1] != undefined) {
            _loc4_ = _loc3_[param1].freeCount > param2 ? int(param2) : int(_loc3_[param1].freeCount);
            _loc5_ = _loc3_[param1].paidCount > param2 - _loc4_ ? int(param2 - _loc4_) : int(_loc3_[param1].paidCount);
            if (_loc3_[param1].freeCount > 0) {
                _loc3_[param1].freeCount = _loc3_[param1].freeCount - _loc4_;
            }
            else {
                _loc3_[param1].paidCount = _loc3_[param1].paidCount - _loc5_;
            }
        }
        UserManager.user.gameData.blackMarketData.dirty = true;
    }
}
}
