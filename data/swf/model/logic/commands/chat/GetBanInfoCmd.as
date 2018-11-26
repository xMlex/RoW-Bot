package model.logic.commands.chat {
import flash.utils.Dictionary;

import model.logic.chats.BanRoomInfo;
import model.logic.chats.ChatManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class GetBanInfoCmd extends BaseCmd {


    private var requestDto;

    public var roomIds:Array;

    public function GetBanInfoCmd(param1:Array) {
        super();
        this.requestDto = {"r": param1};
        this.roomIds = param1;
    }

    override public function execute():void {
        new JsonCallCmd("GetBanInfo", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (param1.r) {
                _loc2_ = new Dictionary();
                for (_loc3_ in param1.r) {
                    _loc2_[_loc3_] = BanRoomInfo.fromDto(param1.r[_loc3_]);
                }
                ChatManager.administrativeBanRoomsInfo = _loc2_;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
