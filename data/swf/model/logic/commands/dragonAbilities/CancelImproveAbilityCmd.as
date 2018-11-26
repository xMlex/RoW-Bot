package model.logic.commands.dragonAbilities {
import configs.Global;

import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.modules.dragonAbilities.data.Ability;
import model.modules.dragonAbilities.data.AbilityImprovementPrice;

public class CancelImproveAbilityCmd extends BaseCmd {

    private static const SECONDS_CANCEL_AVAILABLE:int = Global.DRAGON_CANCELLATION_PERIOD_IN_MINUTES * 60;


    private var requestDto;

    private var typeId:int;

    public function CancelImproveAbilityCmd(param1:int) {
        super();
        this.typeId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto({"a": param1});
    }

    public static function getCancelTimeLeftSeconds(param1:Ability):Number {
        if (!param1) {
            return -1;
        }
        if (!param1.inProgress) {
            return -1;
        }
        if (param1.constructionObjInfo.canceling == true) {
            return -1;
        }
        var _loc2_:Number = (ServerTimeManager.serverTimeNow.time - param1.constructionObjInfo.constructionStartTime.time) / 1000;
        return _loc2_ < SECONDS_CANCEL_AVAILABLE ? Number(_loc2_) : Number(-1);
    }

    override public function execute():void {
        new JsonCallCmd("Dragon.CancelImproveAbility", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto) || param1.g == null) {
                if (param1 && param1.o && param1.o.o) {
                    _loc2_ = AbilityImprovementPrice.fromDto(param1.o.o);
                    _loc3_ = UserManager.user.gameData.dragonData.getAbilityById(typeId);
                    if (_loc3_.constructionObjInfo.level == 0) {
                        UserManager.user.gameData.dragonData.removeAbilityById(typeId);
                    }
                    else {
                        _loc3_.constructionObjInfo.constructionStartTime = null;
                        _loc3_.constructionObjInfo.constructionFinishTime = null;
                    }
                    UserManager.user.gameData.dragonData.addAbilityImprovementPrice(_loc2_);
                    UserManager.user.gameData.dragonData.dirty = true;
                    UserManager.user.gameData.dragonData.dispatchEvents();
                }
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
