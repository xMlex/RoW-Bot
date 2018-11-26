package model.logic.commands {
import model.data.Resources;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class BuySkillPointsCmd extends BaseCmd {


    private var _countSkillPoints:int;

    private var requestDto;

    public function BuySkillPointsCmd(param1:int = 1) {
        super();
        this._countSkillPoints = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto(this._countSkillPoints);
    }

    override public function execute():void {
        new JsonCallCmd("BlackMarket.BuySkillPoints", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user;
                _loc3_ = new Resources(0, 0, 0, 0, 0, StaticDataManager.blackMarketData.skillPointBlackCrystalPrice);
                _loc2_.gameData.account.resources.substract(_loc3_);
                UserManager.user.gameData.skillData.skillPoints = UserManager.user.gameData.skillData.skillPoints + _countSkillPoints;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
