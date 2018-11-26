package model.logic.commands.allianceCity {
import model.logic.AllianceManager;
import model.logic.commands.alliances.BaseAllianceCmd;
import model.logic.commands.server.JsonCallCmd;

public class UpgradeAllianceCityCmd extends BaseAllianceCmd {


    private var _requestDto;

    public function UpgradeAllianceCityCmd() {
        super();
        this._requestDto = makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("UpgradeCity", this._requestDto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            updateAllianceByResultDto(param1);
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
