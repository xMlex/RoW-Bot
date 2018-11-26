package model.data.globalEvent {
import common.GameType;

import model.data.scenes.types.info.BlackMarketItemsTypeId;

public class StaticDiscountTypeId {

    public static const BLACK_MARKET:int = 1;

    public static const RESURRECTION:int = 2;

    public static const BOOSTERS:int = 3;

    public static const CHESTS:int = 4;

    public static const CONSTRUCTION_ITEMS:int = 5;

    public static const SECTOR_SKINS:int = 6;

    public static const DECORATIVE_BUILDINGS:int = 7;

    public static const DEFENSIVE_AND_ROBOT_BUILDINGS:int = 8;

    public static const MASSACRE_TOURNAMENT_RESURRECTION:int = 9;

    public static const INSTANT_UPGRADE_BUILDING:int = 10;

    public static const INSTANT_UPGRADE_TECHNOLOGY:int = 11;

    public static const INSTANT_UPGRADE_DRAGON_ABILITY:int = 12;


    public function StaticDiscountTypeId() {
        super();
    }

    public static function fromBlackMarketItemTypeId(param1:Number):int {
        var _loc2_:Number = 0;
        if (param1 >= BlackMarketItemsTypeId.ResourceConstructionItems1 && param1 <= BlackMarketItemsTypeId.ResourceConstructionItems1000) {
            _loc2_ = CONSTRUCTION_ITEMS;
        }
        else if (GameType.isNords && param1 >= BlackMarketItemsTypeId.BuildingUpgrade && param1 <= BlackMarketItemsTypeId.BuildingUpgradeEnd) {
            _loc2_ = CONSTRUCTION_ITEMS;
        }
        return _loc2_;
    }
}
}
