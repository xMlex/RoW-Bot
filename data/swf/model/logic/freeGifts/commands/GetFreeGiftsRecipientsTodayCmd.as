package model.logic.freeGifts.commands {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class GetFreeGiftsRecipientsTodayCmd extends BaseCmd {


    private var _dto:Object;

    public function GetFreeGiftsRecipientsTodayCmd(param1:Number) {
        super();
        this._dto = UserRefreshCmd.makeRequestDto(param1);
    }

    override public function execute():void {
        new JsonCallCmd("GetFreeGiftsRecipientsToday", this._dto, "POST").ifResult(function (param1:Object):void {
            if (_onResult != null) {
                _onResult(param1);
            }
        }).execute();
    }
}
}
