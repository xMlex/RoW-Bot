package model.data.rewardIcons {
import model.logic.ServerManager;

public class RewardUrl implements IBuiltUrl {

    public static const AWARD_ICONS:String = "ui/awardIcons/";

    public static const BM:String = "blackMarket/";

    public static const LARGE:String = "large/";

    public static const SMALL:String = "small/";

    public static const LITTLE:String = "little/";

    public static const MEDIUM:String = "medium/";

    public static const MINI:String = "mini/";

    public static const SECTOR:String = "sector/";

    public static const TROPHY_ITEM:String = "trophyItem/";

    public static const SIZE_82:String = "82x82/";

    public static const JPEG:String = ".jpg";

    public static const PNG:String = ".png";

    public static const SWF:String = ".swf";


    private var _path:String;

    public function RewardUrl(param1:String) {
        super();
        this._path = param1;
    }

    public function build(param1:String, param2:String):String {
        return ServerManager.buildContentUrl(AWARD_ICONS + param1 + this._path + param2);
    }
}
}
