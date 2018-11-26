package model.logic.map.commands {
import model.data.UserGameData;
import model.data.map.MapPos;
import model.data.map.MapStateId;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class TeleportCmd extends BaseCmd {


    private var requestDto;

    public function TeleportCmd(param1:Number = 0, param2:MapPos = null, param3:Boolean = false, param4:Boolean = false) {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto({});
        if (param1 != 0) {
            this.requestDto.o.t = param1;
        }
        if (param2 != null) {
            this.requestDto.o.p = param2.toDto();
        }
        this.requestDto.o.r = param3;
        this.requestDto.o.u = param4;
    }

    override public function execute():void {
        new JsonCallCmd("Teleport", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc2_:* = UserManager.user;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc3_ = MapPos.fromDto(param1.o.n);
                _loc2_.gameData.changingToMapPos = _loc3_;
                _loc2_.gameData.mapStateId = MapStateId.ActiveMoving;
                if (param1.o.ub != null) {
                    _loc4_ = _loc2_.gameData.blackMarketData;
                    _loc5_ = _loc4_.boughtItems[param1.o.ub.i];
                    _loc5_.paidCount--;
                }
                UserManager.user.gameData.dispatchEvent(UserGameData.MAP_STATE_CHANGED);
            }
            if (_onResult != null) {
                _onResult(param1);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
