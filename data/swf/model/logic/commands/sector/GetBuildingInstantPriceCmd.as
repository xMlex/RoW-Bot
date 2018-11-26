package model.logic.commands.sector {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class GetBuildingInstantPriceCmd extends BaseCmd {


    private var _requestDto;

    public function GetBuildingInstantPriceCmd(param1:Array) {
        super();
        this._requestDto = {"i": param1};
    }

    override public function execute():void {
        new JsonCallCmd("GetBuildingInstantPrice", this._requestDto, "POST").ifResult(function (param1:*):void {
            if (_onResult != null) {
                _onResult(param1);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
