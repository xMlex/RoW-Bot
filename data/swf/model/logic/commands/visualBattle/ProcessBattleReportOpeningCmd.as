package model.logic.commands.visualBattle {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class ProcessBattleReportOpeningCmd extends BaseCmd {


    private var requestDto;

    public function ProcessBattleReportOpeningCmd(param1:int) {
        super();
        this.requestDto = {"o": param1};
    }

    override public function execute():void {
        new JsonCallCmd("ProcessBattleReportOpening", this.requestDto, "POST").ifResult(function (param1:*):void {
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
