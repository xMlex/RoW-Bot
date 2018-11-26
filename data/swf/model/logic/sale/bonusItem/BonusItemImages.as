package model.logic.sale.bonusItem {
import model.data.rewardIcons.BMIRewardUrl;
import model.data.rewardIcons.RewardUrl;
import model.data.rewardIcons.SectorSkinRewardUrl;
import model.data.rewardIcons.ThemedEventRewardUrl;
import model.data.rewardIcons.VipPointsUrl;
import model.data.scenes.types.GeoSceneObjectType;
import model.logic.ServerManager;

public class BonusItemImages {


    public function BonusItemImages() {
        super();
    }

    protected function get folder():String {
        return RewardUrl.SMALL;
    }

    protected function get extention():String {
        return RewardUrl.JPEG;
    }

    protected function createImageAddress(param1:String):String {
        return new RewardUrl(param1).build(this.folder, this.extention);
    }

    public function itemImageById(param1:int):String {
        return new BMIRewardUrl(param1).build(this.folder, this.extention);
    }

    public function sectorSkin(param1:int):String {
        return new SectorSkinRewardUrl(param1).build(this.folder, RewardUrl.JPEG);
    }

    public function vipPointsItem(param1:int):String {
        return new VipPointsUrl(param1).build(this.folder, this.extention);
    }

    public function dragonResources(param1:String):String {
        return this.createImageAddress(param1);
    }

    public function nanopods():String {
        return this.createImageAddress("nanopods");
    }

    public function dust():String {
        return this.createImageAddress("dust");
    }

    public function dragonPoints():String {
        return this.createImageAddress("dragonSkillPoints");
    }

    public function experience():String {
        return ServerManager.buildContentUrl("ui/skin_parts/icons/experience.png");
    }

    public function wisdomPoints():String {
        return this.createImageAddress("wisdomPoints");
    }

    public function mobilizer():String {
        return ServerManager.buildContentUrl("ui/skin_parts/icons/experience.png");
    }

    public function money():String {
        return this.createImageAddress("money");
    }

    public function uranium():String {
        return this.createImageAddress("uranium");
    }

    public function titanite():String {
        return this.createImageAddress("titanite");
    }

    public function allianceCash():String {
        return this.createImageAddress("allianceCash");
    }

    public function techPoints():String {
        return this.createImageAddress("techPoints");
    }

    public function biochips():String {
        return this.createImageAddress("biochips");
    }

    public function constructionItems():String {
        return this.createImageAddress("constructionItems");
    }

    public function constructionWorker():String {
        return this.createImageAddress("worker");
    }

    public function constructionPointsItem():String {
        return this.createImageAddress("constructionPoints");
    }

    public function inventoryItem(param1:int):String {
        return "";
    }

    public function blackCrystal():String {
        return this.createImageAddress("black_crystal");
    }

    public function goldMoney():String {
        return "";
    }

    public function unit(param1:GeoSceneObjectType):String {
        if (!param1 || !param1.graphicsInfo) {
            return "";
        }
        return ServerManager.buildContentUrl(this.getUnitUrl(param1.graphicsInfo.url));
    }

    public function getUnitUrl(param1:String):String {
        return param1.replace(".swf", "_ps.jpg");
    }

    public function drawing(param1:GeoSceneObjectType):String {
        var _loc2_:String = "";
        if (param1 != null && param1.drawingInfo != null) {
            _loc2_ = ServerManager.buildContentUrl(this.getDrawUrl(param1.graphicsInfo.url));
        }
        return _loc2_;
    }

    public function getDrawUrl(param1:String):String {
        return param1.replace(".jpg", "_d.jpg");
    }

    public function upgradeLowerLevelTechnologyItem(param1:int):String {
        return this.createImageAddress("upgrade_technology");
    }

    public function upgradeHigherLevelTechnologyItem(param1:int):String {
        return this.createImageAddress("upgrade_technology_higher_level");
    }

    public function character(param1:int):String {
        return this.createImageAddress("hero_" + param1);
    }

    public function themedItems(param1:int):String {
        return new ThemedEventRewardUrl(param1).build(this.folder, this.extention);
    }
}
}
