package model.logic.blackMarketModel.builders.util {
import common.GameType;

import model.data.rewardIcons.BMIRewardUrl;
import model.data.rewardIcons.RewardUrl;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.ItemTypeResolver;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.enums.BlackMarketItemType;

public class BuilderHelper {

    private static var _resolver:ItemTypeResolver = new ItemTypeResolver();


    public function BuilderHelper() {
        super();
    }

    public static function fill(param1:BlackMarketItemBase, param2:BlackMarketItemRaw):void {
        param1.raw = param2;
        param1.itemType = _resolver.resolve(param2);
        param1.id = param2.id;
        param1.name = param2.name;
        param1.price = param2.price;
        param1.iconUrl = param2.iconUrl;
        param1.abTestData = param2.abTestData;
        param1.newUntil = param2.newUntil;
        param1.buyInBank = param2.buyInBank;
        param1.saleProhibited = param2.saleProhibited;
        param1.iconUrl = buildImageUrl(param2.id);
        param1.isPromoPackMerchandise = isPromoPackMerchandise(param1.itemType);
    }

    public static function buildImageUrl(param1:int):String {
        var _loc2_:String = !!GameType.isTotalDomination ? RewardUrl.MEDIUM : RewardUrl.BM;
        var _loc3_:String = GameType.isMilitary || GameType.isNords ? RewardUrl.PNG : RewardUrl.JPEG;
        return new BMIRewardUrl(param1).build(_loc2_, _loc3_);
    }

    public static function buildImageUrlBlackCrystal(param1:int):String {
        var _loc2_:String = GameType.isTotalDomination || GameType.isElves || GameType.isPirates ? RewardUrl.JPEG : RewardUrl.PNG;
        var _loc3_:String = !!GameType.isTotalDomination ? RewardUrl.MEDIUM : RewardUrl.BM;
        return new BMIRewardUrl(param1).build(_loc3_, _loc2_);
    }

    private static function isPromoPackMerchandise(param1:int):Boolean {
        return param1 == BlackMarketItemType.UNLIMITED_SECTOR_TELEPORT || param1 == BlackMarketItemType.TROOPS_SPEED_BOOST;
    }
}
}
