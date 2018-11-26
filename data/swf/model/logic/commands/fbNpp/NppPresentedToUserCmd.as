package model.logic.commands.fbNpp {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class NppPresentedToUserCmd extends BaseCmd {


    private var requestDto:Object;

    public function NppPresentedToUserCmd() {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("NppPresentedToUser", this.requestDto, "POST").ifResult(function (param1:*):void {
            if (UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
            }
            if (_onResult != null) {
                _onResult();
            }
        }).execute();
    }
}
}
