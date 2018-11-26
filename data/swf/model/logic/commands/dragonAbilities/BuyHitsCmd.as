package model.logic.commands.dragonAbilities {
import configs.Global;

import model.data.Resources;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.modules.dragonAbilities.logic.UserDragonData;

public class BuyHitsCmd extends BaseCmd {


    private var requestDto;

    private var price:Resources;

    public function BuyHitsCmd(param1:Resources) {
        super();
        this.price = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("Dragon.BuyHits", this.requestDto, "POST").ifResult(function (param1:*):void {
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                UserManager.user.gameData.dragonData.hitsCount = Global.DRAGON_MAX_HITS_COUNT;
                UserManager.user.gameData.dragonData.hitsMade = 0;
                UserManager.user.gameData.dragonData.hitsRefreshTime = null;
                UserManager.user.gameData.dragonData.dispatchEvent(UserDragonData.MONSTER_DATA_CHANGED);
                UserManager.user.gameData.account.resources.substract(price);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
