package model.logic.quests.commands {
import model.data.quests.QuestCategoryId;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.quests.completions.QuestCompletionPeriodic;
import model.logic.quests.periodicQuests.ComplexSource;
import model.logic.quests.periodicQuests.enums.PeriodicQuestPrototypeId;

public class CloseQuestCmd extends BaseCmd {

    private static var executionQuestIdList:Vector.<int> = new Vector.<int>();


    private var _questId:int;

    private var requestDto;

    public function CloseQuestCmd(param1:int, param2:Array = null) {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "i": param1,
            "b": param2
        });
        executionQuestIdList.push(param1);
        this._questId = param1;
    }

    public static function executing(param1:int):Boolean {
        var _loc2_:int = 0;
        while (_loc2_ < executionQuestIdList.length) {
            if (executionQuestIdList[_loc2_] == param1) {
                return true;
            }
            _loc2_++;
        }
        return false;
    }

    private static function clearExecution(param1:int):void {
        var _loc2_:Number = executionQuestIdList.indexOf(param1, 0);
        if (_loc2_ != -1) {
            executionQuestIdList.splice(_loc2_, 1);
        }
    }

    override public function execute():void {
        new JsonCallCmd("CloseQuest", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user.gameData.questData.getQuestById(_questId);
                if (_loc2_.categoryId == QuestCategoryId.Periodic) {
                    _loc3_ = UserManager.user.gameData.questData.getQuestStateByQuestId(_questId);
                    _loc4_ = ComplexSource.fromQuestData(_loc2_, _loc3_);
                    QuestCompletionPeriodic.tryComplete(_loc4_, [[PeriodicQuestPrototypeId.PerformPack]]);
                }
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(function (param1:*):void {
            if (_onFault != null) {
                _onFault(param1);
            }
        }).ifIoFault(_onIoFault).doFinally(function ():void {
            if (_onFinally != null) {
                _onFinally();
            }
            clearExecution(_questId);
        }).execute();
    }
}
}
