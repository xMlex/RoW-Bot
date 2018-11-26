package model.logic.commands.wizard {
import flash.net.URLRequest;
import flash.net.navigateToURL;

import model.data.quests.QuestPrototypeId;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.quests.data.QuestState;

public class CheckUserJoinedGroupCmd extends BaseCmd {


    private var requestDto;

    private var _openWindowUrl:String;

    public function CheckUserJoinedGroupCmd(param1:int, param2:Number, param3:String) {
        super();
        this._openWindowUrl = param3;
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "c": param1,
            "p": param2
        });
    }

    override public function execute():void {
        new JsonCallCmd("CheckUserJoinedGroup", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            UserRefreshCmd.updateUserByResultDto(param1, requestDto);
            for each(_loc2_ in UserManager.user.gameData.questData.openedStates) {
                if (_loc2_.prototypeId == QuestPrototypeId.OdnoklassnikiJoinGroup || _loc2_.prototypeId == QuestPrototypeId.MailRuJoinGroup || _loc2_.prototypeId == QuestPrototypeId.VkJoinGroup) {
                    if (_loc2_.stateId != QuestState.StateId_Completed) {
                        navigateToURL(new URLRequest(_openWindowUrl), "_blank");
                    }
                }
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
