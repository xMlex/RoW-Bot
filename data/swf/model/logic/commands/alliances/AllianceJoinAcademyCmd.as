package model.logic.commands.alliances {
import model.logic.UserManager;
import model.logic.commands.server.JsonCallCmd;

public class AllianceJoinAcademyCmd extends BaseAllianceCmd {


    private var _dto;

    private var _segmentId:int;

    public function AllianceJoinAcademyCmd(param1:int, param2:int) {
        super();
        this._dto = {"i": param1};
        this._segmentId = param2;
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.JoinAcademy", this._dto, "POST").setSegment(this._segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = UserManager.user.gameData.allianceData;
            _loc2_.dirty = true;
            _loc2_.dispatchEvents();
            if (_onResult != null) {
                _onResult(param1);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
