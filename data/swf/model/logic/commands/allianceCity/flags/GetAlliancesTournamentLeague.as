package model.logic.commands.allianceCity.flags {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class GetAlliancesTournamentLeague extends BaseCmd {


    private var _prototypeId:int;

    private var _allianceId:Number;

    public function GetAlliancesTournamentLeague(param1:int, param2:Number) {
        super();
        this._prototypeId = param1;
        this._allianceId = param2;
    }

    private function get dto():* {
        return {
            "p": this._prototypeId,
            "a": this._allianceId
        };
    }

    override public function execute():void {
        new JsonCallCmd("Rating.GetAlliancesTournamentLeague", this.dto, "POST").ifResult(function (param1:*):void {
            if (_onResult != null) {
                _onResult(param1.l);
            }
        }).ifFault(function (param1:*):void {
            if (_onFault != null) {
                _onFault(param1);
            }
        }).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
