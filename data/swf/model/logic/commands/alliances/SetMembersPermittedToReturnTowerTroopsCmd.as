package model.logic.commands.alliances {
import model.data.alliances.AllianceTowerData;
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class SetMembersPermittedToReturnTowerTroopsCmd extends BaseAllianceCmd {


    private var _dto;

    private var membersPermittedToReturnTowerTroops:Array;

    public function SetMembersPermittedToReturnTowerTroopsCmd(param1:Array) {
        super();
        this._dto = makeRequestDto(param1);
        this.membersPermittedToReturnTowerTroops = param1;
    }

    override public function execute():void {
        new JsonCallCmd("SetMembersPermittedToReturnTowerTroops", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance;
                if (_loc2_.gameData.towersData == null) {
                    _loc2_.gameData.towersData = new AllianceTowerData();
                }
                _loc2_.gameData.towersData.membersPermittedToReturnTowerTroops = membersPermittedToReturnTowerTroops;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
