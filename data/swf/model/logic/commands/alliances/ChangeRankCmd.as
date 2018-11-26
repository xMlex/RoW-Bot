package model.logic.commands.alliances {
import model.data.alliances.AllianceMemberRankId;
import model.logic.AllianceManager;
import model.logic.UserManager;
import model.logic.UserNoteManager;
import model.logic.commands.server.JsonCallCmd;

public class ChangeRankCmd extends BaseAllianceCmd {


    private var _userId:Number;

    private var _rank:int;

    private var _dto;

    public function ChangeRankCmd(param1:Number, param2:int) {
        super();
        this._userId = param1;
        this._rank = param2;
        this._dto = makeRequestDto({
            "u": this._userId,
            "r": this._rank
        });
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.ChangeRank", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc6_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc3_ = AllianceManager.currentAlliance.gameData.membershipData.getMember(UserManager.user.id);
                _loc4_ = AllianceManager.currentAlliance.gameData.membershipData.getMember(_userId);
                if (_loc3_.rankId == AllianceMemberRankId.LEADER && _rank == AllianceMemberRankId.LEADER) {
                    _loc5_ = UserManager.user;
                    _loc6_ = _loc5_.gameData.allianceData;
                    _loc6_.rankId = AllianceMemberRankId.DEPUTY;
                    _loc3_.rankId = AllianceMemberRankId.DEPUTY;
                    _loc6_.dirty = true;
                }
                _loc4_.rankId = _rank;
                if (_rank <= AllianceMemberRankId.DEPUTY) {
                    _loc4_.canUseAntigen = true;
                }
                AllianceManager.currentAlliance.gameData.membershipData.dirty = true;
            }
            var _loc2_:* = UserNoteManager.getById(_userId);
            _loc2_.allianceRankId = _rank;
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
