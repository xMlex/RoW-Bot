package model.logic.commands.dragonAbilities {
import configs.Global;

import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.ratings.TournamentBonusManager;

public class RefreshMonsterCmd extends BaseCmd {


    private var requestDto;

    private var wonPoints:Number;

    public function RefreshMonsterCmd(param1:Number = 0) {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto();
        this.wonPoints = param1;
    }

    private function get isLastFightPerDay():Boolean {
        return UserManager.user.gameData.dragonData.isLastFightPerDay;
    }

    override public function execute():void {
        new JsonCallCmd("Dragon.RefreshMonster", this.requestDto, "POST").ifResult(function (param1:*):void {
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                UserManager.user.gameData.dragonData.monsterId = param1.o.m;
                UserManager.user.gameData.dragonData.hitsRefreshTime = param1.o.j == null ? null : new Date(param1.o.j);
                if (param1.o.s) {
                    TournamentBonusManager.applyUserPointsDiffForMonsterKill(UserManager.user.gameData.dragonData.monsterMaxHealth * Global.DRAGON_MONSTER_LAST_HIT_POWER_COEF);
                    UserManager.user.gameData.dragonData.todayFightsCount++;
                    UserManager.user.gameData.dragonData.monsterMaxHealth = param1.o.h;
                    UserManager.user.gameData.dragonData.lastRefreshTime = param1.o.e == null ? new Date() : new Date(param1.o.e);
                    UserManager.user.gameData.dragonData.updateHitsListByDto(param1.o.s);
                    UserManager.user.gameData.dragonData.addDragonPoints(wonPoints);
                }
                else if (isLastFightPerDay) {
                    TournamentBonusManager.applyUserPointsDiffForMonsterKill(UserManager.user.gameData.dragonData.monsterMaxHealth * Global.DRAGON_MONSTER_LAST_HIT_POWER_COEF);
                    UserManager.user.gameData.dragonData.addDragonPoints(wonPoints);
                }
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
