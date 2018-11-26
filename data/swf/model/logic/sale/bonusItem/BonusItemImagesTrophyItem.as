package model.logic.sale.bonusItem {
import model.data.rewardIcons.RewardUrl;

public class BonusItemImagesTrophyItem extends BonusItemImages {


    public function BonusItemImagesTrophyItem() {
        super();
    }

    override protected function get folder():String {
        return RewardUrl.TROPHY_ITEM;
    }

    override protected function get extention():String {
        return RewardUrl.PNG;
    }
}
}
