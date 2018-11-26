package model.logic.commands.alliances {
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class AllianceRefreshCmd extends BaseAllianceCmd {


    private var _dto;

    public function AllianceRefreshCmd() {
        super();
        this._dto = makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.Refresh", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            updateAllianceByResultDto(param1, false, true);
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
