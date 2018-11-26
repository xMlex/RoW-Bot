package model.logic.commands.clanPurchases {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class RemoveGachaChestCmd extends BaseCmd {


    private var _requestDto;

    private var _userChestId:int;

    public function RemoveGachaChestCmd(param1:int, param2:Boolean = false) {
        super();
        this.fillRequestDto(param1, param2);
    }

    public function fillRequestDto(param1:int, param2:Boolean = false):void {
        var _loc3_:Object = {};
        if (param2) {
            _loc3_.a = param2;
            this._userChestId = -1;
        }
        else {
            _loc3_.i = param1;
            this._userChestId = param1;
        }
        this._requestDto = UserRefreshCmd.makeRequestDto(_loc3_);
    }

    override public function execute():void {
        new JsonCallCmd("GachaChest.Remove", this._requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _requestDto)) {
                _loc2_ = UserManager.user.gameData.clanPurchaseData;
                if (_userChestId > -1) {
                    _loc2_.removeExpiredById(_userChestId);
                }
                else {
                    _loc2_.clearExpired();
                }
                _loc2_.dispatchEvents();
            }
            if (_onResult != null) {
                _onResult(param1);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
