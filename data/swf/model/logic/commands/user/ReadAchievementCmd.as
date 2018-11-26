package model.logic.commands.user {
import model.data.users.achievements.Achievement;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class ReadAchievementCmd extends BaseCmd {


    private var _ach:Achievement;

    private var _requestDto;

    public function ReadAchievementCmd(param1:Achievement) {
        super();
        this._ach = param1;
        this._requestDto = UserRefreshCmd.makeRequestDto({
            "i": this._ach.typeId,
            "l": this._ach.level
        });
    }

    override public function execute():void {
        new JsonCallCmd("ReadAchievement", this._requestDto, "POST").ifResult(function (param1:*):void {
            UserManager.user.gameData.statsData.achievementsDirty = true;
            UserRefreshCmd.updateUserByResultDto(param1, _requestDto);
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
