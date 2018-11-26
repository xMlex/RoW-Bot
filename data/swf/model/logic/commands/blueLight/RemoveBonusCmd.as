package model.logic.commands.blueLight {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class RemoveBonusCmd extends BaseCmd {


    private var _requestDto;

    private var _eventId:Number;

    private var _blackMarketItemId:int;

    public function RemoveBonusCmd(param1:Number, param2:int) {
        super();
        this._eventId = param1;
        this._blackMarketItemId = param2;
        this._requestDto = UserRefreshCmd.makeRequestDto({
            "i": param1,
            "bi": param2
        });
    }

    override public function execute():void {
        new JsonCallCmd("bluelight.removebonus", this._requestDto, "POST").ifResult(function (param1:*):void {
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc2_:* = UserManager.user.gameData.blueLightData;
            if (_loc2_ != null) {
                _loc3_ = _loc2_.bluelightByIds[_eventId];
                if (_loc3_ != null) {
                    _loc4_ = _loc3_.obtainedBonusIds.indexOf(_blackMarketItemId);
                    if (_loc4_ >= 0) {
                        _loc3_.obtainedBonusIds.splice(_loc4_, 1);
                        _loc2_.dirty = true;
                        _loc2_.dispatchEvents();
                    }
                }
            }
            if (_onResult != null) {
                _onResult(param1.o);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
