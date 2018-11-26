package model.logic.commands.messages {
import model.data.users.messages.AdviserTypeId;
import model.data.users.messages.Message;
import model.logic.MessageManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class GetNewestMessagesCmd extends BaseCmd {


    private var _groupId:int;

    private var _count:Number;

    private var _fromMessageId:Number;

    private var requestDto;

    public function GetNewestMessagesCmd(param1:int, param2:Number, param3:Number = -1) {
        super();
        this._groupId = param1;
        this._count = param2;
        this._fromMessageId = param3;
        this.requestDto = {
            "o": {
                "c": this._count,
                "g": this._groupId
            }
        };
        if (this._fromMessageId > -1) {
            this.requestDto.o.s = this._fromMessageId;
        }
        MessageManager.populateWithMessageIdsShort(this.requestDto);
    }

    override public function execute():void {
        new JsonCallCmd("Messages.GetNewest", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = Message.fromDtos(param1);
            var _loc3_:* = UserManager.user.gameData.messageData;
            var _loc4_:* = _loc3_.addedByClientMessages && _loc3_.addedByClientMessages[_groupId] ? _loc3_.addedByClientMessages[_groupId] : [];
            if (_loc2_.length < _count && _loc4_) {
                _loc2_ = _loc2_.addAll(_loc4_);
            }
            switch (_groupId) {
                case AdviserTypeId.MILITARY:
                    _loc3_.knownBattleReports = _loc2_;
                    break;
                case AdviserTypeId.DIPLOMATIC:
                    _loc3_.knownDiplomaticMessages = _loc2_;
                    break;
                case AdviserTypeId.SCIENTIFIC:
                    _loc3_.knownScientistMessages = _loc2_;
                    break;
                case AdviserTypeId.TRADE:
                    _loc3_.knownTradeMessages = _loc2_;
            }
            _loc3_.advisersExternalMessagesDirtyLoadOld = true;
            if (_onResult != null) {
                _onResult(_loc2_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
