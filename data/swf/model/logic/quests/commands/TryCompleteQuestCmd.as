package model.logic.quests.commands {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class TryCompleteQuestCmd extends BaseCmd {

    public static const Skipped:int = -1;


    private var requestDto;

    protected var _onQuestNotFound:Function;

    public function TryCompleteQuestCmd(param1:int, param2:Number) {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "c": param1,
            "p": param2
        });
    }

    override public function execute():void {
        new JsonCallCmd("TryCompleteQuest", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = param1.o;
            if (!_loc2_ && _onQuestNotFound != null) {
                _onQuestNotFound();
                return;
            }
            UserRefreshCmd.updateUserByResultDto(param1, requestDto);
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
