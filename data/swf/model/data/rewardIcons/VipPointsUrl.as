package model.data.rewardIcons {
import model.data.scenes.types.info.BlackMarketItemsTypeId;

public class VipPointsUrl extends BMIRewardUrl {


    public function VipPointsUrl(param1:int) {
        super(this.toBMIId(param1));
    }

    private function toBMIId(param1:int):int {
        switch (param1) {
            case 1:
                return BlackMarketItemsTypeId.Vip_Points_1;
            case 5:
                return BlackMarketItemsTypeId.Vip_Points_5;
            case 20:
                return BlackMarketItemsTypeId.Vip_Points_20;
            case 40:
                return BlackMarketItemsTypeId.Vip_Points_40;
            case 75:
                return BlackMarketItemsTypeId.Vip_Points_75;
            case 100:
                return BlackMarketItemsTypeId.Vip_Points_100;
            case 150:
                return BlackMarketItemsTypeId.Vip_Points_150;
            case 600:
                return BlackMarketItemsTypeId.Vip_Points_600;
            default:
                return BlackMarketItemsTypeId.Vip_Points_1;
        }
    }
}
}
