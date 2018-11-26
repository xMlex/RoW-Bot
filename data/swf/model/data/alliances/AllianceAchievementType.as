package model.data.alliances {
import common.ArrayCustom;

import configs.Global;

public class AllianceAchievementType {

    public static const BrotherhoodOfSteel:int = 1;

    public static const Raiders:int = 2;

    public static const Overlords:int = 3;

    public static const DogsOfWar:int = 4;

    public static const Supermutants:int = 5;

    public static const TheChosen:int = 6;

    public static const Enclave:int = 7;

    public static const Spartans:int = 8;

    public static const Challenges:int = 9;

    public static const ChallengePoints:int = 10;

    public static const GuardianGeotopia:int = 11;

    public static const TroopsTrained:int = 12;

    public static const RaidLocationsCompleted:int = 13;

    public static const ResourcesRobbed:int = 14;

    public static const DailyQuestsCompleted:int = 15;

    public static const TroopsKilled:int = 16;

    public static const TowersUpgraded:int = 17;

    public static const StatyType:int = BrotherhoodOfSteel;

    public static const EndType:int = GuardianGeotopia;


    public var typeId:int;

    public var textName:String;

    public var textGoal:String;

    public var textProgress:String;

    public var textCompleted:String;

    public var levelInfos:ArrayCustom;

    public function AllianceAchievementType() {
        super();
    }

    public static function fromDto(param1:*):AllianceAchievementType {
        var _loc2_:AllianceAchievementType = new AllianceAchievementType();
        if (!param1) {
            return _loc2_;
        }
        _loc2_.typeId = param1.i;
        _loc2_.textName = param1.n.c;
        _loc2_.textGoal = param1.g.c;
        _loc2_.textProgress = param1.p.c;
        _loc2_.textCompleted = param1.c.c;
        _loc2_.levelInfos = AllianceAchievementLevelInfo.fromDtos(param1.li);
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public function getLevel(param1:int):AllianceAchievementLevelInfo {
        if (!Global.ACHIEVEMENTS_LEVELS_ENABLED || param1 == 0) {
            return this.levelInfos[0];
        }
        if (this.levelInfos != null) {
            return this.levelInfos[param1 - 1];
        }
        return null;
    }
}
}
