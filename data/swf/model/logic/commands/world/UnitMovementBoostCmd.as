package model.logic.commands.world {
import flash.utils.Dictionary;

import model.data.normalization.Normalizer;
import model.data.units.Unit;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class UnitMovementBoostCmd extends BaseCmd {


    private var _unit:Unit;

    private var _itemId:int;

    private var requestDto;

    public function UnitMovementBoostCmd(param1:Unit, param2:int = 0) {
        super();
        this._unit = param1;
        this._itemId = param2;
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "u": this._unit.UnitId,
            "b": this._itemId
        });
    }

    override public function execute():void {
        new JsonCallCmd("UnitManager.ApplyMovementBoost", this.requestDto).ifResult(function (param1:*):void {
            if (!param1) {
                return;
            }
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                updateBoughtData(_itemId);
                if (param1.o) {
                    _unit.StateMovingForward.arrivalTime = new Date(param1.o.a);
                }
                if (param1.o && param1.o.d) {
                    _unit.StateMovingForward.departureTime = new Date(param1.o.d);
                }
                Normalizer.normalize(UserManager.user);
                UserManager.user.gameData.worldData.dirtyUnitListChanged = true;
                UserManager.user.gameData.updateObjectsBuyStatus(true);
                UserManager.user.gameData.dispatchEvents();
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }

    private function updateBoughtData(param1:int):void {
        var _loc2_:Dictionary = UserManager.user.gameData.blackMarketData.boughtItems;
        if (_loc2_[param1] != undefined) {
            if (_loc2_[param1].freeCount > 0) {
                UserManager.user.gameData.blackMarketData.boughtItems[param1].freeCount--;
            }
            else {
                UserManager.user.gameData.blackMarketData.boughtItems[param1].paidCount--;
            }
        }
        UserManager.user.gameData.blackMarketData.dirty = true;
    }
}
}
