package model.data.alliances {
import model.data.users.troops.Troops;

public class AlianceAchievementBonusInfo {


    public var bonusAllianceRatingK:Number;

    public var bonusUserSkillPoints:int;

    public var bonusUserTroops:Troops;

    public var bonusArtifactTypeId:int;

    public var antigenBonus:Number;

    public var attackBonus:Number;

    public var defenseBonus:Number;

    public var influencePoints:Number;

    public function AlianceAchievementBonusInfo() {
        super();
    }

    public static function fromDto(param1:*):AlianceAchievementBonusInfo {
        var _loc2_:AlianceAchievementBonusInfo = new AlianceAchievementBonusInfo();
        if (param1 == null) {
            return _loc2_;
        }
        _loc2_.bonusAllianceRatingK = param1.r;
        _loc2_.bonusUserSkillPoints = param1.s;
        _loc2_.bonusUserTroops = param1.t == null ? null : Troops.fromDto(param1.t);
        _loc2_.bonusArtifactTypeId = !!isNaN(param1.a) ? 0 : int(param1.a);
        _loc2_.antigenBonus = param1.m;
        _loc2_.attackBonus = param1.o;
        _loc2_.defenseBonus = param1.d;
        _loc2_.influencePoints = param1.f;
        return _loc2_;
    }

    public function hasUserBonus():Boolean {
        return this.bonusUserSkillPoints != 0 || this.bonusUserTroops != null && !this.bonusUserTroops.Empty || this.bonusArtifactTypeId > 0;
    }
}
}
