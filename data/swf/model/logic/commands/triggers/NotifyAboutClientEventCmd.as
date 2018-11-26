package model.logic.commands.triggers {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class NotifyAboutClientEventCmd extends BaseCmd {


    private var _requestDto;

    public function NotifyAboutClientEventCmd(param1:Array) {
        super();
        this._requestDto = {"l": param1};
    }

    override public function execute():void {
        new JsonCallCmd("NotifyAboutClientEvent", this._requestDto, "POST").ifResult(function ():void {
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
