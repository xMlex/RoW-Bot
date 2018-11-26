package model.logic.commands.sector {
import model.data.Resources;
import model.data.scenes.objects.GeoSceneObject;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class UpgradeRobotCmd extends BaseCmd {


    private var _upgradingRobotID:uint;

    private var _newRobotTypeID:int;

    private var _slotID:int;

    private var _requestDto;

    public function UpgradeRobotCmd(param1:int, param2:int, param3:int) {
        super();
        this._upgradingRobotID = param1;
        this._newRobotTypeID = param2;
        this._slotID = param3;
        this._requestDto = UserRefreshCmd.makeRequestDto({
            "o": this._upgradingRobotID,
            "l": this._newRobotTypeID
        });
    }

    override public function execute():void {
        new JsonCallCmd("UpgradeRobot", this._requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc6_:* = undefined;
            var _loc7_:* = undefined;
            var _loc8_:* = undefined;
            var _loc3_:* = false;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _requestDto)) {
                _loc4_ = Resources.fromDto(param1.o.p);
                UserManager.user.gameData.account.resources.substract(_loc4_);
                if (param1.o.o) {
                    _loc2_ = GeoSceneObject.fromDto(param1.o.o);
                }
            }
            else {
                if (param1.g && param1.g.sd && param1.g.sd.s && param1.g.sd.s.o) {
                    _loc5_ = param1.g.sd.s.o;
                    _loc6_ = _loc5_.length;
                }
                _loc7_ = 0;
                while (_loc7_ < _loc6_) {
                    _loc8_ = _loc5_[_loc7_];
                    if (_loc8_.gi && _loc8_.gi.s && _loc8_.gi.s == _slotID) {
                        _loc2_ = GeoSceneObject.fromDto(_loc8_);
                        break;
                    }
                    _loc7_++;
                }
                _loc3_ = true;
            }
            if (_onResult != null) {
                _onResult(_loc2_, _loc3_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
