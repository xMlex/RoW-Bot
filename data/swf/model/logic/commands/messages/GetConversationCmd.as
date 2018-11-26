package model.logic.commands.messages {
import model.data.users.messages.ClientMessagesDataByTypes;
import model.data.users.messages.Message;
import model.logic.AllianceManager;
import model.logic.MessageManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class GetConversationCmd extends BaseCmd {


    private var _userId:int;

    private var requestDto;

    public function GetConversationCmd(param1:Number) {
        super();
        this._userId = param1;
        this.requestDto = {"o": {"u": this._userId}};
        MessageManager.populateWithMessageIdsShort(this.requestDto);
    }

    override public function execute():void {
        new JsonCallCmd("Messages.GetConversation", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc5_:* = undefined;
            var _loc6_:* = undefined;
            var _loc7_:* = undefined;
            var _loc2_:* = Message.fromDtos(param1);
            MessageManager.refreshUnknownData(_loc2_);
            var _loc3_:* = UserManager.user.gameData.messageData;
            if (!_loc3_.clientMessageData) {
                _loc3_.clientMessageData = new ClientMessagesDataByTypes();
            }
            var _loc4_:* = _loc3_.clientMessageData;
            if (_userId != UserManager.user.id) {
                _loc5_ = _loc3_.knownUserConversation;
                if (_loc4_.usersMessagesDictionary && _loc2_.length > 0) {
                    _loc4_.usersMessagesDictionary[_userId] = _loc2_;
                }
                if (AllianceManager.currentMember && AllianceManager.currentAlliance.gameData.membershipData.getMember(_userId) && _loc2_.length > 0) {
                    _loc4_.messagesFromAllianceMemberships[_userId] = _loc2_;
                }
                _loc5_[_userId] = _userId;
            }
            else {
                _loc6_ = _loc3_.knownAllianceConversation;
                for each(_loc7_ in _loc2_) {
                    if (_loc7_.allianceId) {
                        if (!_loc6_[_loc7_.allianceId]) {
                            _loc6_[_loc7_.allianceId] = _loc7_.allianceId;
                            UserManager.user.gameData.messageData.clientMessageData.allianceMessages[_loc7_.allianceId] = [];
                        }
                        _loc4_.allianceMessages[_loc7_.allianceId].push(_loc7_);
                    }
                }
            }
            if (_onResult != null) {
                _onResult(_loc2_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
