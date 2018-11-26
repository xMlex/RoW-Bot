package model.logic.commands.messages {
import common.ArrayCustom;

import model.data.users.messages.ClientMessagesDataByTypes;
import model.data.users.messages.Message;
import model.logic.MessageManager;
import model.logic.UserDemoManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class GetLastUnreadRelationMessageCmd extends BaseCmd {


    private var requestDto;

    public function GetLastUnreadRelationMessageCmd() {
        super();
        this.requestDto = {};
        MessageManager.populateWithMessageIdsShort(this.requestDto);
    }

    override public function execute():void {
        new JsonCallCmd("Messages.GetLastUnreadDiplomaticRelationsReport", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            if (param1) {
                _loc2_ = Message.fromDto(param1);
                _loc3_ = UserManager.user.gameData.messageData;
                if (!_loc3_.clientMessageData) {
                    _loc3_.clientMessageData = new ClientMessagesDataByTypes();
                }
                _loc4_ = _loc3_.clientMessageData;
                _loc3_.clientMessageData.usersMessagesDictionary[UserDemoManager.DemoUserId] = new Array();
                _loc4_.usersMessagesDictionary[UserDemoManager.DemoUserId].push(_loc2_);
                MessageManager.refreshUnknownData(new ArrayCustom([_loc2_]));
                _loc3_.personalExternalMessagesDirty = true;
                _loc3_.dispatchEvents();
                if (_onResult != null) {
                    _onResult(_loc2_);
                }
            }
            else if (_onResult != null) {
                _onResult(null);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
