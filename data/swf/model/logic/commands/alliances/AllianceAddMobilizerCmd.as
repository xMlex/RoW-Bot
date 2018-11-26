package model.logic.commands.alliances {
import model.logic.AllianceManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class AllianceAddMobilizerCmd extends BaseCmd {


    private var requestDto;

    public function AllianceAddMobilizerCmd(param1:Number, param2:int) {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "a": param1,
            "c": param2
        });
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.AddMobilizer", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user.gameData.allianceData;
                _loc2_.mobilizersCount = _loc2_.mobilizersCount - requestDto.o.c;
                _loc2_.dirty = true;
                if (AllianceManager.currentAlliance != null) {
                    AllianceManager.currentAlliance.gameData.membershipData.dirty = true;
                }
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
