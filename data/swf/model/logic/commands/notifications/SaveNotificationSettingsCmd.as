package model.logic.commands.notifications {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class SaveNotificationSettingsCmd extends BaseCmd {


    private var requestDto:Object;

    public function SaveNotificationSettingsCmd() {
        super();
        var _loc1_:Object = UserManager.user.gameData.notificationData.notificationSettings.toDto();
        this.requestDto = UserRefreshCmd.makeRequestDto(_loc1_);
    }

    override public function execute():void {
        new JsonCallCmd("SaveFbNotificationSettings", this.requestDto, "POST").ifResult(function (param1:*):void {
            if (UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
            }
            if (_onResult != null) {
                _onResult();
            }
        }).execute();
    }
}
}
