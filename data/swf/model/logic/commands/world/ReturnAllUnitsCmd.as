package model.logic.commands.world {
import model.data.units.Unit;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.units.UnitUtility;

public class ReturnAllUnitsCmd extends BaseCmd {


    private var requestDto;

    public function ReturnAllUnitsCmd(param1:Array) {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto({"i": param1});
    }

    override public function execute():void {
        new JsonCallCmd("ReturnAllUnits", this.requestDto).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user;
                _loc3_ = Unit.fromDtos(param1.o.r);
                _loc4_ = _loc3_ != null && _loc3_.length > 0;
                if (_loc4_) {
                    UnitUtility.addUnits(_loc2_, _loc3_);
                    UnitUtility.sentUnits(_loc2_, _loc3_);
                }
                if (_onResult != null) {
                    _onResult();
                }
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
