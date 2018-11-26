package model.logic.occupation.commands {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.occupation.data.UserOccupationInfo;

public class OccupationSetCmd extends BaseCmd {


    private var _userId:Number;

    private var _resourceTypeId:int;

    private var requestDto;

    public function OccupationSetCmd(param1:Number, param2:int) {
        super();
        this._userId = param1;
        this._resourceTypeId = param2;
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "u": this._userId,
            "r": this._resourceTypeId
        });
    }

    override public function execute():void {
        new JsonCallCmd("Occupation.Set", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserOccupationInfo.fromDto(param1.o.u);
                _loc3_ = UserManager.user;
                _loc4_ = _loc3_.gameData.occupationData.getUserInfo(_userId);
                if (_loc4_ != null) {
                    _loc4_.update(_loc2_);
                }
                else {
                    _loc3_.gameData.occupationData.userOccupationInfos.addItem(_loc2_);
                }
                _loc3_.gameData.occupationData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
