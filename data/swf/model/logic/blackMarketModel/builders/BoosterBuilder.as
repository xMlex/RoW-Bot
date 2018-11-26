package model.logic.blackMarketModel.builders {
import common.DateUtil;
import common.GameType;
import common.localization.LocaleUtil;

import model.data.rewardIcons.BMIRewardUrl;
import model.data.rewardIcons.RewardUrl;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.BoosterItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class BoosterBuilder implements IBlackMarketItemBuilder {

    private static const DAYS:String = LocaleUtil.getText("utils-common-dateUtils-day");

    private static const HOURS:String = LocaleUtil.getText("utils-common-dateUtils-hous");

    private static const MINUTES:String = LocaleUtil.getText("utils-common-dateUtils-minute");


    public function BoosterBuilder() {
        super();
    }

    protected static function buildImageUrl(param1:int):String {
        var _loc2_:String = !!GameType.isTotalDomination ? RewardUrl.MEDIUM : RewardUrl.BM;
        var _loc3_:String = GameType.isMilitary || GameType.isNords ? RewardUrl.PNG : RewardUrl.JPEG;
        return new BMIRewardUrl(param1).build(_loc2_, _loc3_);
    }

    protected function formatDate(param1:Number):String {
        var _loc2_:String = null;
        switch (param1) {
            case DateUtil.SECONDS_1_MINUTE:
                _loc2_ = "1 " + MINUTES;
                break;
            case DateUtil.SECONDS_3_MINUTES:
                _loc2_ = "3 " + MINUTES;
                break;
            case DateUtil.SECONDS_5_MINUTES:
                _loc2_ = "5 " + MINUTES;
                break;
            case DateUtil.SECONDS_10_MINUTES:
                _loc2_ = "10 " + MINUTES;
                break;
            case DateUtil.SECONDS_15_MINUTES:
                _loc2_ = "15 " + MINUTES;
                break;
            case DateUtil.SECONDS_30_MINUTES:
                _loc2_ = "30 " + MINUTES;
                break;
            case DateUtil.SECONDS_60_MINUTES:
                _loc2_ = "60 " + MINUTES;
                break;
            case DateUtil.SECONDS_2_HOURS:
                _loc2_ = "2 " + HOURS;
                break;
            case DateUtil.SECONDS_4_HOURS:
                _loc2_ = "4 " + HOURS;
                break;
            case DateUtil.SECONDS_8_HOURS:
                _loc2_ = "8 " + HOURS;
                break;
            case DateUtil.SECONDS_12_HOURS:
                _loc2_ = "12 " + HOURS;
                break;
            case DateUtil.SECONDS_15_HOURS:
                _loc2_ = "15 " + HOURS;
                break;
            case DateUtil.SECONDS_1_DAY:
                _loc2_ = "1 " + DAYS;
                break;
            case DateUtil.SECONDS_2_DAYS:
                _loc2_ = "2 " + DAYS;
                break;
            case DateUtil.SECONDS_4_DAYS:
                _loc2_ = "4 " + DAYS;
                break;
            case DateUtil.SECONDS_5_DAYS:
                _loc2_ = "5 " + DAYS;
                break;
            case DateUtil.SECONDS_7_DAYS:
                _loc2_ = "7 " + DAYS;
                break;
            case DateUtil.SECONDS_10_DAYS:
                _loc2_ = "10 " + DAYS;
                break;
            case DateUtil.SECONDS_14_DAYS:
                _loc2_ = "14 " + DAYS;
                break;
            case DateUtil.SECONDS_30_DAYS:
                _loc2_ = "30" + DAYS;
        }
        return _loc2_;
    }

    protected function fillLocaleData(param1:BoosterItem):void {
        param1.name = LocaleUtil.getText("forms-blackMarketItems_boostHeader");
        param1.fullName = param1.name + " (" + this.formatDate(param1.duration) + ")";
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:BoosterItem = new BoosterItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.iconUrl = buildImageUrl(param1.id);
        _loc2_.duration = param1.boostData.timeSeconds;
        _loc2_.boostRatio = param1.boostData.speedUpCoefficient;
        _loc2_.isForSupportTroops = param1.boostData.applicableForSupportTroops;
        this.fillLocaleData(_loc2_);
        return _loc2_;
    }
}
}
