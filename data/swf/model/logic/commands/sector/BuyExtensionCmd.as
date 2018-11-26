package model.logic.commands.sector {
import model.data.Resources;
import model.data.SectorExtension;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class BuyExtensionCmd extends BaseCmd {


    private var _ext:SectorExtension;

    private var requestDto;

    public function BuyExtensionCmd(param1:SectorExtension) {
        super();
        this._ext = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto(this._ext.toDto());
    }

    override public function execute():void {
        new JsonCallCmd("BuyExtension", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                UserManager.user.gameData.sector.extend(_ext.sideLength);
                if (param1.o != null) {
                    _loc2_ = Resources.fromDto(param1.o);
                    UserManager.user.gameData.account.resources.substract(_loc2_);
                }
            }
            if (_onResult != null) {
                _onResult(_ext.sideLength);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
