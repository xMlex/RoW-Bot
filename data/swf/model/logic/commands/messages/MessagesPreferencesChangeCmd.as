package model.logic.commands.messages {
import model.data.User;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class MessagesPreferencesChangeCmd extends BaseCmd {


    private var _dto;

    public function MessagesPreferencesChangeCmd(param1:User, param2:Boolean, param3:Boolean, param4:Array) {
        super();
        this._dto = UserRefreshCmd.makeRequestDto({
            "u": param1.id,
            "a": param1.gameData.messageData.diplomaticAdviserBattleReportsTypes,
            "n": param2,
            "d": param3,
            "m": param4
        });
    }

    override public function execute():void {
        new JsonCallCmd("Message.UpdateDiplomaticMessagesPreferences", this._dto, "POST").ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
