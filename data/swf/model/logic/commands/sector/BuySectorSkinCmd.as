package model.logic.commands.sector {
import model.data.Resources;
import model.data.SectorSkinType;
import model.data.users.misc.UserSectorSkinData;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class BuySectorSkinCmd extends BaseCmd {


    private var _typeId:int;

    private var requestDto;

    public function BuySectorSkinCmd(param1:int) {
        super();
        this._typeId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto(this._typeId);
    }

    public function set typeId(param1:int):void {
        this._typeId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto(this._typeId);
    }

    override public function execute():void {
        var skinType:SectorSkinType = null;
        skinType = StaticDataManager.getSectorSkinType(this._typeId);
        new JsonCallCmd("BuyCitySkin", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = param1.o != null ? Resources.fromDto(param1.o) : skinType.price;
                UserManager.user.gameData.questData.addCollectibleItemsFromBMI(_loc2_.goldMoney);
                if (!UserManager.user.gameData.sectorSkinsData) {
                    UserManager.user.gameData.sectorSkinsData = new UserSectorSkinData();
                }
                UserManager.user.gameData.sectorSkinsData.purchasedSkinTypes.addItem(skinType);
                UserManager.user.gameData.account.resources.substract(_loc2_);
                UserManager.user.gameData.sectorSkinsData.dirty = true;
            }
            if (_onResult != null) {
                _onResult(param1);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
