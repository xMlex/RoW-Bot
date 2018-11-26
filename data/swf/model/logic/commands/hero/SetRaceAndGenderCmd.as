package model.logic.commands.hero {
import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class SetRaceAndGenderCmd extends BaseCmd {


    private var _dto;

    private var heroItemId:Number;

    public function SetRaceAndGenderCmd(param1:Number) {
        super();
        this._dto = UserRefreshCmd.makeRequestDto(param1);
        this.heroItemId = param1;
    }

    override public function execute():void {
        new JsonCallCmd("SetRaceAndGender", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _dto)) {
                UserManager.user.gameData.characterData.typeId = heroItemId;
                _loc2_ = UserManager.user.gameData.blackMarketData.boughtItems[BlackMarketItemsTypeId.ItemSelectCharacter];
                if (_loc2_.freeCount > 0) {
                    _loc2_.freeCount--;
                }
                else if (_loc2_.paidCount > 0) {
                    _loc2_.paidCount--;
                }
                UserManager.user.gameData.blackMarketData.dirty = true;
                UserManager.user.gameData.characterData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
