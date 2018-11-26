package model.logic.commands.alliances {
import model.data.alliances.KnownAlliance;
import model.logic.AllianceManager;
import model.logic.ServerTimeManager;
import model.logic.commands.server.JsonCallCmd;

public class AllianceRelationshipAcceptCmd extends BaseAllianceCmd {


    private var _allianceId:Number;

    private var _dto;

    public function AllianceRelationshipAcceptCmd(param1:Number) {
        super();
        this._allianceId = param1;
        this._dto = makeRequestDto(this._allianceId);
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.AcceptRelationship", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc6_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData.knownAllianceData;
                _loc3_ = _loc2_.getKnownAllianceRequestById(_allianceId);
                if (_loc3_) {
                    _loc4_ = _loc2_.getKnownAllianceById(_allianceId);
                    _loc5_ = ServerTimeManager.serverTimeNow;
                    if (_loc4_) {
                        _loc4_.knownAllianceActiveInfo.type = _loc3_.type;
                        _loc4_.knownAllianceActiveInfo.startDate = _loc5_;
                    }
                    else {
                        _loc6_ = KnownAlliance.createActived(_allianceId, _loc3_.type);
                        _loc6_.knownAllianceActiveInfo.startDate = _loc5_;
                        _loc2_.knownAlliances.addItem(_loc6_);
                    }
                    _loc2_.removeKnownAllianceRequestById(_allianceId);
                    _loc2_.dirty = true;
                }
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
