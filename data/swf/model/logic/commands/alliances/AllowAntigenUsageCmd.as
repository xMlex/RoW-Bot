package model.logic.commands.alliances {
import model.logic.AllianceManager;
import model.logic.UserManager;
import model.logic.commands.server.JsonCallCmd;

public class AllowAntigenUsageCmd extends BaseAllianceCmd {


    private var _userId:Number;

    private var _canuseAntigen:Boolean;

    private var _dto;

    public function AllowAntigenUsageCmd(param1:Number, param2:Boolean) {
        super();
        this._userId = param1;
        this._canuseAntigen = param2;
        this._dto = makeRequestDto({
            "u": this._userId,
            "c": param2
        });
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.AllowAntigenUsage", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData.membershipData.getMember(UserManager.user.id);
                _loc3_ = AllianceManager.currentAlliance.gameData.membershipData.getMember(_userId);
                _loc3_.canUseAntigen = _canuseAntigen;
                AllianceManager.currentAlliance.gameData.membershipData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
