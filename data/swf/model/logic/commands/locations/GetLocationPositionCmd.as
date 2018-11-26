package model.logic.commands.locations {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class GetLocationPositionCmd extends BaseCmd {


    private var _dto;

    public function GetLocationPositionCmd(param1:int) {
        super();
        this._dto = {"n": param1};
    }

    override public function execute():void {
        new JsonCallCmd("GetLocationPosition", this._dto, "POST").ifResult(_onResult).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
