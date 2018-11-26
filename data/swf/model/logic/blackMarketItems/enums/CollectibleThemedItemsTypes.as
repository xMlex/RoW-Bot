package model.logic.blackMarketItems.enums {
import model.data.scenes.types.info.BlackMarketItemsTypeId;

public class CollectibleThemedItemsTypes {

    public static const COMMON:int = 1;

    public static const RARE:int = 3;

    public static const EPIC:int = 5;


    public function CollectibleThemedItemsTypes() {
        super();
    }

    public static function bmiIdByType(param1:int):int {
        var _loc2_:int = 0;
        switch (param1) {
            case COMMON:
                _loc2_ = BlackMarketItemsTypeId.ThemedItemCommon;
                break;
            case RARE:
                _loc2_ = BlackMarketItemsTypeId.ThemedItemRare;
                break;
            case EPIC:
                _loc2_ = BlackMarketItemsTypeId.ThemedItemEpic;
        }
        return _loc2_;
    }
}
}
