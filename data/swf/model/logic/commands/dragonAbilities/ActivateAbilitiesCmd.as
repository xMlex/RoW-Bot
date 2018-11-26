package model.logic.commands.dragonAbilities {
import configs.Global;

import model.data.Resources;
import model.data.effects.EffectItem;
import model.data.effects.EffectsManager;
import model.data.users.troops.Troops;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.quests.completions.QuestCompletionPeriodic;
import model.logic.quests.periodicQuests.ComplexSource;
import model.logic.quests.periodicQuests.enums.PeriodicQuestPrototypeId;

public class ActivateAbilitiesCmd extends BaseCmd {


    private var requestDto;

    public function ActivateAbilitiesCmd() {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("Dragon.ActivateAbilities", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc2_:* = UserManager.user.gameData;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc3_ = _loc2_.normalizationTime.time + Global.DRAGON_ABILITY_EXPIRATION_TIME_IN_HOURS * 60 * 60 * 1000;
                _loc2_.dragonData.activationFinishTime = param1.n == null ? null : new Date(_loc3_);
                _loc2_.dragonData.activateAbilities();
                if (param1.o) {
                    if (param1.o.s) {
                        for each(_loc4_ in param1.o.s) {
                            _loc5_ = EffectItem.fromDto(_loc4_);
                            EffectsManager.addEffect(_loc5_);
                        }
                        _loc2_.constructionData.updateAcceleration(_loc2_, _loc2_.normalizationTime);
                    }
                    if (param1.o.t) {
                        _loc2_.troopsData.troops.addTroops(Troops.fromDto(param1.o.t));
                    }
                    if (param1.o.r) {
                        _loc2_.account.resources.add(Resources.fromDto(param1.o.r));
                    }
                }
                QuestCompletionPeriodic.tryComplete(ComplexSource.fromDragonData(_loc2_.dragonData), [PeriodicQuestPrototypeId.ActivateDragon]);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
