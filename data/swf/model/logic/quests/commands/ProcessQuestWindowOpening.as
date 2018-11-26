package model.logic.quests.commands {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class ProcessQuestWindowOpening extends BaseCmd {


    private var requestDto;

    public function ProcessQuestWindowOpening(param1:Number) {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto(param1);
    }

    override public function execute():void {
        new JsonCallCmd("ProcessQuestWindowOpening", this.requestDto, "POST").ifResult(function (param1:*):void {
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
