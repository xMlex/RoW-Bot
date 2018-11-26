package model.logic.commands.chat {
import model.data.alliances.chat.AllianceChatData;
import model.logic.AllianceManager;
import model.logic.commands.alliances.BaseAllianceCmd;
import model.logic.commands.server.JsonCallCmd;

public class RemoveChatRoomCmd extends BaseAllianceCmd {


    private var _dto;

    public var roomId:Number;

    public function RemoveChatRoomCmd(param1:Number) {
        super();
        this._dto = makeRequestDto({"r": param1});
        this.roomId = param1;
    }

    override public function execute():void {
        new JsonCallCmd("AllianceManager.RemoveChatRoom", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData;
                if (!_loc2_.chatData) {
                    _loc2_.chatData = new AllianceChatData();
                }
                _loc2_.chatData.rooms[roomId] = null;
                _loc2_.chatData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
