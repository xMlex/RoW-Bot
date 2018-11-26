package model.logic.commands.allianceCity {
import model.data.map.MapPos;
import model.logic.AllianceManager;
import model.logic.commands.alliances.BaseAllianceCmd;
import model.logic.commands.server.JsonCallCmd;

public class CreateCityCmd extends BaseAllianceCmd {


    private var _requestDto;

    public function CreateCityCmd(param1:MapPos) {
        super();
        this._requestDto = makeRequestDto({"p": param1});
    }

    override public function execute():void {
        new JsonCallCmd("CreateCity", this._requestDto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            updateAllianceByResultDto(param1);
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(function (param1:*):void {
            if (_onFault != null) {
                _onFault(param1);
            }
        }).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
