package model.data.locations.allianceCity {
import common.localization.LocaleUtil;

import model.data.locations.allianceCity.flags.AllianceCityTournamentData;
import model.modules.allianceCity.IUpgradedItem;
import model.modules.allianceCity.data.resourceHistory.AllianceResources;

public class LocationAllianceCityData implements IUpgradedItem {


    public var level:int;

    public var highestLevel:int = 0;

    public var allianceId:Number;

    public var timeCreated:Date;

    public var lastTeleportationTime:Date;

    public var lastDowngradeTime:Date;

    public var upgradeResources:AllianceResources;

    public var upgradeStartTime:Date;

    public var upgradeFinishTime:Date;

    public var upgradeUserId:Number;

    public var technologyData:AllianceCityTechnologyData;

    public var tournamentData:AllianceCityTournamentData;

    public function LocationAllianceCityData() {
        super();
    }

    public static function fromDto(param1:*):LocationAllianceCityData {
        var _loc2_:LocationAllianceCityData = new LocationAllianceCityData();
        _loc2_.level = param1.l;
        _loc2_.highestLevel = param1.e;
        _loc2_.allianceId = param1.a;
        _loc2_.timeCreated = new Date(param1.c);
        _loc2_.lastTeleportationTime = param1.m == null ? null : new Date(param1.m);
        _loc2_.lastDowngradeTime = new Date(param1.d);
        _loc2_.upgradeResources = param1.ur == null ? new AllianceResources() : AllianceResources.fromDto(param1.ur);
        _loc2_.upgradeStartTime = param1.us == null ? null : new Date(param1.us);
        _loc2_.upgradeFinishTime = param1.uf == null ? null : new Date(param1.uf);
        _loc2_.upgradeUserId = param1.uu;
        _loc2_.technologyData = param1.td == null ? new AllianceCityTechnologyData() : AllianceCityTechnologyData.fromDto(param1.td);
        _loc2_.tournamentData = param1.fd == null ? null : AllianceCityTournamentData.fromDto(param1.fd);
        return _loc2_;
    }

    public function get startDate():Date {
        return this.upgradeStartTime;
    }

    public function get finishDate():Date {
        return this.upgradeFinishTime;
    }

    public function get currentLevel():int {
        return this.level;
    }

    public function get tooltipText():String {
        return LocaleUtil.buildString("forms-FormResourceHistory_operation_upgradeCityInProcess", (this.level + 1).toString());
    }

    public function toDto():* {
        var _loc1_:* = {
            "l": this.level,
            "a": this.allianceId,
            "c": this.timeCreated.time,
            "m": this.lastTeleportationTime.time,
            "d": this.lastDowngradeTime.time,
            "ur": this.upgradeResources.toDto(),
            "us": this.upgradeStartTime.time,
            "uf": this.upgradeFinishTime.time,
            "uu": this.upgradeUserId,
            "td": this.technologyData.toDto()
        };
        return _loc1_;
    }
}
}
