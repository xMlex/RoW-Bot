package model.logic.quests.commands {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.quests.data.UserQuestDataWizard;

public class AddCompletedWizardCmd extends BaseCmd {


    private var _wizardKindIds:Array;

    public function AddCompletedWizardCmd(param1:Array) {
        super();
        this._wizardKindIds = param1;
    }

    override public function execute():void {
        new JsonCallCmd("AddCompletedWizard", this._wizardKindIds, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = UserManager.user.gameData.questData.wizardData;
            if (!UserManager.user.gameData.questData.wizardData) {
                UserManager.user.gameData.questData.wizardData = new UserQuestDataWizard();
            }
            var _loc3_:* = 0;
            while (_loc3_ < _wizardKindIds.length) {
                UserManager.user.gameData.questData.wizardData.completedWizards.push(_wizardKindIds[_loc3_]);
                _loc3_++;
            }
            _loc2_ = UserManager.user.gameData.questData.wizardData;
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
