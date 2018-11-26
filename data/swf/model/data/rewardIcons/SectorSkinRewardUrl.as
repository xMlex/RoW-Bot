package model.data.rewardIcons {
public class SectorSkinRewardUrl extends RewardUrl {

    private static const SKIN:String = "skin_";


    public function SectorSkinRewardUrl(param1:int) {
        super(SKIN + param1);
    }
}
}
