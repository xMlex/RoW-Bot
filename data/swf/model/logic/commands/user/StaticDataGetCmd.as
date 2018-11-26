package model.logic.commands.user {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.FaultDto;
import model.logic.commands.server.JsonCallCmd;

public class StaticDataGetCmd extends BaseCmd {


    private var _dto;

    public function StaticDataGetCmd(param1:String) {
        super();
        this._dto = param1;
    }

    override public function execute():void {
        new JsonCallCmd("Client.GetStaticData", this._dto, "GET").noResponseSignature().ifResult(_onResult).ifFault(function (param1:FaultDto):void {
            new JsonCallCmd("Client.GetStaticData", _dto, "POST").noResponseSignature().ifResult(_onResult).ifFault(_onFault).ifIoFault(_onIoFault).execute();
        }).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
