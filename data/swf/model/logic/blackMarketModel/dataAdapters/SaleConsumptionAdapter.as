package model.logic.blackMarketModel.dataAdapters {
import model.data.Resources;
import model.logic.blackMarketItems.BlackMarketItemRaw;

public class SaleConsumptionAdapter {


    public function SaleConsumptionAdapter() {
        super();
    }

    public static function getDefaultPrice(param1:int):int {
        switch (param1) {
            case 5:
                return 250;
            case 10:
                return 500;
            case 15:
                return 800;
            case 20:
                return 1150;
            case 25:
                return 1550;
            case 30:
                return 2000;
            case 35:
                return 2500;
            case 40:
                return 3000;
            default:
                return 0;
        }
    }

    public function getSaleConsumptionData():Vector.<BlackMarketItemRaw> {
        var _loc3_:BlackMarketItemRaw = null;
        var _loc1_:Vector.<BlackMarketItemRaw> = new Vector.<BlackMarketItemRaw>();
        var _loc2_:int = 0;
        while (_loc2_ < 8) {
            _loc3_ = new BlackMarketItemRaw();
            _loc3_.id = -10000 + _loc2_;
            _loc3_.saleConsumptionBonus = (_loc2_ + 1) * 5;
            _loc3_.price = new Resources(getDefaultPrice(_loc3_.saleConsumptionBonus));
            _loc1_.push(_loc3_);
            _loc2_++;
        }
        return _loc1_;
    }
}
}
