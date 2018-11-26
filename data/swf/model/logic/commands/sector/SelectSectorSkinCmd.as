package model.logic.commands.sector {
import model.data.UserGameData;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class SelectSectorSkinCmd extends BaseCmd {


    private var _typeId:int;

    private var requestDto;

    public function SelectSectorSkinCmd(param1:int) {
        super();
        this._typeId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto(this._typeId);
    }

    public function set typeId(param1:int):void {
        this._typeId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto(this._typeId);
    }

    override public function execute():void {
        new JsonCallCmd("SelectCitySkin", this.requestDto, "POST").ifResult(function (param1:*):void {
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                UserManager.user.gameData.sectorSkinsData.currentSkinTypeId = _typeId;
                UserManager.user.gameData.sectorSkinsData.dirty = true;
                UserManager.user.gameData.dispatchEvent(UserGameData.SECTOR_SKIN_DATA_CHANGED);
            }
            if (_onResult != null) {
                _onResult(_typeId);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
