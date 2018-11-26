package model.logic.sale.bonusItem {
import model.data.rewardIcons.RewardUrl;

public class BonusItemImagesDailyItem extends BonusItemImages {


    public function BonusItemImagesDailyItem() {
        super();
    }

    override protected function get folder():String {
        return RewardUrl.MINI;
    }

    override protected function get extention():String {
        return RewardUrl.PNG;
    }
}
}
