package model.logic.quests.commands {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class RefreshDailyQuestsCmd extends BaseCmd {


    private var requestDto;

    public function RefreshDailyQuestsCmd() {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("RefreshDailyQuests", this.requestDto, "POST").ifResult(function (param1:*):void {
            UserRefreshCmd.updateUserByResultDto(param1, requestDto);
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
