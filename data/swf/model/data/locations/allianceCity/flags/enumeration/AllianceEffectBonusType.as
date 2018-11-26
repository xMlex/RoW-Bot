package model.data.locations.allianceCity.flags.enumeration {
import common.localization.LocaleUtil;

public class AllianceEffectBonusType {

    public static const AIR_ATTACK:int = 1;

    public static const ARTILLERY_ATTACK:int = 2;

    public static const AIR_DEFENCE:int = 3;

    public static const ARTILLERY_DEFENCE:int = 4;

    public static const MOVEMENT_SPEED:int = 5;

    public static const BATTLE_EXPERIENCE_BONUS:int = 6;

    public static const EXTRA_DAILY_ROBBERIES:int = 7;

    public static const INFLUENCE_POINTS:int = 8;

    public static const RESOURCES_TU_PRODUCTION_BOOST:int = 9;

    public static const RESOURCES_M_PRODUCTION_BOOST:int = 10;


    public function AllianceEffectBonusType() {
        super();
    }

    public static function getNameByType(param1:int):String {
        switch (param1) {
            case AIR_ATTACK:
                return LocaleUtil.getText("controls-common-allianceEffect_airAttack");
            case ARTILLERY_ATTACK:
                return LocaleUtil.getText("controls-common-allianceEffect_artilleryAttack");
            case AIR_DEFENCE:
                return LocaleUtil.getText("controls-common-allianceEffect_airDefence");
            case ARTILLERY_DEFENCE:
                return LocaleUtil.getText("controls-common-allianceEffect_artilleryDefence");
            case MOVEMENT_SPEED:
                return LocaleUtil.getText("controls-common-allianceEffect_movementSpeed");
            case BATTLE_EXPERIENCE_BONUS:
                return LocaleUtil.getText("controls-common-allianceEffect_xpBattlesBonus");
            case EXTRA_DAILY_ROBBERIES:
                return LocaleUtil.getText("controls-common-allianceEffect_extraDailyRaids");
            case INFLUENCE_POINTS:
                return LocaleUtil.getText("controls-common-allianceEffect_influencePoints");
            case RESOURCES_TU_PRODUCTION_BOOST:
                return LocaleUtil.getText("controls-common-allianceEffect_productionTU");
            case RESOURCES_M_PRODUCTION_BOOST:
                return LocaleUtil.getText("controls-common-allianceEffect_productionM");
            default:
                return "";
        }
    }
}
}
