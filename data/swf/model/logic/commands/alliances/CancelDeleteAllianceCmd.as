package model.logic.commands.alliances {
import model.data.alliances.Alliance;
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class CancelDeleteAllianceCmd extends BaseAllianceCmd {


    private var _alliance:Alliance;

    private var _dto;

    public function CancelDeleteAllianceCmd(param1:Alliance) {
        super();
        this._alliance = param1;
        this._dto = this._alliance.id;
    }

    override public function execute():void {
        new JsonCallCmd("CancelDeleteAlliance", this._dto, "POST").setSegment(this._alliance.segmentId).ifResult(function (param1:*):void {
            AllianceManager.updateAllianceDeletion(false, null);
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
