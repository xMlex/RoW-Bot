package model.logic.quests.data {
import common.localization.LocaleUtil;

public class NonItemBonuses {

    public static const NOVICE_PROTECTION:int = 4;

    public static const TROOPS_AUTOHIDE_TO_BUNKER:int = 5;


    public function NonItemBonuses() {
        super();
    }

    public static function getBonusTextByType(param1:int):String {
        switch (param1) {
            case NonItemBonuses.NOVICE_PROTECTION:
                return LocaleUtil.getText("nonItemBonuses_novice_protection");
            case NonItemBonuses.TROOPS_AUTOHIDE_TO_BUNKER:
                return LocaleUtil.getText("nonItemBonuses_troops_autohide");
            default:
                return "";
        }
    }
}
}
