package model.logic.ratings.commands {
import model.data.quests.Scale;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.quests.data.TournamentUserGroup;
import model.logic.ratings.TournamentBonusManager;

public class GetTournamentRatingBonusesCmd extends BaseCmd {


    private var _prototypeId:int;

    public function GetTournamentRatingBonusesCmd(param1:int) {
        super();
        this._prototypeId = param1;
    }

    override public function execute():void {
        new JsonCallCmd("Rating.GetTournamentRatingBonuses", this._prototypeId, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = Scale.fromDtos(param1.lrb);
            TournamentBonusManager.initUserBonuses(_prototypeId, _loc2_);
            var _loc3_:* = Scale.fromDtos(param1.larb);
            TournamentBonusManager.initAllianceBonuses(_prototypeId, _loc3_);
            var _loc4_:* = param1.lsrb == null ? null : TournamentUserGroup.fromDtos(param1.lsrb);
            TournamentBonusManager.initUserGroupBonuses(_prototypeId, _loc4_);
            var _loc5_:* = param1.lgrb == null ? null : Scale.fromDto(param1.lgrb);
            TournamentBonusManager.initSuperLeagueBonuses(_prototypeId, _loc5_);
            if (_onResult != null) {
                _onResult(param1);
            }
        }).ifFault(_onFault).doFinally(_onFinally).execute();
    }
}
}
