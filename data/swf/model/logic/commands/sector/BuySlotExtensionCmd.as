package model.logic.commands.sector {
import model.data.Resources;
import model.data.SectorSlotExtension;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class BuySlotExtensionCmd extends BaseCmd {


    private var _ext:SectorSlotExtension;

    private var _price:Resources;

    private var requestDto;

    public function BuySlotExtensionCmd(param1:SectorSlotExtension, param2:Resources) {
        super();
        this._ext = param1;
        this._price = param2;
        this.requestDto = UserRefreshCmd.makeRequestDto(this._ext.toDto());
    }

    override public function execute():void {
        new JsonCallCmd("BuySlotExtension", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                UserManager.user.gameData.sector.extendSlots(_ext);
                if (param1.o != null && !_ext.isForFriends) {
                    _loc2_ = Resources.fromDto(param1.o);
                    UserManager.user.gameData.account.resources.substract(_loc2_);
                }
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
