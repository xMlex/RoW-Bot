package model.data.inventory {
import common.localization.LocaleUtil;

import model.data.scenes.types.info.TechnologyTypeId;

public class InventoryItemTier {

    public static var ALL_TIERS:int = -1;

    public static var TIER_1:int = TechnologyTypeId.TechIdBarracks;

    public static var TIER_2:int = TechnologyTypeId.TechIdMotorizedInfantryFactory;

    public static var TIER_3:int = TechnologyTypeId.TechIdArtillerySystemsCenter;

    public static var TIER_4:int = TechnologyTypeId.TechIdAerospaceComplex;


    public function InventoryItemTier() {
        super();
    }

    public static function getName(param1:int):String {
        var _loc2_:String = "";
        switch (param1) {
            case TIER_1:
                _loc2_ = "forms-common_tear1";
                break;
            case TIER_2:
                _loc2_ = "forms-common_tier2";
                break;
            case TIER_3:
                _loc2_ = "forms-common_tier3";
                break;
            case TIER_4:
                _loc2_ = "forms-common_tier4";
        }
        return LocaleUtil.getText(_loc2_);
    }
}
}
