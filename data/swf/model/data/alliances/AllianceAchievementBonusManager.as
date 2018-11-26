package model.data.alliances {
import common.GameType;
import common.localization.LocaleUtil;

import model.data.scenes.types.GeoSceneObjectType;
import model.logic.StaticDataManager;

public class AllianceAchievementBonusManager {


    public function AllianceAchievementBonusManager() {
        super();
    }

    public static function getAllianceBonusString(param1:AlianceAchievementBonusInfo, param2:AlianceAchievementBonusInfo = null):String {
        var _loc3_:* = "";
        if (param1.bonusAllianceRatingK > 0) {
            _loc3_ = _loc3_ + LocaleUtil.buildString("allianceAchievementBonus_Alliance_Rating", ratingFormator(param1.bonusAllianceRatingK * 100, 1));
        }
        if (param1.attackBonus > 0 && (!param2 || param1.attackBonus != param2.attackBonus)) {
            if (_loc3_ != "") {
                _loc3_ = _loc3_ + "\n";
            }
            _loc3_ = _loc3_ + LocaleUtil.buildString("allianceAchievementBonus_Attack", ratingFormator(param1.attackBonus, 1));
        }
        if (param1.defenseBonus > 0 && (!param2 || param1.defenseBonus != param2.defenseBonus)) {
            if (_loc3_ != "") {
                _loc3_ = _loc3_ + "\n";
            }
            _loc3_ = _loc3_ + LocaleUtil.buildString("allianceAchievementBonus_Defense", ratingFormator(param1.defenseBonus, 1));
        }
        if (param1.antigenBonus > 0 && (!param2 || param1.antigenBonus != param2.antigenBonus)) {
            if (_loc3_ != "") {
                _loc3_ = _loc3_ + "\n";
            }
            _loc3_ = _loc3_ + LocaleUtil.buildString("allianceAchievementBonus_Antigen", ratingFormator(param1.antigenBonus, 1));
        }
        return _loc3_;
    }

    public static function getAllianceBonusCurrentString(param1:AlianceAchievementBonusInfo, param2:AlianceAchievementBonusInfo = null):String {
        var _loc3_:* = "";
        if (param1.bonusAllianceRatingK > 0) {
            _loc3_ = _loc3_ + LocaleUtil.buildString("allianceAchievementBonus_Alliance_Rating", ratingFormator(param1.bonusAllianceRatingK * 100, 1));
        }
        if (param1.attackBonus > 0) {
            if (_loc3_ != "") {
                _loc3_ = _loc3_ + "\n";
            }
            _loc3_ = _loc3_ + LocaleUtil.buildString("allianceAchievementBonus_Attack", ratingFormator(param1.attackBonus, 1));
        }
        if (param1.defenseBonus > 0) {
            if (_loc3_ != "") {
                _loc3_ = _loc3_ + "\n";
            }
            _loc3_ = _loc3_ + LocaleUtil.buildString("allianceAchievementBonus_Defense", ratingFormator(param1.defenseBonus, 1));
        }
        if (param1.antigenBonus > 0) {
            if (_loc3_ != "") {
                _loc3_ = _loc3_ + "\n";
            }
            _loc3_ = _loc3_ + LocaleUtil.buildString("allianceAchievementBonus_Antigen", ratingFormator(param1.antigenBonus, 1));
        }
        return _loc3_;
    }

    public static function getInfluenceBonusString(param1:AlianceAchievementBonusInfo):String {
        var _loc2_:String = "";
        if (param1) {
            _loc2_ = !!GameType.isNords ? (param1.influencePoints * 45).toString() : (param1.influencePoints * 450).toString();
        }
        return _loc2_;
    }

    public static function getPrivateBonusString(param1:AlianceAchievementBonusInfo):String {
        var _loc3_:GeoSceneObjectType = null;
        var _loc4_:int = 0;
        var _loc5_:* = undefined;
        var _loc2_:* = "";
        if (param1.bonusUserTroops != null) {
            _loc4_ = 0;
            for (_loc5_ in param1.bonusUserTroops.countByType) {
                _loc4_++;
                _loc3_ = StaticDataManager.getObjectType(int(_loc5_));
                _loc2_ = _loc2_ + (_loc3_.name + ": " + param1.bonusUserTroops.countByType[_loc5_]);
                if (_loc4_ < param1.bonusUserTroops.getTypesLength()) {
                    _loc2_ = _loc2_ + ", ";
                }
            }
            _loc2_ = _loc2_ + (" " + LocaleUtil.getText("allianceAchievementBonus_Troops"));
        }
        if (param1.bonusArtifactTypeId > 0) {
            if (_loc2_ != "") {
                _loc2_ = _loc2_ + "\n";
            }
            _loc2_ = _loc2_ + LocaleUtil.buildString("allianceAchievementBonus_Artefact");
        }
        if (param1.bonusUserSkillPoints > 0) {
            if (_loc2_ != "") {
                _loc2_ = _loc2_ + "\n";
            }
            _loc2_ = _loc2_ + LocaleUtil.buildString("allianceAchievementBonus_SkillPoints", ratingFormator(param1.bonusUserSkillPoints, 1));
        }
        return _loc2_;
    }

    public static function ratingFormator(param1:Number, param2:int):String {
        if (param1 == 0) {
            return "0";
        }
        if (param1 % 1 == 0) {
            return param1.toFixed(0);
        }
        var _loc3_:String = param1.toFixed(param2);
        var _loc4_:String = _loc3_;
        var _loc5_:Boolean = true;
        var _loc6_:int = _loc3_.length - 1;
        while (_loc5_ && _loc6_ >= 0) {
            if (_loc3_.charAt(_loc6_) == ".") {
                _loc5_ = false;
                _loc4_ = _loc3_.slice(0, _loc6_);
                break;
            }
            if (_loc3_.charAt(_loc6_) == "0") {
                _loc4_ = _loc3_.slice(0, _loc6_);
                _loc6_--;
                continue;
            }
            _loc5_ = false;
            break;
        }
        return _loc4_;
    }
}
}
