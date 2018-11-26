package model.data.specialOfferTriggers {
public class TriggerEventTypeEnum {

    public static const REVENGE:int = 1;

    public static const BATTLE_FAILURE:int = 2;

    public static const GOLD_RUNNING_LOW:int = 3;

    public static const NEGATIVE_MONEY_PRODUCTION:int = 4;

    public static const OUT_OF_WORKERS:int = 5;

    public static const JOINED_ALLIANCE:int = 6;

    public static const ONE_DRAWING_LEFT_TO_RESEARCH:int = 7;

    public static const NO_PURCHASES_BANK_VISIT:int = 8;

    public static const VIP_LEVEL_UP:int = 9;

    public static const RESURRECTION:int = 10;

    public static const BUILDING_UPGRADE_TO_ADDITIONAL_LEVEL:int = 11;

    public static const EXTRACTOR_RIG:int = 12;

    public static const BOOST_RESEARCH:int = 13;

    public static const DISTRIBUTING_SKILL_TREE:int = 14;

    public static const LONG_SESSIONS:int = 15;

    public static const STARTER_PACK:int = 17;

    public static const ALL_WORKERS_BUSY:int = 19;

    public static const SECOND_HERO_BREAKER:int = 20;

    public static const SHOW_FORTIFICATION_PACK:int = 21;

    public static const BATTLE_REPORT_OPENED:int = 1000;

    public static const BUILDING_FINISHED:int = 1001;

    public static const SKILL_TREE_OPENED:int = 1002;

    public static const TROOPS_LOSSES:int = 1003;

    public static const TECH_TREE_OPENED:int = 1004;

    public static const SECOND_HERO_BREAKER_TRIGGER_EVENT:int = 1005;


    public function TriggerEventTypeEnum() {
        super();
    }

    public static function getNameByType(param1:int):String {
        var _loc2_:String = "";
        switch (param1) {
            case OUT_OF_WORKERS:
                _loc2_ = "OutOfWorkers";
                break;
            case NO_PURCHASES_BANK_VISIT:
                _loc2_ = "NoPurchasesBankVisit";
                break;
            case BOOST_RESEARCH:
                _loc2_ = "BoostResearch";
                break;
            case BATTLE_REPORT_OPENED:
                _loc2_ = "BattleReportOpened";
                break;
            case SKILL_TREE_OPENED:
                _loc2_ = "SkillTreeOpened";
                break;
            case TECH_TREE_OPENED:
                _loc2_ = "TechTreeOpened";
        }
        return _loc2_;
    }
}
}
