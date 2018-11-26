package model.logic.misc {
import common.GameType;
import common.localization.LocaleUtil;

import flash.utils.Dictionary;

import model.data.RankTypeId;

public class RankManager {

    private static var _ranksData:Dictionary;


    public function RankManager() {
        super();
    }

    public static function setRankData(param1:Dictionary):void {
        _ranksData = param1;
    }

    public static function getRankTypeIdByDaysCount(param1:int):int {
        if (param1 < 2) {
            return RankTypeId.Rookie;
        }
        if (param1 >= 2 && param1 < 5) {
            return RankTypeId.Ranker;
        }
        if (param1 >= 5 && param1 < 9) {
            return RankTypeId.Soldier;
        }
        if (param1 >= 9 && param1 < 14) {
            return RankTypeId.Corporal;
        }
        if (param1 >= 14 && param1 < 19) {
            return RankTypeId.Sergeant;
        }
        if (param1 >= 19 && param1 < 26) {
            return RankTypeId.SergeantMajor;
        }
        if (param1 >= 26 && param1 < 34) {
            return RankTypeId.Ensign;
        }
        if (param1 >= 34 && param1 < 43) {
            return RankTypeId.Veteran;
        }
        if (param1 >= 43 && param1 < 53) {
            return RankTypeId.Lieutenant;
        }
        if (param1 >= 53 && param1 < 64) {
            return RankTypeId.Captain;
        }
        if (param1 >= 64 && param1 < 76) {
            return RankTypeId.Major;
        }
        if (param1 >= 76 && param1 < 89) {
            return RankTypeId.LieutenantColonel;
        }
        if (param1 >= 89 && param1 < 103) {
            return RankTypeId.Colonel;
        }
        if (param1 >= 103 && param1 < 119) {
            return RankTypeId.General;
        }
        if (param1 >= 119 && param1 < 134) {
            return RankTypeId.Marshal;
        }
        if (param1 >= 134 && param1 < 179) {
            return RankTypeId.Commander;
        }
        param1 >= 179;
        return RankTypeId.Hero;
    }

    public static function isNewRank(param1:int):Boolean {
        return param1 == 0 || param1 == 2 || param1 == 5 || param1 == 9 || param1 == 14 || param1 == 19 || param1 == 26 || param1 == 34 || param1 == 43 || param1 == 53 || param1 == 64 || param1 == 76 || param1 == 89 || param1 == 103 || param1 == 119 || param1 == 134 || param1 == 179;
    }

    public static function getDaysCountLeft(param1:int):int {
        if (param1 < 2) {
            return 2 - param1;
        }
        if (param1 >= 2 && param1 < 5) {
            return 5 - param1;
        }
        if (param1 >= 5 && param1 < 9) {
            return 9 - param1;
        }
        if (param1 >= 9 && param1 < 14) {
            return 14 - param1;
        }
        if (param1 >= 14 && param1 < 19) {
            return 19 - param1;
        }
        if (param1 >= 19 && param1 < 26) {
            return 26 - param1;
        }
        if (param1 >= 26 && param1 < 34) {
            return 34 - param1;
        }
        if (param1 >= 34 && param1 < 43) {
            return 43 - param1;
        }
        if (param1 >= 43 && param1 < 53) {
            return 53 - param1;
        }
        if (param1 >= 53 && param1 < 64) {
            return 64 - param1;
        }
        if (param1 >= 64 && param1 < 76) {
            return 76 - param1;
        }
        if (param1 >= 76 && param1 < 89) {
            return 89 - param1;
        }
        if (param1 >= 89 && param1 < 103) {
            return 103 - param1;
        }
        if (param1 >= 103 && param1 < 119) {
            return 119 - param1;
        }
        if (param1 >= 119 && param1 < 134) {
            return 134 - param1;
        }
        if (param1 >= 134 && param1 < 179) {
            return 179 - param1;
        }
        return -1;
    }

    public static function getRankTooltip(param1:int):String {
        var _loc2_:int = getDaysCountLeft(param1);
        return _loc2_ >= 0 ? LocaleUtil.getText("model-logic-misc-rankManager-notHero") + " " + getDaysString(_loc2_) : LocaleUtil.getText("model-logic-misc-rankManager-hero");
    }

    private static function getDaysString(param1:int):String {
        if (param1 % 10 == 1) {
            return param1.toString() + " " + LocaleUtil.getText("model-logic-misc-rankManager-day1");
        }
        if (param1 % 10 == 2 || param1 % 10 == 3 || param1 % 10 == 4) {
            return param1.toString() + " " + LocaleUtil.getText("model-logic-misc-rankManager-day2");
        }
        return param1.toString() + " " + LocaleUtil.getText("model-logic-misc-rankManager-day5");
    }

    public static function getRankUrlByTypeId(param1:int):String {
        if (GameType.isTotalDomination) {
            switch (param1) {
                case RankTypeId.Rookie:
                    return "ui/rank/Rank01.png";
                case RankTypeId.Ranker:
                    return "ui/rank/Rank02.png";
                case RankTypeId.Soldier:
                    return "ui/rank/Rank03.png";
                case RankTypeId.Corporal:
                    return "ui/rank/Rank04.png";
                case RankTypeId.Sergeant:
                    return "ui/rank/Rank05.png";
                case RankTypeId.SergeantMajor:
                    return "ui/rank/Rank06.png";
                case RankTypeId.Ensign:
                    return "ui/rank/Rank07.png";
                case RankTypeId.Veteran:
                    return "ui/rank/Rank08.png";
                case RankTypeId.Lieutenant:
                    return "ui/rank/Rank09.png";
                case RankTypeId.Captain:
                    return "ui/rank/Rank10.png";
                case RankTypeId.Major:
                    return "ui/rank/Rank11.png";
                case RankTypeId.LieutenantColonel:
                    return "ui/rank/Rank12.png";
                case RankTypeId.Colonel:
                    return "ui/rank/Rank13.png";
                case RankTypeId.General:
                    return "ui/rank/Rank14.png";
                case RankTypeId.Marshal:
                    return "ui/rank/Rank15.png";
                case RankTypeId.Commander:
                    return "ui/rank/Rank16.png";
                case RankTypeId.Hero:
                    return "ui/rank/Rank17.png";
            }
        }
        return _ranksData[param1];
    }

    public static function getRankNameByTypeId(param1:int):String {
        switch (param1) {
            case RankTypeId.Rookie:
                return LocaleUtil.getText("model-logic-misc-rankManager-rankRookie");
            case RankTypeId.Ranker:
                return LocaleUtil.getText("model-logic-misc-rankManager-rankRanker");
            case RankTypeId.Soldier:
                return LocaleUtil.getText("model-logic-misc-rankManager-rankSoldier");
            case RankTypeId.Corporal:
                return LocaleUtil.getText("model-logic-misc-rankManager-rankCorporal");
            case RankTypeId.Sergeant:
                return LocaleUtil.getText("model-logic-misc-rankManager-rankSergeant");
            case RankTypeId.SergeantMajor:
                return LocaleUtil.getText("model-logic-misc-rankManager-rankSergeantMajor");
            case RankTypeId.Ensign:
                return LocaleUtil.getText("model-logic-misc-rankManager-rankEnsign");
            case RankTypeId.Veteran:
                return LocaleUtil.getText("model-logic-misc-rankManager-rankVeteran");
            case RankTypeId.Lieutenant:
                return LocaleUtil.getText("model-logic-misc-rankManager-rankLieutenant");
            case RankTypeId.Captain:
                return LocaleUtil.getText("model-logic-misc-rankManager-rankCaptain");
            case RankTypeId.Major:
                return LocaleUtil.getText("model-logic-misc-rankManager-rankMajor");
            case RankTypeId.LieutenantColonel:
                return LocaleUtil.getText("model-logic-misc-rankManager-rankLieutenantColonel");
            case RankTypeId.Colonel:
                return LocaleUtil.getText("model-logic-misc-rankManager-rankColonel");
            case RankTypeId.General:
                return LocaleUtil.getText("model-logic-misc-rankManager-rankGeneral");
            case RankTypeId.Marshal:
                return LocaleUtil.getText("model-logic-misc-rankManager-rankMarshal");
            case RankTypeId.Commander:
                return LocaleUtil.getText("model-logic-misc-rankManager-rankCommander");
            case RankTypeId.Hero:
                return LocaleUtil.getText("model-logic-misc-rankManager-rankHero");
            default:
                return "";
        }
    }
}
}
