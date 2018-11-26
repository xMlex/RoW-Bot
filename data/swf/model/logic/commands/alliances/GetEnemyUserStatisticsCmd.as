package model.logic.commands.alliances {
import flash.utils.Dictionary;

import model.data.alliances.EnemyUserStatistics;
import model.data.alliances.diplomacy.EnemyAllianceItem;
import model.data.users.UserNote;
import model.logic.AllianceManager;
import model.logic.UserNoteManager;
import model.logic.commands.server.JsonCallCmd;

public class GetEnemyUserStatisticsCmd extends BaseAllianceCmd {


    private var _dto;

    public function GetEnemyUserStatisticsCmd() {
        super();
        this._dto = makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.GetEnemyUserStatistics", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (param1.e != null) {
                AllianceManager.enemyUserStatistics = EnemyUserStatistics.fromDtos(param1.e);
            }
            if (param1.a != null) {
                AllianceManager.enemyAllianceItems = new Dictionary();
                for (_loc2_ in param1.a) {
                    AllianceManager.enemyAllianceItems[_loc2_] = EnemyAllianceItem.fromDto(param1.a[_loc2_]);
                }
            }
            if (param1.n != null) {
                _loc3_ = UserNote.fromDtos(param1.n);
                UserNoteManager.update(_loc3_);
            }
            if (_onResult != null) {
                _onResult(param1);
            }
        }).execute();
    }
}
}
