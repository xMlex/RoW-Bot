package model.logic.commands.world.unitMoving {
import model.data.map.unitMoving.MapRefreshInput;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class GetMapBlocksCmd extends BaseCmd {


    private var _request:MapRefreshInput;

    public function GetMapBlocksCmd(param1:MapRefreshInput) {
        super();
        this._request = param1;
    }

    override public function execute():void {
        new JsonCallCmd("GetMapBlocks", this._request.toDto()).ifResult(function (param1:*):void {
            if (_onResult != null) {
                _onResult(param1);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
