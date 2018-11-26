package model.logic.commands.alliances {
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class SendAllianceMessageCmd extends BaseAllianceCmd {


    private var _dto;

    public function SendAllianceMessageCmd(param1:String, param2:Array = null) {
        super();
        this._dto = makeRequestDto({
            "t": param1,
            "r": param2
        });
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.SendMessage", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            if (!updateAllianceByResultDto(param1)) {
                AllianceManager.currentAlliance.gameData.messageData.LeaderDailyMessagesSent = param1.o.l;
                AllianceManager.currentAlliance.gameData.messageData.DeputiesDailyMessagesSent = param1.o.d;
                AllianceManager.currentAlliance.gameData.messageData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
