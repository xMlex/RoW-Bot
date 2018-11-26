package model.logic.commands.alliances {
import common.ArrayCustom;

import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class AllowSeeUnitStatisticsCmd extends BaseAllianceCmd {


    private var _rankIds:Array;

    private var _dto;

    public function AllowSeeUnitStatisticsCmd(param1:Array) {
        super();
        this._rankIds = param1;
        this._dto = makeRequestDto({"d": this._rankIds});
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.AllowSeeTroopsStatistics", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            if (!updateAllianceByResultDto(param1)) {
                AllianceManager.currentAlliance.gameData.membershipData.allowedToSeeTroopsStats = new ArrayCustom(_rankIds);
                AllianceManager.currentAlliance.gameData.membershipData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
