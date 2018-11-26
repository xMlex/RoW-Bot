package model.logic.commands.allianceCity {
import model.logic.AllianceManager;
import model.logic.commands.alliances.BaseAllianceCmd;
import model.logic.commands.server.JsonCallCmd;

public class AllianceCityUpgradeTechnologyCmd extends BaseAllianceCmd {


    private var _dto;

    public function AllianceCityUpgradeTechnologyCmd(param1:int) {
        super();
        this._dto = makeRequestDto({
            "a": AllianceManager.currentAlliance.id,
            "c": AllianceManager.currentAlliance.gameData.cityData.allianceCityId,
            "t": param1
        });
    }

    override public function execute():void {
        new JsonCallCmd("AllianceCity.UpgradeTechnology", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            updateAllianceByResultDto(param1);
        }).execute();
    }
}
}
