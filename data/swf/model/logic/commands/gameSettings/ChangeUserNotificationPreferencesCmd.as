package model.logic.commands.gameSettings {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class ChangeUserNotificationPreferencesCmd extends BaseCmd {


    private var dto;

    private var _newSettings:Array;

    public function ChangeUserNotificationPreferencesCmd(param1:Array) {
        super();
        this._newSettings = param1;
        this.dto = UserRefreshCmd.makeRequestDto({"n": this._newSettings});
    }

    override public function execute():void {
        new JsonCallCmd("UISettingsManager.ChangeUserNotificationPreferencesNew", this.dto, "POST").ifResult(function ():void {
            UserManager.user.gameData.uiData.notificationSetting.updatePreference(_newSettings);
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
