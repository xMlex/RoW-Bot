package model.data.rewardIcons {
import model.data.scenes.types.info.BlackMarketItemsTypeId;

public class BMIRewardUrl extends RewardUrl {

    private static const ITEM:String = "item_";

    private static const CREDITS:String = "money";

    private static const TITAN:String = "titanite";

    private static const URAN:String = "uranium";


    public function BMIRewardUrl(param1:int) {
        super(this.idToName(param1));
    }

    private function idToName(param1:int):String {
        if (BlackMarketItemsTypeId.resourcesPackUran.indexOf(param1) > -1) {
            return URAN;
        }
        if (BlackMarketItemsTypeId.resourcesPackTitan.indexOf(param1) > -1) {
            return TITAN;
        }
        if (BlackMarketItemsTypeId.resourcesPackCredit.indexOf(param1) > -1) {
            return CREDITS;
        }
        return ITEM + param1;
    }
}
}
