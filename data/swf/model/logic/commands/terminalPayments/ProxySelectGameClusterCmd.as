package model.logic.commands.terminalPayments {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class ProxySelectGameClusterCmd extends BaseCmd {

    private static const defaultName:String = "ProxySelectGameCluster";


    private var requestDto:Object;

    private var methodName:String;

    public function ProxySelectGameClusterCmd(param1:Object, param2:String) {
        super();
        this.methodName = param2 != "" ? param2 : defaultName;
        this.requestDto = param1;
    }

    override public function execute():void {
        new JsonCallCmd(this.methodName, this.requestDto, "POST").ifResult(function (param1:*):void {
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
