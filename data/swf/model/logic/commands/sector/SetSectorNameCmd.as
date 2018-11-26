package model.logic.commands.sector {
import model.logic.UserManager;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class SetSectorNameCmd extends BaseCmd {


    private var requestDto;

    public function SetSectorNameCmd(param1:String) {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto(param1);
    }

    override public function execute():void {
        new JsonCallCmd("SetSectorName", this.requestDto, "POST").ifResult(function (param1:*):void {
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                UserManager.user.gameData.sector.name = requestDto.o;
            }
            var _loc2_:* = UserNoteManager.getById(UserManager.user.id);
            _loc2_.sectorName = UserManager.user.gameData.sector.name;
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
