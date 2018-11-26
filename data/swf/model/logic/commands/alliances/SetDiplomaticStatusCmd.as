package model.logic.commands.alliances {
import model.data.alliances.diplomacy.DiplomaticStatus;
import model.data.alliances.diplomacy.DiplomaticStatusTypeId;
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class SetDiplomaticStatusCmd extends BaseAllianceCmd {


    private var _status:DiplomaticStatus;

    private var _dto;

    public function SetDiplomaticStatusCmd(param1:DiplomaticStatus) {
        super();
        this._status = param1;
        this._dto = makeRequestDto(this._status.toDto());
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.SetDiplomaticStatus", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData.diplomacyData;
                _loc3_ = _loc2_.getStatus(_status.allianceId);
                if (_loc3_ != null) {
                    _loc2_.diplomaticStatuses.removeItemAt(_loc2_.diplomaticStatuses.getItemIndex(_loc3_));
                }
                if (_status.typeId != DiplomaticStatusTypeId.NONE) {
                    _loc2_.diplomaticStatuses.addItem(_status);
                }
                _loc2_.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
