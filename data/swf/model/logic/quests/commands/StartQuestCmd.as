package model.logic.quests.commands {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class StartQuestCmd extends BaseCmd {


    private var requestDto;

    public function StartQuestCmd(param1:int, param2:Boolean = false) {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "i": param1,
            "a": param2
        });
    }

    override public function execute():void {
        new JsonCallCmd("StartQuest", this.requestDto, "POST").ifResult(function (param1:*):void {
            UserRefreshCmd.updateUserByResultDto(param1, requestDto);
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
