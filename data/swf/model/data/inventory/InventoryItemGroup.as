package model.data.inventory {
import common.localization.LocaleUtil;

public class InventoryItemGroup {

    public static const SWORD:int = 0;

    public static const HELMET:int = 1;

    public static const SHIELD:int = 2;

    public static const CHEST_ARMOR:int = 3;

    public static const GLOVES:int = 4;

    public static const BOOTS:int = 5;

    public static const RING:int = 6;


    public function InventoryItemGroup() {
        super();
    }

    public static function getNameByGroup(param1:int):String {
        var _loc2_:String = "";
        switch (param1) {
            case SWORD:
                _loc2_ = "forms-formHero_inventoryItemGroup_sword";
                break;
            case HELMET:
                _loc2_ = "forms-formHero_inventoryItemGroup_hemlet";
                break;
            case SHIELD:
                _loc2_ = "forms-formHero_inventoryItemGroup_shield";
                break;
            case CHEST_ARMOR:
                _loc2_ = "forms-formHero_inventoryItemGroup_chestArmor";
                break;
            case GLOVES:
                _loc2_ = "forms-formHero_inventoryItemGroup_gloves";
                break;
            case BOOTS:
                _loc2_ = "forms-formHero_inventoryItemGroup_boots";
                break;
            case RING:
                _loc2_ = "forms-formHero_inventoryItemGroup_ring";
        }
        return LocaleUtil.getText(_loc2_);
    }

    public static function getUrlByGroup(param1:int):String {
        var _loc2_:String = "";
        switch (param1) {
            case SWORD:
                _loc2_ = "sword";
                break;
            case HELMET:
                _loc2_ = "helmet";
                break;
            case SHIELD:
                _loc2_ = "shield";
                break;
            case CHEST_ARMOR:
                _loc2_ = "chestArmor";
                break;
            case GLOVES:
                _loc2_ = "gloves";
                break;
            case BOOTS:
                _loc2_ = "boots";
                break;
            case RING:
                _loc2_ = "ring";
        }
        return _loc2_;
    }
}
}
