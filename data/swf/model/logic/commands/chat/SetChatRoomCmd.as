package model.logic.commands.chat {
import flash.utils.Dictionary;

import model.data.alliances.chat.AllianceChatData;
import model.data.alliances.chat.AllianceChatRoomData;
import model.logic.AllianceManager;
import model.logic.commands.alliances.BaseAllianceCmd;
import model.logic.commands.server.JsonCallCmd;

public class SetChatRoomCmd extends BaseAllianceCmd {


    private var _dto;

    public var roomId:Number;

    public var roomData:AllianceChatRoomData;

    public function SetChatRoomCmd(param1:Number, param2:AllianceChatRoomData) {
        super();
        this._dto = makeRequestDto({
            "r": param1,
            "s": param2.toDto()
        });
        this.roomId = param1;
        this.roomData = param2;
    }

    override public function execute():void {
        new JsonCallCmd("AllianceManager.SetChatRoom", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData;
                if (!_loc2_.chatData) {
                    _loc2_.chatData = new AllianceChatData();
                }
                _loc2_.chatData.rooms[roomId] = roomData;
                _loc3_ = new Dictionary();
                for each(_loc4_ in roomData.allowedRanks) {
                    _loc3_[_loc4_] = true;
                }
                _loc2_.chatData.rooms[roomId].allowedRanksDictionary = _loc3_;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
