package model.logic.commands.allianceCity {
import model.data.locations.Location;
import model.logic.AllianceManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class GetAllianceCityCmd extends BaseCmd {


    private var _dto;

    public function GetAllianceCityCmd(param1:Number, param2:Number) {
        super();
        this._dto = {
            "c": param1,
            "r": param2
        };
    }

    override public function execute():void {
        new JsonCallCmd("GetAllianceCity", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = new Location();
            if (param1) {
                _loc2_ = Location.fromDto(param1);
                if (_onResult != null) {
                    _onResult(_loc2_);
                }
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
