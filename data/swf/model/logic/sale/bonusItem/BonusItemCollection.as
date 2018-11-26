package model.logic.sale.bonusItem {
import Utils.Guard;

import common.ArrayCustom;
import common.DateUtil;
import common.StringUtil;

import configs.Global;

import flash.utils.Dictionary;

import model.data.Resources;
import model.data.SectorSkinType;
import model.data.UserPrize;
import model.data.effects.EffectTypeId;
import model.data.locations.allianceCity.flags.AllianceTacticsBonuses;
import model.data.ratings.UserPrizeOrder;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.data.temporarySkins.TemporarySkin;
import model.data.users.drawings.DrawingPart;
import model.data.users.troops.Troops;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketChestData;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketItems.EffectInfo;
import model.logic.blackMarketItems.ResourceConsumptionData;
import model.logic.blackMarketItems.enums.BlackMarketPackType;
import model.logic.quests.data.InventoryItemQuestBonus;
import model.logic.quests.data.QuestState;
import model.logic.sale.BonusItem;
import model.logic.sale.bonusItem.blocks.ActionFillingBlock;
import model.logic.sale.bonusItem.blocks.ChestFillingBlock;
import model.logic.sale.bonusItem.blocks.CountFillingBlock;
import model.logic.sale.bonusItem.blocks.DescriptionFillingBlock;
import model.logic.sale.bonusItem.blocks.DurationFillingBlock;
import model.logic.sale.bonusItem.blocks.FullNameFillingBlock;
import model.logic.sale.bonusItem.blocks.GemRemovalFillingBlock;
import model.logic.sale.bonusItem.blocks.ImageFillingBlock;
import model.logic.sale.bonusItem.blocks.InventoryKeyFillingBlock;
import model.logic.sale.bonusItem.blocks.PercentFillingBlock;
import model.logic.sale.bonusItem.blocks.ResourcesCountFillingBlock;
import model.logic.sale.bonusItem.blocks.TempSkinFillingBlock;
import model.logic.sale.bonusItem.blocks.ThemedEventItemFillingBlock;
import model.logic.sale.bonusItem.blocks.TitleFillingBlock;
import model.logic.sale.bonusItem.blocks.UnitFillingBlock;
import model.logic.sale.bonusItem.blocks.VipPointsFillingBlock;
import model.logic.tournament.IActionInvoker;
import model.modules.allianceCity.data.resourceHistory.AllianceResources;
import model.modules.dragonAbilities.data.resources.DragonResources;

public class BonusItemCollection {


    private var _imageCreator:BonusItemImages;

    private var _fullNameCreator:BonusItemFullNames;

    private var _titleCreator:BonusItemTitles;

    private var _descriptionCreator:BonusItemDescriptions;

    private var _actionBehaviourCreator:IBonusItemActionBehaviour;

    public function BonusItemCollection() {
        super();
    }

    public function setImageCreator(param1:BonusItemImages):BonusItemCollection {
        this._imageCreator = param1;
        return this;
    }

    public function setFullNameCreator(param1:BonusItemFullNames):BonusItemCollection {
        this._fullNameCreator = param1;
        return this;
    }

    public function setTitleCreator(param1:BonusItemTitles):BonusItemCollection {
        this._titleCreator = param1;
        return this;
    }

    public function setDescriptionCreator(param1:BonusItemDescriptions):BonusItemCollection {
        this._descriptionCreator = param1;
        return this;
    }

    public function setActionBehaviourCreator(param1:IBonusItemActionBehaviour):BonusItemCollection {
        this._actionBehaviourCreator = param1;
        return this;
    }

    public function createBonusesArray(param1:UserPrize, param2:Boolean = true):ArrayCustom {
        if (param1 == null) {
            return new ArrayCustom();
        }
        var _loc3_:ArrayCustom = new ArrayCustom();
        var _loc4_:UserPrizeOrder = param1.order;
        if (param1.sectorSkins && param1.sectorSkins.length > 0) {
            this.addBonusItemSectorSkins(_loc3_, param1.sectorSkins);
        }
        var _loc5_:Array = param1.getAllTemporarySkins != null ? param1.getAllTemporarySkins() : null;
        if (_loc5_ != null) {
            this.addBonusItemTemporarySkin(_loc3_, _loc5_);
        }
        if (param1.resources != null) {
            if (param1.resources.goldMoney > 0 && param2) {
                this.addBonusItemGoldMoney(_loc3_, param1.resources.goldMoney, _loc4_);
            }
            if (param1.resources.blackCrystals > 0) {
                this.addBonusItemBlackCrystal(_loc3_, param1.resources.blackCrystals, _loc4_);
            }
            this.addBonusItemsResources(_loc3_, param1.resources, _loc4_);
        }
        if (param1.constructionWorkers > 0) {
            this.addBonusItemConstructionWorker(_loc3_, param1.constructionWorkers, _loc4_);
        }
        if (param1.vipPoints > 0) {
            this.addItemVipPoints(_loc3_, param1.vipPoints, _loc4_);
        }
        if (param1.blackMarketItems != null) {
            this.addBonusItemBlackMarketItems(_loc3_, param1.blackMarketItems, _loc4_);
        }
        if (param1.troops != null) {
            this.addBonusItemsTroops(_loc3_, param1.troops, _loc4_);
        }
        if (param1.drawingPart != null) {
            this.addBonusItemDrawingPart(_loc3_, param1.drawingPart, _loc4_);
        }
        if (param1.inventoryItems != null) {
            this.addBonusItemInventoryItems(_loc3_, param1.inventoryItems, _loc4_);
        }
        if (param1.skillPoints > 0) {
            this.addBonusItemSkillPoints(_loc3_, param1.skillPoints, _loc4_);
        }
        if (param1.experience > 0) {
            this.addBonusItemExperience(_loc3_, param1.experience, _loc4_);
        }
        if (param1.dust > 0) {
            this.addBonusDust(_loc3_, param1.dust, _loc4_);
        }
        if (param1.dragonPoints > 0) {
            this.addDragonPoints(_loc3_, param1.dragonPoints, _loc4_);
        }
        if (Global.WISDOM_SKILLS_ENABLED && param1.wisdomPoints > 0) {
            this.addWisdomSkillPoints(_loc3_, param1.wisdomPoints, _loc4_);
        }
        if (param1.allianceResources != null) {
            this.addBonusItemAllianceResources(_loc3_, AllianceResources(param1.allianceResources));
        }
        if (param1 && param1.tacticsBonuses != null) {
            this.addBonusItemTacticsBonuses(_loc3_, AllianceTacticsBonuses(param1.tacticsBonuses));
        }
        if (param1.artifactTypeIds != null) {
            this.addBonusItemArtifacts(_loc3_, param1.artifactTypeIds);
        }
        if (param1.dragonResources != null) {
            this.addBonusItemDragonResources(_loc3_, param1.dragonResources, _loc4_);
        }
        if (param1.mobilizers > 0) {
            this.addBonusItemMobilizer(_loc3_, param1.mobilizers);
        }
        if (param1 && param1.characters != null) {
            this.addCharacters(_loc3_, param1.characters);
        }
        _loc3_.sortOn(["primarySortPosition", "secondarySortPosition"], [Array.NUMERIC, Array.NUMERIC]);
        return _loc3_;
    }

    private function addBonusItemSectorSkins(param1:ArrayCustom, param2:ArrayCustom):void {
        var _loc3_:BonusItem = null;
        var _loc4_:int = 0;
        for each(_loc4_ in param2) {
            _loc3_ = this.createBonusItem(BonusItemOrderId.SECTOR_SKIN).addProperty(new ImageFillingBlock(this._imageCreator.sectorSkin(_loc4_))).addProperty(new CountFillingBlock(1)).addProperty(new FullNameFillingBlock(this._fullNameCreator.sectorSkin(_loc4_))).addProperty(new TitleFillingBlock(this._titleCreator.sectorSkin(_loc4_)));
            param1.addItem(_loc3_);
        }
    }

    private function addBonusItemTemporarySkin(param1:ArrayCustom, param2:Array):void {
        var _loc4_:SectorSkinType = null;
        var _loc5_:BonusItem = null;
        var _loc6_:TemporarySkin = null;
        var _loc7_:TemporarySkin = null;
        var _loc8_:IActionInvoker = null;
        var _loc3_:Object = {};
        for each(_loc6_ in param2) {
            if (_loc3_[_loc6_.skinTemplateId] == null) {
                _loc3_[_loc6_.skinTemplateId] = 0;
            }
            _loc3_[_loc6_.skinTemplateId]++;
        }
        for each(_loc7_ in param2) {
            _loc4_ = StaticDataManager.getSectorSkinType(_loc7_.skinTypeId);
            if (_loc4_ == null) {
                _loc3_[_loc7_.skinTemplateId]--;
            }
            else if (_loc3_[_loc7_.skinTemplateId] > 0) {
                _loc8_ = this._actionBehaviourCreator == null ? null : this._actionBehaviourCreator.tempSkinActionBehaviour(_loc7_);
                _loc5_ = this.createBonusItem(BonusItemOrderId.TEMPORARY_SKIN).addProperty(new ImageFillingBlock(this._imageCreator.sectorSkin(_loc7_.skinTypeId))).addProperty(new CountFillingBlock(_loc3_[_loc7_.skinTemplateId])).addProperty(new FullNameFillingBlock(this._fullNameCreator.sectorSkin(_loc7_.skinTypeId))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.sectorSkin(_loc7_.skinEffectInfo))).addProperty(new TitleFillingBlock(this._titleCreator.sectorSkin(_loc7_.skinTypeId))).addProperty(new ActionFillingBlock(_loc8_)).addProperty(new TempSkinFillingBlock(_loc7_));
                param1.addItem(_loc5_);
            }
        }
    }

    private function addBonusItemGoldMoney(param1:ArrayCustom, param2:int, param3:UserPrizeOrder):void {
        var _loc4_:int = param3 == null ? int(BonusItemOrderId.GOLD_MONEY) : int(param3.resourcesGoldOrder);
        var _loc5_:BonusItem = this.createBonusItem(_loc4_).addProperty(new ImageFillingBlock(this._imageCreator.goldMoney())).addProperty(new CountFillingBlock(param2)).addProperty(new FullNameFillingBlock(this._fullNameCreator.goldMoney())).addProperty(new TitleFillingBlock(this._titleCreator.goldMoney()));
        param1.addItem(_loc5_);
    }

    private function addBonusItemBlackCrystal(param1:ArrayCustom, param2:int, param3:UserPrizeOrder):void {
        var _loc4_:int = param3 == null ? int(BonusItemOrderId.BLACK_CRYSTAL) : int(param3.resourcesBlackCrystalOrder);
        var _loc5_:BonusItem = this.createBonusItem(_loc4_).addProperty(new ImageFillingBlock(this._imageCreator.blackCrystal())).addProperty(new CountFillingBlock(param2)).addProperty(new FullNameFillingBlock(this._fullNameCreator.blackCrystal())).addProperty(new DescriptionFillingBlock(this._descriptionCreator.blackCrystal())).addProperty(new TitleFillingBlock(this._titleCreator.blackCrystal()));
        param1.addItem(_loc5_);
    }

    private function addBonusItemConstructionWorker(param1:ArrayCustom, param2:int, param3:UserPrizeOrder):void {
        var _loc4_:int = param3 == null ? int(BonusItemOrderId.CONSTRUCTION_WORKER) : int(param3.constructionWorkersOrder);
        var _loc5_:BonusItem = this.createBonusItem(_loc4_).addProperty(new ImageFillingBlock(this._imageCreator.constructionWorker())).addProperty(new CountFillingBlock(param2)).addProperty(new FullNameFillingBlock(this._fullNameCreator.constructionWorker())).addProperty(new DescriptionFillingBlock(this._descriptionCreator.constructionWorker())).addProperty(new TitleFillingBlock(this._titleCreator.constructionWorker()));
        param1.addItem(_loc5_);
    }

    private function addItemVipPoints(param1:ArrayCustom, param2:int, param3:UserPrizeOrder):void {
        var _loc4_:int = param3 == null ? int(BonusItemOrderId.VIP_POINTS_PASSE) : int(param3.vipPointsOrder);
        var _loc5_:BonusItem = this.createBonusItem(_loc4_).addProperty(new ImageFillingBlock(this._imageCreator.vipPointsItem(param2))).addProperty(new CountFillingBlock(param2)).addProperty(new FullNameFillingBlock(this._fullNameCreator.vipPointsPasse())).addProperty(new TitleFillingBlock(this._titleCreator.vipPointsPasse()));
        param1.addItem(_loc5_);
    }

    private function addBonusItemBlackMarketItems(param1:ArrayCustom, param2:Dictionary, param3:UserPrizeOrder):void {
        var _loc4_:Object = null;
        var _loc5_:* = undefined;
        if (param3 != null) {
            _loc4_ = param3.blackMarketItemsOrder;
        }
        for (_loc5_ in param2) {
            if (StaticDataManager.blackMarketData.itemsById[_loc5_] != null) {
                this.createBlackMarketItem(param1, _loc5_, param2[_loc5_], _loc4_);
            }
        }
    }

    private function createBlackMarketItem(param1:ArrayCustom, param2:int, param3:int, param4:Object):void {
        var _loc6_:Number = NaN;
        var _loc7_:int = 0;
        var _loc8_:BonusItem = null;
        var _loc9_:BlackMarketChestData = null;
        var _loc10_:Number = NaN;
        var _loc11_:int = 0;
        var _loc12_:Resources = null;
        var _loc13_:int = 0;
        var _loc14_:Boolean = false;
        var _loc15_:int = 0;
        var _loc16_:int = 0;
        var _loc17_:ResourceConsumptionData = null;
        var _loc18_:int = 0;
        var _loc19_:EffectInfo = null;
        var _loc20_:Number = NaN;
        var _loc21_:QuestState = null;
        var _loc22_:int = 0;
        var _loc5_:BlackMarketItemRaw = StaticDataManager.blackMarketData.itemsById[BlackMarketItemsTypeId.convertOldIdToNew(param2)];
        Guard.againstNull(_loc5_);
        if (_loc5_ == null) {
            return;
        }
        if (_loc5_.chestData != null) {
            _loc9_ = _loc5_.chestData;
            _loc7_ = param4 == null ? int(BonusItemOrderId.CHESTS) : int(param4[param2]);
            _loc8_ = this.createBonusItem(_loc7_, _loc9_.gemLevelFrom + _loc9_.gemLevelTo).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.gemChestItem(_loc5_, param3))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.gemChestItem())).addProperty(new TitleFillingBlock(this._titleCreator.gemChestItem())).addProperty(new ChestFillingBlock(_loc5_.chestData, param3));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.gemRemovalData != null) {
            _loc7_ = param4 == null ? int(BonusItemOrderId.GEM_REMOVAL) : int(param4[param2]);
            _loc8_ = this.createBonusItem(_loc7_, _loc5_.gemRemovalData.gemLevelTo).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.gemRemovalItem(_loc5_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.gemRemovalItem())).addProperty(new TitleFillingBlock(this._titleCreator.gemRemovalItem(_loc5_))).addProperty(new GemRemovalFillingBlock(_loc5_.gemRemovalData));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.boostData != null && _loc5_.boostData.speedUpCoefficient == 0) {
            _loc7_ = param4 == null ? int(BonusItemOrderId.BOOSTS) : int(param4[param2]);
            _loc6_ = _loc5_.boostData.timeSeconds;
            _loc8_ = this.createBonusItem(_loc7_, _loc6_).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.boostItem(_loc6_, param3))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.boostItem())).addProperty(new DurationFillingBlock(_loc6_)).addProperty(new TitleFillingBlock(this._titleCreator.boostItem()));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.boostData != null && _loc5_.boostData.speedUpCoefficient > 0) {
            _loc10_ = _loc5_.boostData.speedUpCoefficient;
            _loc7_ = param4 == null ? int(BonusItemOrderId.TELEPORT) : int(param4[param2]);
            _loc8_ = this.createBonusItem(_loc7_).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.teleportatorItem(_loc10_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.teleportatorItem())).addProperty(new TitleFillingBlock(this._titleCreator.teleportatorItem(_loc5_))).addProperty(new PercentFillingBlock(-(1 - _loc10_) * 100));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.vipActivatorData != null) {
            _loc6_ = _loc5_.vipActivatorData.durationSeconds;
            _loc7_ = param4 == null ? int(BonusItemOrderId.VIP_ACTIVATOR) : int(param4[param2]);
            _loc8_ = this.createBonusItem(_loc7_, _loc6_).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.vipActivatorItem(_loc6_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.vipActivatorItem())).addProperty(new TitleFillingBlock(this._titleCreator.vipActivatorItem())).addProperty(new DurationFillingBlock(_loc6_));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.vipPointsData != null) {
            _loc11_ = _loc5_.vipPointsData.points;
            _loc7_ = param4 == null ? int(BonusItemOrderId.VIP_POINTS) : int(param4[param2]);
            _loc8_ = this.createBonusItem(_loc7_, _loc11_).addProperty(new ImageFillingBlock(this._imageCreator.vipPointsItem(_loc11_))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.vipPointsItem(_loc11_, param3))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.vipPointsItem())).addProperty(new TitleFillingBlock(this._titleCreator.vipPointsItem())).addProperty(new VipPointsFillingBlock(_loc11_));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.resourcesData != null && _loc5_.resourcesData.resources != null && _loc5_.resourcesData.resources.money > 0) {
            _loc7_ = param4 == null ? int(BonusItemOrderId.RESOURCES_MONEY) : int(param4[param2]);
            _loc8_ = this.createBonusItem(_loc7_).addProperty(new ImageFillingBlock(this._imageCreator.money())).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.money())).addProperty(new ResourcesCountFillingBlock(_loc5_.resourcesData.resources.money)).addProperty(new DescriptionFillingBlock(this._descriptionCreator.resources())).addProperty(new TitleFillingBlock(this._titleCreator.money()));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.resourcesData != null && _loc5_.resourcesData.resources != null && _loc5_.resourcesData.resources.uranium > 0) {
            _loc7_ = param4 == null ? int(BonusItemOrderId.RESOURCES_URANIUM) : int(param4[param2]);
            _loc8_ = this.createBonusItem(_loc7_).addProperty(new ImageFillingBlock(this._imageCreator.uranium())).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.uranium())).addProperty(new ResourcesCountFillingBlock(_loc5_.resourcesData.resources.uranium)).addProperty(new DescriptionFillingBlock(this._descriptionCreator.resources())).addProperty(new TitleFillingBlock(this._titleCreator.uranium()));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.resourcesData != null && _loc5_.resourcesData.resources != null && _loc5_.resourcesData.resources.titanite > 0) {
            _loc7_ = param4 == null ? int(BonusItemOrderId.RESOURCES_TITANITE) : int(param4[param2]);
            _loc8_ = this.createBonusItem(_loc7_).addProperty(new ImageFillingBlock(this._imageCreator.titanite())).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.titanite())).addProperty(new ResourcesCountFillingBlock(_loc5_.resourcesData.resources.titanite)).addProperty(new DescriptionFillingBlock(this._descriptionCreator.resources())).addProperty(new TitleFillingBlock(this._titleCreator.titanite()));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.resourcesData != null && _loc5_.resourcesData.resources != null && _loc5_.resourcesData.resources.biochips > 0) {
            _loc7_ = param4 == null ? int(BonusItemOrderId.RESOURCES_BIOCHIPS) : int(param4[param2]);
            _loc8_ = this.createBonusItem(_loc7_).addProperty(new ImageFillingBlock(this._imageCreator.biochips())).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.biochip())).addProperty(new ResourcesCountFillingBlock(_loc5_.resourcesData.resources.biochips)).addProperty(new DescriptionFillingBlock(this._descriptionCreator.resources())).addProperty(new TitleFillingBlock(this._titleCreator.biochip()));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.resourcesData != null && _loc5_.resourcesData.resources != null && _loc5_.resourcesData.resources.constructionItems > 0) {
            _loc7_ = param4 == null ? int(BonusItemOrderId.RESOURCES_CONSTRUCTION_ITEMS) : int(param4[param2]);
            _loc8_ = this.createBonusItem(_loc7_).addProperty(new ImageFillingBlock(this._imageCreator.constructionItems())).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.constructionItems())).addProperty(new ResourcesCountFillingBlock(_loc5_.resourcesData.resources.constructionItems)).addProperty(new DescriptionFillingBlock(this._descriptionCreator.constructionItems())).addProperty(new TitleFillingBlock(this._titleCreator.constructionItems()));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.resourcesBoostData != null && _loc5_.resourcesBoostData.resources != null) {
            _loc12_ = _loc5_.resourcesBoostData.resources;
            _loc6_ = _loc5_.resourcesBoostData.durationSeconds;
            _loc13_ = _loc6_ / 60 / 60 / 24;
            _loc7_ = param4 == null ? int(BonusItemOrderId.BOOSTS) : int(param4[param2]);
            if (_loc12_.money > 0 && _loc12_.uranium == 0 && _loc12_.titanite == 0) {
                _loc8_ = this.createBonusItem(_loc7_).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.moneyBoost(_loc12_.money, _loc13_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.resourceBoost())).addProperty(new TitleFillingBlock(this._titleCreator.resourcesBoost())).addProperty(new DurationFillingBlock(_loc6_)).addProperty(new PercentFillingBlock(_loc12_.money));
                param1.addItem(_loc8_);
            }
            if (_loc12_.uranium > 0 && _loc12_.money == 0 && _loc12_.titanite == 0) {
                _loc8_ = this.createBonusItem(_loc7_).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.uraniumBoost(_loc12_.uranium, _loc13_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.resourceBoost())).addProperty(new TitleFillingBlock(this._titleCreator.resourcesBoost())).addProperty(new DurationFillingBlock(_loc6_)).addProperty(new PercentFillingBlock(_loc12_.uranium));
                param1.addItem(_loc8_);
            }
            if (_loc12_.titanite > 0 && _loc12_.uranium == 0 && _loc12_.money == 0) {
                _loc8_ = this.createBonusItem(_loc7_).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.titaniumBoost(_loc12_.titanite, _loc13_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.resourceBoost())).addProperty(new TitleFillingBlock(this._titleCreator.resourcesBoost())).addProperty(new DurationFillingBlock(_loc6_)).addProperty(new PercentFillingBlock(_loc12_.titanite));
                param1.addItem(_loc8_);
            }
            if (_loc12_.titanite == ResourceConsumptionData.RESOURCES_25 && _loc12_.uranium == ResourceConsumptionData.RESOURCES_25 && _loc12_.money == ResourceConsumptionData.RESOURCES_25 && _loc6_ == DateUtil.SECONDS_3_DAYS) {
                _loc8_ = this.createBonusItem(_loc7_).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.allResourcesBoost(_loc12_.titanite, _loc13_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.resourceBoost())).addProperty(new TitleFillingBlock(this._titleCreator.resourcesBoost())).addProperty(new DurationFillingBlock(_loc6_)).addProperty(new PercentFillingBlock(_loc12_.titanite));
                param1.addItem(_loc8_);
            }
            if (_loc12_.titanite == ResourceConsumptionData.RESOURCES_25 && _loc12_.uranium == ResourceConsumptionData.RESOURCES_25 && _loc12_.money == ResourceConsumptionData.RESOURCES_25 && _loc6_ == DateUtil.SECONDS_1_DAY) {
                _loc8_ = this.createBonusItem(_loc7_).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.allResourcesBoost(_loc12_.titanite, _loc13_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.allResourcesBoost())).addProperty(new TitleFillingBlock(this._titleCreator.resourcesBoost())).addProperty(new DurationFillingBlock(_loc6_)).addProperty(new PercentFillingBlock(_loc12_.titanite));
                param1.addItem(_loc8_);
            }
        }
        else if (_loc5_.discardSkillsData != null) {
            _loc7_ = param4 == null ? int(BonusItemOrderId.DISCARD_SKILL_POINTS) : int(param4[param2]);
            _loc8_ = this.createBonusItem(_loc7_).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.discardSkillsItem())).addProperty(new DescriptionFillingBlock(this._descriptionCreator.discardSkillsItem())).addProperty(new TitleFillingBlock(this._titleCreator.discardSkillsItem(_loc5_)));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.sectorTeleportData != null) {
            _loc14_ = _loc5_.sectorTeleportData.random;
            _loc7_ = param4 == null ? int(BonusItemOrderId.SELECTOR_TELEPORT) : int(param4[param2]);
            _loc8_ = this.createBonusItem(_loc7_).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.sectorTeleportItem(_loc14_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.sectorTeleportItem(_loc14_))).addProperty(new TitleFillingBlock(this._titleCreator.sectorTeleportItem(_loc5_)));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.updateSectorData != null) {
            _loc15_ = _loc5_.updateSectorData.updateSectorType;
            _loc7_ = param4 == null ? int(BonusItemOrderId.PACK) : int(param4[param2]);
            _loc8_ = this.createBonusItem(_loc7_).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.updateSectorItem(_loc15_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.updateSectorItem(_loc15_))).addProperty(new TitleFillingBlock(this._titleCreator.updateSectorItem(_loc5_)));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.packData != null) {
            _loc16_ = _loc5_.packData.packType;
            _loc7_ = param4 == null ? int(BonusItemOrderId.PACK) : int(param4[param2]);
            if (_loc16_ == BlackMarketPackType.UPGRADE_BUILDING) {
                _loc8_ = this.createBonusItem(_loc7_).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.upgradeBuildingsItem())).addProperty(new DescriptionFillingBlock(this._descriptionCreator.upgradeBuildingItem())).addProperty(new TitleFillingBlock(this._titleCreator.upgradeBuildingsItem(_loc5_)));
                param1.addItem(_loc8_);
            }
            else if (_loc16_ == BlackMarketPackType.UPGRADE_TECHNOLOGY_01) {
                _loc8_ = this.createBonusItem(_loc7_).addProperty(new ImageFillingBlock(this._imageCreator.upgradeLowerLevelTechnologyItem(_loc5_.packData.itemCount))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.upgradeLowerLevelTechnologyItem())).addProperty(new DescriptionFillingBlock(this._descriptionCreator.upgradeLowerLevelTechnologyItem())).addProperty(new TitleFillingBlock(this._titleCreator.upgradeLowerLevelTechnologyItem(_loc5_)));
                param1.addItem(_loc8_);
            }
            else {
                _loc8_ = this.createBonusItem(_loc7_).addProperty(new ImageFillingBlock(this._imageCreator.upgradeHigherLevelTechnologyItem(_loc5_.packData.itemCount))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.upgradeHigherLevelTechnologyItem())).addProperty(new TitleFillingBlock(this._titleCreator.upgradeHigherLevelTechnologyItem(_loc5_)));
                param1.addItem(_loc8_);
            }
        }
        else if (_loc5_.inventoryKeyData != null) {
            _loc8_ = this.createBonusItem(BonusItemOrderId.INVENTORY_KEY).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.inventoryKeyItem(_loc5_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.inventoryKeyItem(_loc5_))).addProperty(new TitleFillingBlock(this._titleCreator.inventoryKeyItem(_loc5_.id))).addProperty(new InventoryKeyFillingBlock(_loc5_));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.staticBonusPackData != null) {
            _loc8_ = this.createBonusItem(BonusItemOrderId.PACK).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.staticBonusPackItem())).addProperty(new TitleFillingBlock(this._titleCreator.staticBonusPackItem(_loc5_)));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.resourceConsumptionData != null) {
            _loc17_ = _loc5_.resourceConsumptionData;
            _loc18_ = _loc17_.resources.money;
            _loc6_ = _loc17_.durationSeconds;
            _loc8_ = this.createBonusItem(BonusItemOrderId.PACK).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.boostMoneyConsumptionItem(_loc18_, _loc6_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.boostMoneyConsumptionItem())).addProperty(new TitleFillingBlock(this._titleCreator.boostMoneyConsumptionItem())).addProperty(new DurationFillingBlock(_loc6_)).addProperty(new PercentFillingBlock(-_loc18_));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.cancelUnitData != null) {
            _loc8_ = this.createBonusItem(BonusItemOrderId.OTHER_BLACK_MARKET_ITEMS).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.cancelUnitItem())).addProperty(new DescriptionFillingBlock(this._descriptionCreator.cancelUnitItem())).addProperty(new TitleFillingBlock(this._titleCreator.cancelUnitItem(_loc5_)));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.resetDailyData != null) {
            _loc8_ = this.createBonusItem(BonusItemOrderId.OTHER_BLACK_MARKET_ITEMS).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.resetDailyItem(_loc5_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.resetDailyItem(_loc5_.resetDailyData.dailyQuestKind))).addProperty(new TitleFillingBlock(this._titleCreator.resetDailyItem()));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.additionalRaidLocationsData != null) {
            _loc8_ = this.createBonusItem(BonusItemOrderId.OTHER_BLACK_MARKET_ITEMS).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.additionalRaidLocationItem())).addProperty(new DescriptionFillingBlock(this._descriptionCreator.additionalRaidLocationItem())).addProperty(new TitleFillingBlock(this._titleCreator.additionalRaidLocationItem(_loc5_)));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.effectData != null) {
            _loc19_ = _loc5_.effectData;
            _loc20_ = _loc19_.power;
            _loc6_ = _loc19_.timeSeconds;
            switch (_loc19_.effectTypeId) {
                case EffectTypeId.UserAutoMoveTroopsBunker:
                    _loc8_ = this.createBonusItem(BonusItemOrderId.EFFECT_ITEM, 1).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.effectItem(_loc5_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.autoMoveTroopsBunkerEffectItem())).addProperty(new TitleFillingBlock(this._titleCreator.autoMoveTroopsBunkerEffectItem())).addProperty(new DurationFillingBlock(_loc6_));
                    break;
                case EffectTypeId.UserAttackPower:
                    _loc8_ = this.createBonusItem(BonusItemOrderId.EFFECT_ITEM, 2).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.effectItem(_loc5_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.attackPowerEffectItem())).addProperty(new TitleFillingBlock(this._titleCreator.attackPowerEffectItem())).addProperty(new PercentFillingBlock(_loc20_)).addProperty(new DurationFillingBlock(_loc6_));
                    break;
                case EffectTypeId.UserDefensePower:
                    _loc8_ = this.createBonusItem(BonusItemOrderId.EFFECT_ITEM, 3).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.effectItem(_loc5_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.defencePowerEffectItem())).addProperty(new TitleFillingBlock(this._titleCreator.defensePowerEffectItem())).addProperty(new PercentFillingBlock(_loc20_)).addProperty(new DurationFillingBlock(_loc6_));
                    break;
                case EffectTypeId.UserAttackAndDefensePowerBonus:
                    _loc8_ = this.createBonusItem(BonusItemOrderId.EFFECT_ITEM, 4).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.effectItem(_loc5_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.attackAndDefencePowerEffectItem())).addProperty(new TitleFillingBlock(this._titleCreator.attackAndDefensePowerEffectItem())).addProperty(new PercentFillingBlock(_loc20_)).addProperty(new DurationFillingBlock(_loc6_));
                    break;
                case EffectTypeId.UserFullProtection:
                    _loc8_ = this.createBonusItem(BonusItemOrderId.EFFECT_ITEM, 5).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.effectItem(_loc5_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.fullProtectionEffectItem())).addProperty(new TitleFillingBlock(this._titleCreator.fullProtectionEffectItem())).addProperty(new DurationFillingBlock(_loc6_));
                    break;
                case EffectTypeId.UserProtectionIntelligence:
                    _loc8_ = this.createBonusItem(BonusItemOrderId.EFFECT_ITEM, 6).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.effectItem(_loc5_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.protectionIntelligenceEffectItem())).addProperty(new TitleFillingBlock(this._titleCreator.protectionIntelligenceEffectItem())).addProperty(new DurationFillingBlock(_loc6_));
                    break;
                case EffectTypeId.UserFakeArmy:
                    _loc8_ = this.createBonusItem(BonusItemOrderId.EFFECT_ITEM, 7).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.effectItem(_loc5_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.fakeArmyEffectItem())).addProperty(new TitleFillingBlock(this._titleCreator.fakeArmyEffectItem())).addProperty(new DurationFillingBlock(_loc6_));
                    break;
                case EffectTypeId.UserBonusBattleExperience:
                    _loc8_ = this.createBonusItem(BonusItemOrderId.EFFECT_ITEM, 8).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.effectItem(_loc5_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.bonusBattleExperienceEffectItem())).addProperty(new TitleFillingBlock(this._titleCreator.bonusBattleExperienceEffectItem())).addProperty(new PercentFillingBlock(_loc20_)).addProperty(new DurationFillingBlock(_loc6_));
                    break;
                case EffectTypeId.SectorDefensePowerBonus:
                    _loc8_ = this.createBonusItem(BonusItemOrderId.EFFECT_ITEM, 9).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.effectItem(_loc5_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.sectorDefencePowerEffectItem())).addProperty(new TitleFillingBlock(this._titleCreator.sectorDefensePowerBonusEffectItem())).addProperty(new PercentFillingBlock(_loc20_)).addProperty(new DurationFillingBlock(_loc6_));
                    break;
                case EffectTypeId.DynamicMinesBonusMiningSpeed:
                    _loc8_ = this.createBonusItem(BonusItemOrderId.EFFECT_ITEM, 10).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.effectItem(_loc5_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.dynamicMinesBonusMiningEffectItem())).addProperty(new TitleFillingBlock(this._titleCreator.dynamicMinesBonusMiningSpeedEffectItem())).addProperty(new PercentFillingBlock(_loc20_)).addProperty(new DurationFillingBlock(_loc6_));
                    break;
                case EffectTypeId.UnlimitedSectorTeleport:
                    _loc8_ = this.createBonusItem(BonusItemOrderId.EFFECT_ITEM, 11).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.effectItem(_loc5_))).addProperty(new TitleFillingBlock(this._titleCreator.effectItem(_loc5_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.unlimitedTeleportEffectItem())).addProperty(new DurationFillingBlock(_loc6_));
                    break;
                case EffectTypeId.TroopsSpeedBoost:
                    _loc8_ = this.createBonusItem(BonusItemOrderId.EFFECT_ITEM, 12).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.effectItem(_loc5_))).addProperty(new TitleFillingBlock(this._titleCreator.effectItem(_loc5_))).addProperty(new DescriptionFillingBlock(this._descriptionCreator.troopsSpeedBoostEffectItem()));
                    break;
                case EffectTypeId.TroopsTierBattleExperienceInfantry:
                    _loc8_ = this.createBonusItem(BonusItemOrderId.EFFECT_ITEM, 13).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.effectItem(_loc5_))).addProperty(new TitleFillingBlock(this._titleCreator.tierBattleExperienceInfantryEffectItem())).addProperty(new DescriptionFillingBlock(this._descriptionCreator.tierBattleExperienceInfantryEffectItem())).addProperty(new DurationFillingBlock(_loc6_)).addProperty(new PercentFillingBlock(_loc20_));
                    break;
                case EffectTypeId.TroopsTierBattleExperienceArmoured:
                    _loc8_ = this.createBonusItem(BonusItemOrderId.EFFECT_ITEM, 14).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.effectItem(_loc5_))).addProperty(new TitleFillingBlock(this._titleCreator.tierBattleExperienceArmouredEffectItem())).addProperty(new DescriptionFillingBlock(this._descriptionCreator.tierBattleExperienceArmouredEffectItem())).addProperty(new DurationFillingBlock(_loc6_)).addProperty(new PercentFillingBlock(_loc20_));
                    break;
                case EffectTypeId.TroopsTierBattleExperienceArtillery:
                    _loc8_ = this.createBonusItem(BonusItemOrderId.EFFECT_ITEM, 15).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.effectItem(_loc5_))).addProperty(new TitleFillingBlock(this._titleCreator.tierBattleExperienceArtilleryEffectItem())).addProperty(new DescriptionFillingBlock(this._descriptionCreator.tierBattleExperienceArtilleryEffectItem())).addProperty(new DurationFillingBlock(_loc6_)).addProperty(new PercentFillingBlock(_loc20_));
                    break;
                case EffectTypeId.TroopsTierBattleExperienceAerospace:
                    _loc8_ = this.createBonusItem(BonusItemOrderId.EFFECT_ITEM, 16).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.effectItem(_loc5_))).addProperty(new TitleFillingBlock(this._titleCreator.tierBattleExperienceAerospaceEffectItem())).addProperty(new DescriptionFillingBlock(this._descriptionCreator.tierBattleExperienceAerospaceEffectItem())).addProperty(new DurationFillingBlock(_loc6_)).addProperty(new PercentFillingBlock(_loc20_));
            }
            param1.addItem(_loc8_);
        }
        else if (_loc5_.researcherData != null) {
            _loc6_ = _loc5_.researcherData.duration.toSeconds();
            _loc8_ = this.createBonusItem(BonusItemOrderId.OTHER_BLACK_MARKET_ITEMS).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.additionalResearcherItem())).addProperty(new DescriptionFillingBlock(this._descriptionCreator.additionalResearcherItem())).addProperty(new TitleFillingBlock(this._titleCreator.additionalResearcherItem())).addProperty(new DurationFillingBlock(_loc6_));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.inventoryItemDestroyerData) {
            _loc6_ = _loc5_.inventoryItemDestroyerData.duration.toSeconds();
            _loc8_ = this.createBonusItem(BonusItemOrderId.OTHER_BLACK_MARKET_ITEMS).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(this._fullNameCreator.additionalInventoryItemDestroyerItem())).addProperty(new DescriptionFillingBlock(this._descriptionCreator.additionalInventoryItemDestroyerItem())).addProperty(new TitleFillingBlock(this._titleCreator.additionalInventoryItemDestroyerItem())).addProperty(new DurationFillingBlock(_loc6_));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.allianceCityTeleportData != null) {
            _loc8_ = this.createBonusItem(BonusItemOrderId.OTHER_BLACK_MARKET_ITEMS).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(_loc5_.name)).addProperty(new DescriptionFillingBlock(this._descriptionCreator.allianceCiytTeleportItem())).addProperty(new TitleFillingBlock(this._titleCreator.allianceCiytTeleportItem(_loc5_)));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.constructionPointsData != null) {
            _loc8_ = this.createBonusItem(BonusItemOrderId.OTHER_BLACK_MARKET_ITEMS).addProperty(new ImageFillingBlock(this._imageCreator.constructionPointsItem())).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(_loc5_.name)).addProperty(new DescriptionFillingBlock(this._descriptionCreator.constructionPointsItem())).addProperty(new TitleFillingBlock(this._titleCreator.constructionPointsItem(_loc5_)));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.gachaChestData != null) {
            _loc8_ = this.createBonusItem(BonusItemOrderId.OTHER_BLACK_MARKET_ITEMS).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(_loc5_.name)).addProperty(new DescriptionFillingBlock(this._descriptionCreator.gachaChest())).addProperty(new TitleFillingBlock(_loc5_.name));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.dustBonusData != null) {
            _loc7_ = param4 == null ? int(BonusItemOrderId.OTHER_BLACK_MARKET_ITEMS) : int(param4[param2]);
            _loc8_ = this.createBonusItem(_loc7_).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(_loc5_.name)).addProperty(new DescriptionFillingBlock(this._descriptionCreator.dustBonus())).addProperty(new TitleFillingBlock(_loc5_.name));
            param1.addItem(_loc8_);
        }
        else if (param2 == BlackMarketItemsTypeId.Slot_Rock) {
            _loc8_ = this.createBonusItem(BonusItemOrderId.OTHER_BLACK_MARKET_ITEMS).addProperty(new ImageFillingBlock(this._imageCreator.itemImageById(param2))).addProperty(new CountFillingBlock(param3)).addProperty(new FullNameFillingBlock(_loc5_.name)).addProperty(new DescriptionFillingBlock(this._descriptionCreator.gemSlotActivatorItem())).addProperty(new TitleFillingBlock(this._titleCreator.gemSlotActivatorItem(_loc5_)));
            param1.addItem(_loc8_);
        }
        else if (_loc5_.collectibleThemedItems != null) {
            _loc21_ = UserManager.user.gameData.questData.activeThemedEvent;
            if (_loc21_ != null && _loc21_.isActual()) {
                _loc22_ = _loc5_.collectibleThemedItems[0].itemWeight;
                _loc8_ = this.createBonusItem(BonusItemOrderId.OTHER_BLACK_MARKET_ITEMS).addProperty(new ImageFillingBlock(this._imageCreator.themedItems(param2))).addProperty(new TitleFillingBlock(this._titleCreator.themedItems())).addProperty(new CountFillingBlock(param3)).addProperty(new DescriptionFillingBlock(this._descriptionCreator.themedItems())).addProperty(new FullNameFillingBlock(this._fullNameCreator.themedItems(_loc22_))).addProperty(new ThemedEventItemFillingBlock(_loc22_));
                param1.addItem(_loc8_);
            }
        }
    }

    private function addBonusItemsResources(param1:ArrayCustom, param2:Resources, param3:UserPrizeOrder):void {
        var _loc4_:BonusItem = null;
        if (param2.money > 0) {
            _loc4_ = this.createBonusItem(BonusItemOrderId.RESOURCES).addProperty(new ImageFillingBlock(this._imageCreator.money())).addProperty(new CountFillingBlock(param2.money)).addProperty(new FullNameFillingBlock(this._fullNameCreator.money())).addProperty(new TitleFillingBlock(this._titleCreator.money()));
            param1.addItem(_loc4_);
        }
        if (param2.uranium > 0) {
            _loc4_ = this.createBonusItem(BonusItemOrderId.RESOURCES).addProperty(new ImageFillingBlock(this._imageCreator.uranium())).addProperty(new CountFillingBlock(param2.uranium)).addProperty(new FullNameFillingBlock(this._fullNameCreator.uranium())).addProperty(new TitleFillingBlock(this._titleCreator.uranium()));
            param1.addItem(_loc4_);
        }
        if (param2.titanite > 0) {
            _loc4_ = this.createBonusItem(BonusItemOrderId.RESOURCES).addProperty(new ImageFillingBlock(this._imageCreator.titanite())).addProperty(new CountFillingBlock(param2.titanite)).addProperty(new FullNameFillingBlock(this._fullNameCreator.titanite())).addProperty(new TitleFillingBlock(this._titleCreator.titanite()));
            param1.addItem(_loc4_);
        }
        if (param2.biochips > 0) {
            _loc4_ = this.createBonusItem(BonusItemOrderId.RESOURCES).addProperty(new ImageFillingBlock(this._imageCreator.biochips())).addProperty(new CountFillingBlock(param2.biochips)).addProperty(new FullNameFillingBlock(this._fullNameCreator.biochip())).addProperty(new TitleFillingBlock(this._titleCreator.biochip()));
            param1.addItem(_loc4_);
        }
        if (param2.constructionItems > 0) {
            _loc4_ = this.createBonusItem(BonusItemOrderId.RESOURCES).addProperty(new ImageFillingBlock(this._imageCreator.constructionItems())).addProperty(new CountFillingBlock(param2.constructionItems)).addProperty(new FullNameFillingBlock(this._fullNameCreator.constructionItems())).addProperty(new TitleFillingBlock(this._titleCreator.constructionItems()));
            param1.addItem(_loc4_);
        }
    }

    private function addBonusItemsTroops(param1:ArrayCustom, param2:Troops, param3:UserPrizeOrder):void {
        var _loc4_:Object = null;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc7_:GeoSceneObjectType = null;
        var _loc8_:BonusItem = null;
        var _loc9_:IActionInvoker = null;
        var _loc10_:* = undefined;
        if (param3 != null) {
            _loc4_ = param3.troopsOrder;
        }
        for (_loc10_ in param2.countByType) {
            _loc7_ = StaticDataManager.getObjectType(_loc10_);
            if (_loc7_ != null) {
                _loc6_ = param2.countByType[_loc10_];
                _loc5_ = _loc4_ == null ? int(BonusItemOrderId.TROOPS) : int(_loc4_[_loc10_]);
                _loc9_ = this._actionBehaviourCreator == null ? null : this._actionBehaviourCreator.unitActionBehaviour(_loc10_);
                _loc8_ = this.createBonusItem(_loc5_).addProperty(new ImageFillingBlock(this._imageCreator.unit(_loc7_))).addProperty(new CountFillingBlock(_loc6_)).addProperty(new FullNameFillingBlock(_loc7_.name)).addProperty(new UnitFillingBlock(_loc7_)).addProperty(new ActionFillingBlock(_loc9_)).addProperty(new DescriptionFillingBlock(this._descriptionCreator.troops(_loc10_))).addProperty(new TitleFillingBlock(_loc7_.name));
                param1.addItem(_loc8_);
            }
        }
    }

    private function addBonusItemDrawingPart(param1:ArrayCustom, param2:DrawingPart, param3:UserPrizeOrder):void {
        var _loc4_:int = param2.typeId;
        var _loc5_:GeoSceneObjectType = StaticDataManager.getObjectType(_loc4_);
        if (_loc5_ == null) {
            return;
        }
        var _loc6_:BonusItem = this.createBonusItem(BonusItemOrderId.DRAWING_PART).addProperty(new ImageFillingBlock(this._imageCreator.drawing(_loc5_))).addProperty(new CountFillingBlock(param2.count)).addProperty(new FullNameFillingBlock(_loc5_.name)).addProperty(new TitleFillingBlock(_loc5_.name));
        param1.addItem(_loc6_);
    }

    private function addBonusItemInventoryItems(param1:ArrayCustom, param2:ArrayCustom, param3:UserPrizeOrder):void {
        var _loc4_:InventoryItemQuestBonus = null;
        var _loc5_:int = 0;
        var _loc6_:BonusItem = null;
        for each(_loc4_ in param2) {
            _loc5_ = _loc4_.tier;
            _loc6_ = this.createBonusItem(BonusItemOrderId.INVENTORY).addProperty(new ImageFillingBlock(this._imageCreator.inventoryItem(_loc5_))).addProperty(new CountFillingBlock(1)).addProperty(new FullNameFillingBlock(this._fullNameCreator.inventory(_loc5_))).addProperty(new TitleFillingBlock(this._titleCreator.inventory(_loc5_)));
            param1.addItem(_loc6_);
        }
    }

    private function addBonusItemSkillPoints(param1:ArrayCustom, param2:int, param3:UserPrizeOrder):void {
        var _loc4_:int = param3 == null ? int(BonusItemOrderId.SKILL_POINTS) : int(param3.skillPointsOrder);
        var _loc5_:BonusItem = this.createBonusItem(_loc4_).addProperty(new ImageFillingBlock(this._imageCreator.nanopods())).addProperty(new CountFillingBlock(param2)).addProperty(new FullNameFillingBlock(this._fullNameCreator.skillPoints())).addProperty(new DescriptionFillingBlock(this._descriptionCreator.skillPoints())).addProperty(new TitleFillingBlock(this._fullNameCreator.skillPoints())).addProperty(new TitleFillingBlock(this._titleCreator.skillPoints()));
        param1.addItem(_loc5_);
    }

    private function addBonusDust(param1:ArrayCustom, param2:int, param3:UserPrizeOrder):void {
        var _loc4_:BonusItem = this.createBonusItem(BonusItemOrderId.DUST).addProperty(new ImageFillingBlock(this._imageCreator.dust())).addProperty(new CountFillingBlock(param2)).addProperty(new FullNameFillingBlock(this._fullNameCreator.dust())).addProperty(new TitleFillingBlock(this._titleCreator.dust()));
        param1.addItem(_loc4_);
    }

    private function addDragonPoints(param1:ArrayCustom, param2:int, param3:UserPrizeOrder):void {
        var _loc4_:BonusItem = this.createBonusItem(BonusItemOrderId.DRAGON_POINTS).addProperty(new ImageFillingBlock(this._imageCreator.dragonPoints())).addProperty(new CountFillingBlock(param2)).addProperty(new FullNameFillingBlock(this._fullNameCreator.dragonSkillPoints())).addProperty(new TitleFillingBlock(this._titleCreator.dragonSkillPoints()));
        param1.addItem(_loc4_);
    }

    private function addWisdomSkillPoints(param1:ArrayCustom, param2:int, param3:UserPrizeOrder):void {
        var _loc4_:BonusItem = this.createBonusItem(BonusItemOrderId.WISDOM_SKILL_POINTS).addProperty(new ImageFillingBlock(this._imageCreator.wisdomPoints())).addProperty(new CountFillingBlock(param2)).addProperty(new FullNameFillingBlock(this._fullNameCreator.wisdomSkillPoints())).addProperty(new TitleFillingBlock(this._titleCreator.wisdomSkillPoints()));
        param1.addItem(_loc4_);
    }

    private function addBonusItemExperience(param1:ArrayCustom, param2:int, param3:UserPrizeOrder):void {
        var _loc4_:BonusItem = this.createBonusItem(BonusItemOrderId.EXPERIENCE).addProperty(new ImageFillingBlock(this._imageCreator.experience())).addProperty(new CountFillingBlock(param2)).addProperty(new FullNameFillingBlock(this._fullNameCreator.experience(param2))).addProperty(new TitleFillingBlock(this._titleCreator.experience(param2)));
        param1.addItem(_loc4_);
    }

    private function addBonusItemAllianceResources(param1:ArrayCustom, param2:AllianceResources):void {
        var _loc3_:BonusItem = null;
        if (param2.cash > 0) {
            _loc3_ = this.createBonusItem(BonusItemOrderId.ALLIANCE_RESOURCES).addProperty(new ImageFillingBlock(this._imageCreator.allianceCash())).addProperty(new CountFillingBlock(param2.cash)).addProperty(new FullNameFillingBlock(this._fullNameCreator.allianceResourceCash())).addProperty(new TitleFillingBlock(this._titleCreator.allianceResourceCash()));
            param1.addItem(_loc3_);
        }
        if (param2.techPoints > 0) {
            _loc3_ = this.createBonusItem(BonusItemOrderId.ALLIANCE_RESOURCES).addProperty(new ImageFillingBlock(this._imageCreator.techPoints())).addProperty(new CountFillingBlock(param2.techPoints)).addProperty(new FullNameFillingBlock(this._fullNameCreator.allianceResourceTechPoints())).addProperty(new TitleFillingBlock(this._titleCreator.allianceResourceTechPoints()));
            param1.addItem(_loc3_);
        }
    }

    private function addBonusItemTacticsBonuses(param1:ArrayCustom, param2:AllianceTacticsBonuses):void {
        var _loc3_:BonusItem = null;
        if (param2.buffsCount > 0) {
            _loc3_ = this.createBonusItem(BonusItemOrderId.TACTICS_BONUSES).addProperty(new ImageFillingBlock(StringUtil.EMPTY)).addProperty(new CountFillingBlock(param2.buffsCount)).addProperty(new FullNameFillingBlock(this._fullNameCreator.buff())).addProperty(new TitleFillingBlock(this._titleCreator.buff()));
            param1.addItem(_loc3_);
        }
        if (param2.debuffsCount > 0) {
            _loc3_ = this.createBonusItem(BonusItemOrderId.TACTICS_BONUSES).addProperty(new ImageFillingBlock(StringUtil.EMPTY)).addProperty(new CountFillingBlock(param2.debuffsCount)).addProperty(new FullNameFillingBlock(this._fullNameCreator.debuff())).addProperty(new TitleFillingBlock(this._titleCreator.debuff()));
            param1.addItem(_loc3_);
        }
    }

    private function addBonusItemArtifacts(param1:ArrayCustom, param2:ArrayCustom):void {
        var _loc3_:BonusItem = null;
        var _loc4_:* = undefined;
        var _loc5_:GeoSceneObjectType = null;
        for each(_loc4_ in param2) {
            _loc5_ = StaticDataManager.getObjectType(_loc4_);
            _loc3_ = this.createBonusItem(BonusItemOrderId.ARTIFACT).addProperty(new ImageFillingBlock(StringUtil.EMPTY)).addProperty(new CountFillingBlock(1)).addProperty(new FullNameFillingBlock(_loc5_.name)).addProperty(new TitleFillingBlock(_loc5_.name));
            param1.addItem(_loc3_);
        }
    }

    private function addBonusItemDragonResources(param1:ArrayCustom, param2:DragonResources, param3:UserPrizeOrder):void {
        var _loc4_:int = 0;
        var _loc5_:BonusItem = null;
        if (param2.jade > 0) {
            _loc4_ = param3 == null ? int(BonusItemOrderId.DRAGON_RESOURCES) : int(param3.dragonResourcesJadeOrder);
            _loc5_ = this.createBonusItem(_loc4_).addProperty(new ImageFillingBlock(this._imageCreator.dragonResources("jade"))).addProperty(new CountFillingBlock(param2.jade)).addProperty(new FullNameFillingBlock(this._fullNameCreator.dragonResourcesJade())).addProperty(new DescriptionFillingBlock(this._descriptionCreator.dragonResourcesJade())).addProperty(new TitleFillingBlock(this._titleCreator.dragonResourcesJade()));
            param1.addItem(_loc5_);
        }
        if (param2.opal > 0) {
            _loc4_ = param3 == null ? int(BonusItemOrderId.DRAGON_RESOURCES) : int(param3.dragonResourcesOpalOrder);
            _loc5_ = this.createBonusItem(_loc4_).addProperty(new ImageFillingBlock(this._imageCreator.dragonResources("opal"))).addProperty(new CountFillingBlock(param2.opal)).addProperty(new FullNameFillingBlock(this._fullNameCreator.dragonResourcesOpal())).addProperty(new DescriptionFillingBlock(this._descriptionCreator.dragonResourcesOpal())).addProperty(new TitleFillingBlock(this._titleCreator.dragonResourcesOpal()));
            param1.addItem(_loc5_);
        }
        if (param2.ruby > 0) {
            _loc4_ = param3 == null ? int(BonusItemOrderId.DRAGON_RESOURCES) : int(param3.dragonResourcesRubyOrder);
            _loc5_ = this.createBonusItem(_loc4_).addProperty(new ImageFillingBlock(this._imageCreator.dragonResources("ruby"))).addProperty(new CountFillingBlock(param2.ruby)).addProperty(new FullNameFillingBlock(this._fullNameCreator.dragonResourcesRuby())).addProperty(new DescriptionFillingBlock(this._descriptionCreator.dragonResourcesRuby())).addProperty(new TitleFillingBlock(this._titleCreator.dragonResourcesRuby()));
            param1.addItem(_loc5_);
        }
    }

    private function addBonusItemMobilizer(param1:ArrayCustom, param2:int):void {
        var _loc3_:BonusItem = this.createBonusItem(BonusItemOrderId.MOBILIZERS).addProperty(new ImageFillingBlock(this._imageCreator.mobilizer())).addProperty(new CountFillingBlock(param2));
        param1.addItem(_loc3_);
    }

    private function addCharacters(param1:ArrayCustom, param2:Array):void {
        var _loc3_:BonusItem = null;
        var _loc4_:int = 0;
        while (_loc4_ < param2.length) {
            _loc3_ = this.createBonusItem(BonusItemOrderId.CHARACTERS).addProperty(new ImageFillingBlock(this._imageCreator.character(param2[_loc4_]))).addProperty(new CountFillingBlock(1)).addProperty(new ResourcesCountFillingBlock(1)).addProperty(new FullNameFillingBlock(this._fullNameCreator.character())).addProperty(new DescriptionFillingBlock(this._descriptionCreator.character())).addProperty(new TitleFillingBlock(this._titleCreator.character()));
            param1.addItem(_loc3_);
            _loc4_++;
        }
    }

    private function createBonusItem(param1:Number, param2:Number = 0):BonusItem {
        var _loc3_:BonusItemWithPositions = new BonusItemWithPositions();
        _loc3_.primarySortPosition = param1;
        _loc3_.secondarySortPosition = param2;
        return _loc3_;
    }
}
}
