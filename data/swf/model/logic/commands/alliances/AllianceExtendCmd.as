package model.logic.commands.alliances {
import model.logic.AllianceExtension;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class AllianceExtendCmd extends BaseCmd {


    private var requestDto;

    private var _allianceId:Number;

    private var _ext:AllianceExtension;

    public function AllianceExtendCmd(param1:Number, param2:AllianceExtension) {
        super();
        this._allianceId = param1;
        this._ext = param2;
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "a": this._allianceId,
            "i": this._ext.id
        });
    }

    public static function getNextExtension(param1:int):AllianceExtension {
        var _loc2_:AllianceExtension = null;
        if (StaticDataManager.allianceData.allianceEtensions == null) {
            return null;
        }
        for each(_loc2_ in StaticDataManager.allianceData.allianceEtensions) {
            if (_loc2_.membersLimit > param1) {
                return _loc2_;
            }
        }
        return null;
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.Extend", this.requestDto, "POST").ifResult(function (param1:*):void {
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                UserManager.user.gameData.account.resources.substract(_ext.price);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
