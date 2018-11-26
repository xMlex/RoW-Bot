package model.logic.commands.user {
import model.data.UserSocialData;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public final class SetUserLocaleCmd extends BaseCmd {


    private var _locale:String;

    public function SetUserLocaleCmd(param1:String) {
        super();
        this._locale = UserSocialData.normalizeLocale(param1);
    }

    override public function execute():void {
        new JsonCallCmd("SetUserLocale", this._locale, "POST").ifResult(function (param1:*):void {
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
