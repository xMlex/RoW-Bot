package model.data {
import common.ArrayCustom;

import flash.utils.Dictionary;

import model.data.alliances.city.AllianceCityData;
import model.data.locations.allianceCity.flags.AllianceTacticsBonuses;
import model.data.ratings.UserPrizeOrder;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.data.temporarySkins.TemporarySectorSkinData;
import model.data.temporarySkins.TemporarySkin;
import model.data.users.drawings.DrawingPart;
import model.data.users.misc.UserSectorSkinData;
import model.data.users.troops.Troops;
import model.logic.AllianceManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketItems.BlackMarketItemsNode;
import model.logic.character.UserCharacterData;
import model.logic.dtoSerializer.DtoDeserializer;
import model.logic.quests.BonusCalc;
import model.logic.units.UnitUtility;
import model.modules.allianceCity.data.resourceHistory.AllianceResources;
import model.modules.dragonAbilities.data.resources.DragonResources;

public class UserPrize {

    public static const RESOURCES_BLACK_CRYSTALS:String = "UserPrize_blackCrystal";

    public static const RESOURCES_GOLD_MONEY:String = "UserPrize_goldMoney";

    public static const RESOURCES_AVP_MONEY:String = "UserPrize_avpMoney";

    public static const RESOURCES_MONEY:String = "UserPrize_money";

    public static const RESOURCES_TITANITE:String = "UserPrize_titanite";

    public static const RESOURCES_URANIUM:String = "UserPrize_uranium";

    public static const RESOURCES_BIOCHIPS:String = "UserPrize_biochips";

    public static const RESOURCES_CONSTRUCTION_ITEMS:String = "UserPrize_constructionItems";

    public static const TROOPS:String = "UserPrize_troops";

    public static const VIP_POINTS:String = "UserPrize_vipPoints";

    public static const ALLIANCE_CASH:String = "UserPrize_allianceCash";

    public static const TECH_POINTS:String = "UserPrize_techPoints";

    public static const NANOPODS:String = "UserPrize_nanopods";

    public static const BLACK_MARKET_ITEMS:String = "UserPrize_bm_items";

    public static const EXPERIENCE:String = "UserPrize_exp";

    public static const WISDOM_POINTS:String = "UserPrize_wisdomPoints";

    public static const CONSTRUCTION_BLOCKS:String = "ConstructionBlocksItem";

    public static const MOBILIZER:String = "UserPrize_mobilizer";

    public static const ROBBERY:String = "UserPrize_robbery";

    public static const DRAGON_RESOURCES_JADE:String = "UserPrize_jade";

    public static const DRAGON_RESOURCES_RUBY:String = "UserPrize_ruby";

    public static const DRAGON_RESOURCES_OPAL:String = "UserPrize_opal";

    public static const DRAGON_SKILL_POINTS:String = "UserPrize_dragonSkillPoints";

    public static const ARTIFACTS:String = "UserPrize_artifacts";

    public static const REWARD_BOX:String = "UserPrize_rewardBox";

    public static const TACTICS_BONUSES:String = "UserPrize_tacticsBonuses";

    public static const LEVEL_UP_POINTS:String = "UserPrize_levelUpPoints";

    public static const CHARACTERS_BONUSES:String = "UserPrize_characters";

    public static const MrCoinsBonusSize01:int = 20;

    public static const MrCoinsBonusSize02:int = 70;

    public static const MrCoinsBonusSize03:int = 80;

    public static const MrCoinsBonusSize05:int = 50;


    public var resources:Resources;

    public var drawingPart:DrawingPart;

    public var troops:Troops;

    public var experience:int;

    public var wisdomPoints:int;

    public var skillPoints:int;

    public var artifactTypeIds:ArrayCustom;

    public var blackMarketItems:Dictionary;

    public var blackMarketItemsResourcesPackId:int;

    public var blackMarketItemsResourcesPackCount:int;

    public var mobilizers:int;

    public var inventoryItems:ArrayCustom;

    public var constructionBlocks:int;

    public var bonusesId:int;

    public var nonItemsTypeIds:ArrayCustom;

    public var constructionBlockPrize:int = 0;

    public var vipPoints:int = 0;

    public var robberyCount:int = 0;

    public var constructionWorkers:int = 0;

    public var miniGameCoins:int = 0;

    public var minUserCollectedCount:int;

    public var maxUserCollectedCount:int;

    public var minBonusValueFloor:int;

    public var minBonusValue:int;

    public var bonusValueStep:int;

    public var allianceResources:AllianceResources;

    public var dragonSkillPoints:int;

    public var dragonResources:DragonResources;

    public var dragonPoints:int;

    public var dust:int;

    public var order:UserPrizeOrder;

    public var sectorSkins:ArrayCustom;

    public var characters:Array;

    public var temporarySkins:Array;

    public var levelUpPoints:int;

    public var tacticsBonuses:AllianceTacticsBonuses;

    public function UserPrize() {
        this.inventoryItems = new ArrayCustom();
        super();
    }

    public static function fromDto(param1:*):UserPrize {
        var _loc4_:int = 0;
        var _loc5_:* = undefined;
        if (param1 == null) {
            return null;
        }
        var _loc2_:UserPrize = new UserPrize();
        _loc2_.bonusesId = param1.i == null ? -1 : int(param1.i);
        _loc2_.resources = param1.r == null ? null : Resources.fromDto(param1.r);
        var _loc3_:ArrayCustom = param1.d == null ? null : DrawingPart.fromDtos(param1.d);
        _loc2_.drawingPart = _loc3_ == null || _loc3_.length == 0 ? null : _loc3_[0];
        _loc2_.troops = param1.t == null ? null : Troops.fromDto(param1.t);
        _loc2_.experience = param1.e;
        _loc2_.wisdomPoints = param1.wp;
        _loc2_.skillPoints = param1.s;
        _loc2_.vipPoints = param1.v;
        _loc2_.constructionWorkers = param1.w;
        _loc2_.dragonSkillPoints = param1.p;
        _loc2_.levelUpPoints = param1.lu;
        _loc2_.dust = param1.du;
        if (param1.a != null) {
            _loc2_.artifactTypeIds = new ArrayCustom();
            for each(_loc4_ in param1.a) {
                _loc2_.artifactTypeIds.addItem(_loc4_);
            }
        }
        if (param1.b != null) {
            _loc2_.blackMarketItems = new Dictionary();
            for (_loc5_ in param1.b) {
                _loc2_.blackMarketItems[_loc5_] = param1.b[_loc5_];
                if (BlackMarketItemsTypeId.resourcesPackTitan.indexOf(_loc5_) > -1 || BlackMarketItemsTypeId.resourcesPackUran.indexOf(_loc5_) > -1 || BlackMarketItemsTypeId.resourcesPackCredit.indexOf(_loc5_) > -1) {
                    _loc2_.blackMarketItemsResourcesPackId = _loc5_;
                    _loc2_.blackMarketItemsResourcesPackCount = param1.b[_loc5_];
                }
            }
        }
        _loc2_.mobilizers = param1.x == null ? 0 : int(param1.x);
        _loc2_.constructionBlocks = param1.c == null ? 0 : int(param1.c);
        _loc2_.allianceResources = param1.ar == null ? null : AllianceResources.fromDto(param1.ar);
        _loc2_.temporarySkins = DtoDeserializer.toArray(param1.f, TemporarySkin.fromDto);
        if (param1.n != null) {
            _loc2_.dragonResources = DragonResources.fromDto(param1.n);
        }
        _loc2_.dragonPoints = param1.p;
        if (param1.po != null) {
            _loc2_.order = UserPrizeOrder.fromDto(param1.po);
        }
        _loc2_.characters = DtoDeserializer.toArray(param1.bc);
        _loc2_.tacticsBonuses = param1.ab == null ? null : AllianceTacticsBonuses.fromDto(param1.ab);
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        if (param1 == null) {
            return new ArrayCustom();
        }
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function createBonusCalc(param1:UserPrize):BonusCalc {
        return new BonusCalc(param1.minBonusValueFloor, param1.minBonusValue, param1.getMaxBonusValue(), param1.minUserCollectedCount, param1.maxUserCollectedCount, param1.bonusValueStep);
    }

    public static function merge(param1:UserPrize, param2:UserPrize):UserPrize {
        if (param1 == null && param2 == null) {
            return null;
        }
        if (param1 == null && param2 != null) {
            return param2.clone();
        }
        var _loc3_:UserPrize = param1.clone();
        _loc3_.sourceMerge(param2);
        return _loc3_;
    }

    public static function getIntersection(param1:UserPrize, param2:UserPrize):UserPrize {
        var _loc5_:int = 0;
        var _loc6_:* = undefined;
        var _loc7_:* = undefined;
        var _loc8_:TemporarySkin = null;
        if (param1 == null || param2 == null) {
            return null;
        }
        var _loc3_:UserPrize = new UserPrize();
        var _loc4_:int = 0;
        if (param1.resources != null && param2.resources != null) {
            _loc3_.resources = Resources.getIntersection(param1.resources, param2.resources);
        }
        if (param1.drawingPart != null && param2.drawingPart != null) {
            _loc3_.drawingPart = param2.drawingPart.clone();
        }
        if (param1.troops != null && param2.troops != null) {
            _loc3_.troops = new Troops();
            for (_loc6_ in param2.troops.countByType) {
                if (param2.troops.countByType[_loc6_] > 0 && param1.troops.countByType[_loc6_] != undefined && param1.troops.countByType[_loc6_] > 0) {
                    _loc3_.troops.countByType[_loc6_] = param2.troops.countByType[_loc6_];
                }
            }
        }
        if (param1.experience > 0 && param2.experience > 0) {
            _loc3_.experience = param2.experience;
        }
        if (param1.wisdomPoints > 0 && param2.wisdomPoints > 0) {
            _loc3_.wisdomPoints = param2.wisdomPoints;
        }
        if (param1.skillPoints > 0 && param2.skillPoints > 0) {
            _loc3_.skillPoints = param2.skillPoints;
        }
        if (param1.constructionBlocks > 0 && param2.constructionBlocks > 0) {
            _loc3_.constructionBlocks = param2.constructionBlocks;
        }
        if (param1.artifactTypeIds != null && param2.artifactTypeIds != null) {
            _loc5_ = param2.artifactTypeIds.length;
            _loc4_ = 0;
            _loc3_.artifactTypeIds = new ArrayCustom();
            while (_loc4_ < _loc5_) {
                if (param1.artifactTypeIds.indexOf(param2.artifactTypeIds[_loc4_]) != -1) {
                    _loc3_.artifactTypeIds.push(param2.artifactTypeIds[_loc4_]);
                }
                _loc4_++;
            }
        }
        if (param1.sectorSkins != null && param2.sectorSkins != null) {
            _loc5_ = param2.sectorSkins.length;
            _loc4_ = 0;
            _loc3_.sectorSkins = new ArrayCustom();
            while (_loc4_ < _loc5_) {
                if (param1.sectorSkins.indexOf(param2.sectorSkins[_loc4_]) != -1) {
                    _loc3_.sectorSkins.push(param2.sectorSkins[_loc4_]);
                }
                _loc4_++;
            }
        }
        if (param1.blackMarketItems != null && param2.blackMarketItems != null) {
            _loc3_.blackMarketItems = new Dictionary();
            for (_loc7_ in param2.blackMarketItems) {
                if (param2.blackMarketItems[_loc7_] > 0 && param1.blackMarketItems[_loc7_] != undefined && param1.blackMarketItems[_loc7_] > 0) {
                    _loc3_.blackMarketItems[_loc7_] = param2.blackMarketItems[_loc7_];
                }
            }
        }
        if (param1.blackMarketItemsResourcesPackId > 0 && param2.blackMarketItemsResourcesPackId > 0) {
            _loc3_.blackMarketItemsResourcesPackId = param2.blackMarketItemsResourcesPackId;
        }
        if (param1.blackMarketItemsResourcesPackCount > 0 && param2.blackMarketItemsResourcesPackCount > 0) {
            _loc3_.blackMarketItemsResourcesPackCount = param2.blackMarketItemsResourcesPackCount;
        }
        if (param1.mobilizers > 0 && param2.mobilizers > 0) {
            _loc3_.mobilizers = param2.mobilizers;
        }
        if (param1.inventoryItems != null && param2.inventoryItems != null) {
            _loc5_ = param2.inventoryItems.length;
            _loc4_ = 0;
            _loc3_.inventoryItems = new ArrayCustom();
            while (_loc4_ < _loc5_) {
                if (param1.inventoryItems.indexOf(param2.inventoryItems[_loc4_]) != -1) {
                    _loc3_.inventoryItems.push(param2.inventoryItems[_loc4_]);
                }
                _loc4_++;
            }
        }
        if (param1.bonusesId > 0 && param2.bonusesId > 0) {
            _loc3_.bonusesId = param2.bonusesId;
        }
        if (param1.nonItemsTypeIds != null && param2.nonItemsTypeIds != null) {
            _loc5_ = param2.nonItemsTypeIds.length;
            _loc4_ = 0;
            _loc3_.nonItemsTypeIds = new ArrayCustom();
            while (_loc4_ < _loc5_) {
                if (param1.nonItemsTypeIds.indexOf(param2.nonItemsTypeIds[_loc4_]) != -1) {
                    _loc3_.nonItemsTypeIds.push(param2.nonItemsTypeIds[_loc4_]);
                }
                _loc4_++;
            }
        }
        if (param1.constructionBlockPrize > 0 && param2.constructionBlockPrize > 0) {
            _loc3_.constructionBlockPrize = param2.constructionBlockPrize;
        }
        if (param1.vipPoints > 0 && param2.vipPoints > 0) {
            _loc3_.vipPoints = param2.vipPoints;
        }
        if (param1.robberyCount > 0 && param2.robberyCount > 0) {
            _loc3_.robberyCount = param2.robberyCount;
        }
        if (param1.constructionWorkers > 0 && param2.constructionWorkers > 0) {
            _loc3_.constructionWorkers = param2.constructionWorkers;
        }
        if (param1.miniGameCoins > 0 && param2.miniGameCoins > 0) {
            _loc3_.miniGameCoins = param2.miniGameCoins;
        }
        if (param1.dust > 0 && param2.dust > 0) {
            _loc3_.dust = param2.dust;
        }
        if (param1.dragonPoints > 0 && param2.dragonPoints > 0) {
            _loc3_.dragonPoints = param2.dragonPoints;
        }
        if (param1.dragonSkillPoints > 0 && param2.dragonSkillPoints > 0) {
            _loc3_.dragonSkillPoints = param2.dragonSkillPoints;
        }
        if (param1.allianceResources != null && param2.allianceResources != null) {
            _loc3_.allianceResources = AllianceResources.getIntersection(param1.allianceResources, param2.allianceResources);
        }
        if (param1.dragonResources != null && param2.dragonResources != null) {
            _loc3_.dragonResources = DragonResources.getIntersection(param1.dragonResources, param2.dragonResources);
        }
        if (param1.temporarySkins != null && param2.temporarySkins != null) {
            _loc3_.temporarySkins = [];
            for each(_loc8_ in param2.temporarySkins) {
                if (param1.temporarySkins.indexOf(_loc8_) != -1) {
                    _loc3_.temporarySkins.push(_loc8_);
                }
            }
        }
        if (param1.order != null && param2.order != null) {
            _loc3_.order = UserPrizeOrder.getIntersection(param1.order, param2.order);
        }
        if (param1.characters != null && param2.characters != null) {
            _loc5_ = param2.characters.length;
            _loc4_ = 0;
            _loc3_.characters = [];
            while (_loc4_ < _loc5_) {
                if (param1.characters.indexOf(param2.characters[_loc4_]) != -1) {
                    _loc3_.characters.push(param2.characters[_loc4_]);
                }
                _loc4_++;
            }
        }
        if (param1.tacticsBonuses != null && param2.tacticsBonuses != null) {
            _loc3_.tacticsBonuses = AllianceTacticsBonuses.getIntersection(param1.tacticsBonuses, param2.tacticsBonuses);
        }
        return _loc3_;
    }

    public function getType():String {
        if (this.resources != null && !this.resources.isNegative()) {
            if (this.resources.goldMoney > 0) {
                return RESOURCES_GOLD_MONEY;
            }
            if (this.resources.blackCrystals > 0) {
                return RESOURCES_BLACK_CRYSTALS;
            }
            if (this.resources.constructionItems > 0) {
                return RESOURCES_CONSTRUCTION_ITEMS;
            }
        }
        if (this.allianceResources) {
            if (this.allianceResources.cash > 0) {
                return ALLIANCE_CASH;
            }
            if (this.allianceResources.techPoints > 0) {
                return TECH_POINTS;
            }
        }
        if (this.troops != null && this.troops.capacity() > 0) {
            return TROOPS;
        }
        if (this.skillPoints > 0) {
            return NANOPODS;
        }
        if (this.vipPoints > 0) {
            return VIP_POINTS;
        }
        if (this.blackMarketItems != null) {
            return BLACK_MARKET_ITEMS;
        }
        if (this.experience > 0) {
            return EXPERIENCE;
        }
        if (this.wisdomPoints > 0) {
            return WISDOM_POINTS;
        }
        if (this.constructionBlocks > 0) {
            return CONSTRUCTION_BLOCKS;
        }
        if (this.dragonResources != null) {
            if (this.dragonResources.jade > 0) {
                return DRAGON_RESOURCES_JADE;
            }
            if (this.dragonResources.ruby > 0) {
                return DRAGON_RESOURCES_RUBY;
            }
            if (this.dragonResources.opal > 0) {
                return DRAGON_RESOURCES_OPAL;
            }
        }
        if (this.dragonSkillPoints > 0) {
            return DRAGON_SKILL_POINTS;
        }
        if (this.tacticsBonuses) {
            return TACTICS_BONUSES;
        }
        if (this.artifactTypeIds != null && this.artifactTypeIds.length > 0) {
            return ARTIFACTS;
        }
        if (this.characters != null && this.characters.length > 0) {
            return CHARACTERS_BONUSES;
        }
        return null;
    }

    public function hasBonusesExceptGoldMoney():Boolean {
        return this.drawingPart || this.troops || this.experience || this.wisdomPoints || this.skillPoints || this.artifactTypeIds || this.blackMarketItems || this.dragonResources || this.blackMarketItemsResourcesPackId || this.blackMarketItemsResourcesPackCount || this.mobilizers || this.inventoryItems && this.inventoryItems.length > 0 || this.nonItemsTypeIds || this.constructionBlockPrize || this.vipPoints || this.robberyCount || this.constructionWorkers || this.miniGameCoins || this.sectorSkins || this.allianceResources || this.resources && !this.resources.isOnlyGold || this.temporarySkins != null && this.temporarySkins.length > 0;
    }

    public function hasBMI(param1:int):Boolean {
        return this.blackMarketItems != null && this.blackMarketItems[param1] != null;
    }

    public function getMaxBonusValue():int {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        if (this.resources != null && !this.resources.isNegative()) {
            if (this.resources.goldMoney > 0) {
                return int(this.resources.goldMoney);
            }
            if (this.resources.uranium > 0) {
                return int(this.resources.uranium);
            }
            if (this.resources.titanite > 0) {
                return int(this.resources.titanite);
            }
            if (this.resources.money > 0) {
                return int(this.resources.money);
            }
            if (this.resources.biochips > 0) {
                return int(this.resources.biochips);
            }
            if (this.resources.blackCrystals > 0) {
                return int(this.resources.blackCrystals);
            }
            if (this.resources.constructionItems > 0) {
                return int(this.resources.constructionItems);
            }
        }
        if (this.drawingPart != null) {
            return 1;
        }
        if (this.troops != null && this.troops.capacity() > 0) {
            return int(this.troops.maxValue());
        }
        if (this.experience > 0) {
            return int(this.experience);
        }
        if (this.wisdomPoints > 0) {
            return int(this.wisdomPoints);
        }
        if (this.skillPoints > 0) {
            return int(this.skillPoints);
        }
        if (this.vipPoints > 0) {
            return int(this.vipPoints);
        }
        if (this.artifactTypeIds != null && this.artifactTypeIds.length > 0) {
            return this.artifactTypeIds.length;
        }
        if (this.sectorSkins != null && this.sectorSkins.length > 0) {
            return this.sectorSkins.length;
        }
        if (this.blackMarketItems != null) {
            _loc1_ = 0;
            for each(_loc2_ in this.blackMarketItems) {
                _loc1_ = _loc1_ + _loc2_;
            }
            return _loc2_;
        }
        if (this.constructionBlocks > 0) {
            return int(this.constructionBlocks);
        }
        if (this.allianceResources != null) {
            if (this.allianceResources.cash > 0) {
                return int(this.allianceResources.cash);
            }
            if (this.allianceResources.techPoints > 0) {
                return int(this.allianceResources.techPoints);
            }
        }
        if (this.dragonResources != null) {
            if (this.dragonResources.jade > 0) {
                return this.dragonResources.jade;
            }
            if (this.dragonResources.ruby > 0) {
                return this.dragonResources.ruby;
            }
            if (this.dragonResources.opal > 0) {
                return this.dragonResources.opal;
            }
        }
        if (this.dragonSkillPoints > 0) {
            return this.dragonSkillPoints;
        }
        if (this.characters != null && this.characters.length > 0) {
            return this.characters.length;
        }
        return this.minUserCollectedCount;
    }

    public function getAllTemporarySkins():Array {
        if (this.blackMarketItems == null) {
            return this.temporarySkins;
        }
        var _loc1_:Array = [];
        this.findAndPushSkinFromStaticData(_loc1_, BlackMarketItemsTypeId.TemporarySectorSkinBig1Day);
        this.findAndPushSkinFromStaticData(_loc1_, BlackMarketItemsTypeId.TemporarySectorSkinBig7Day);
        this.findAndPushSkinFromStaticData(_loc1_, BlackMarketItemsTypeId.TemporarySectorSkin1Day);
        this.findAndPushSkinFromStaticData(_loc1_, BlackMarketItemsTypeId.TemporarySectorSkin7Day);
        this.findAndPushSkinFromStaticData(_loc1_, BlackMarketItemsTypeId.TemporarySectorSkinSmall1Day);
        this.findAndPushSkinFromStaticData(_loc1_, BlackMarketItemsTypeId.TemporarySectorSkinSmall7Day);
        if (this.temporarySkins != null) {
            _loc1_ = _loc1_.concat(this.temporarySkins);
        }
        return _loc1_.length == 0 ? null : _loc1_;
    }

    public function scaleMultiPlayer(param1:Number):UserPrize {
        var _loc3_:Dictionary = null;
        var _loc4_:* = undefined;
        var _loc5_:Number = NaN;
        var _loc2_:UserPrize = this.clone();
        if (param1 != 1) {
            _loc2_.experience = int(_loc2_.experience * param1);
            _loc2_.wisdomPoints = int(_loc2_.wisdomPoints * param1);
            _loc2_.skillPoints = int(_loc2_.skillPoints * param1);
            _loc2_.vipPoints = int(_loc2_.vipPoints * param1);
            if (_loc2_.resources != null && !_loc2_.resources.isNegative()) {
                _loc2_.resources.scale(param1);
            }
            if (_loc2_.troops != null) {
                _loc2_.troops.scaleTroops(param1);
            }
            if (_loc2_.blackMarketItems != null) {
                _loc3_ = new Dictionary();
                for (_loc4_ in _loc2_.blackMarketItems) {
                    _loc5_ = int(_loc2_.blackMarketItems[_loc4_] * param1);
                    if (_loc5_ > 0) {
                        _loc3_[_loc4_] = _loc5_;
                    }
                }
                _loc2_.blackMarketItems = _loc3_;
            }
        }
        if (_loc2_.dragonResources != null) {
            _loc2_.dragonResources = _loc2_.dragonResources.scale(param1);
        }
        _loc2_.dragonSkillPoints = int(_loc2_.dragonSkillPoints * param1);
        return _loc2_;
    }

    public function scaleMinMax(param1:int):UserPrize {
        var _loc2_:int = createBonusCalc(this).getCurrentBonus(param1);
        return this.scaleByCount(_loc2_);
    }

    public function scaleByCount(param1:int):UserPrize {
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        if (param1 == 0) {
            return new UserPrize();
        }
        var _loc2_:UserPrize = this.clone();
        if (_loc2_.resources != null && !_loc2_.resources.isNegative()) {
            if (_loc2_.resources.goldMoney > 0) {
                _loc2_.resources.goldMoney = param1;
            }
            if (_loc2_.resources.uranium > 0) {
                _loc2_.resources.uranium = param1;
            }
            if (_loc2_.resources.titanite > 0) {
                _loc2_.resources.titanite = param1;
            }
            if (_loc2_.resources.money > 0) {
                _loc2_.resources.money = param1;
            }
            if (_loc2_.resources.biochips > 0) {
                _loc2_.resources.biochips = param1;
            }
            if (_loc2_.resources.blackCrystals > 0) {
                _loc2_.resources.blackCrystals = param1;
            }
        }
        if (_loc2_.drawingPart != null && param1 > 0) {
            _loc2_.drawingPart = this.drawingPart.clone();
        }
        if (_loc2_.troops != null && _loc2_.troops.capacity() > 0) {
            for (_loc3_ in _loc2_.troops.countByType) {
                _loc2_.troops.countByType[_loc3_] = param1;
            }
        }
        if (_loc2_.experience > 0) {
            _loc2_.experience = param1;
        }
        if (_loc2_.wisdomPoints > 0) {
            _loc2_.wisdomPoints = param1;
        }
        if (_loc2_.skillPoints > 0) {
            _loc2_.skillPoints = param1;
        }
        if (_loc2_.artifactTypeIds != null && _loc2_.artifactTypeIds.length > 0) {
            _loc2_.artifactTypeIds = new ArrayCustom(_loc2_.artifactTypeIds.slice(0, param1));
        }
        if (_loc2_.sectorSkins != null && _loc2_.sectorSkins.length > 0) {
            _loc2_.sectorSkins = new ArrayCustom(_loc2_.sectorSkins.slice(0, param1));
        }
        if (_loc2_.blackMarketItems != null) {
            for (_loc4_ in _loc2_.blackMarketItems) {
                _loc2_.blackMarketItems[_loc4_] = param1;
            }
        }
        if (_loc2_.constructionWorkers > 0) {
            _loc2_.constructionWorkers = param1;
        }
        if (_loc2_.vipPoints > 0) {
            _loc2_.vipPoints = param1;
        }
        if (_loc2_.robberyCount > 0) {
            _loc2_.robberyCount = param1;
        }
        if (_loc2_.robberyCount > 0) {
            _loc2_.robberyCount = param1;
        }
        if (_loc2_.allianceResources != null && !_loc2_.allianceResources) {
            if (_loc2_.allianceResources.cash > 0) {
                _loc2_.allianceResources.cash = param1;
            }
            if (_loc2_.allianceResources.techPoints > 0) {
                _loc2_.allianceResources.techPoints = param1;
            }
        }
        return _loc2_;
    }

    public function clone():UserPrize {
        var _loc2_:* = undefined;
        var _loc1_:UserPrize = new UserPrize();
        _loc1_.resources = this.resources == null ? null : new Resources(this.resources.goldMoney, this.resources.money, this.resources.uranium, this.resources.titanite, this.resources.biochips, this.resources.blackCrystals, this.resources.idols, this.resources.avpMoney, this.resources.constructionItems);
        _loc1_.drawingPart = this.drawingPart == null ? null : this.drawingPart.clone();
        _loc1_.troops = this.troops == null ? null : new Troops(this.troops);
        _loc1_.experience = this.experience;
        _loc1_.wisdomPoints = this.wisdomPoints;
        _loc1_.skillPoints = this.skillPoints;
        _loc1_.artifactTypeIds = this.artifactTypeIds == null ? null : new ArrayCustom(this.artifactTypeIds);
        _loc1_.sectorSkins = this.sectorSkins == null ? null : new ArrayCustom(this.sectorSkins);
        if (this.blackMarketItems != null) {
            _loc1_.blackMarketItems = new Dictionary();
            for (_loc2_ in this.blackMarketItems) {
                _loc1_.blackMarketItems[_loc2_] = this.blackMarketItems[_loc2_];
            }
        }
        _loc1_.blackMarketItemsResourcesPackId = this.blackMarketItemsResourcesPackId;
        _loc1_.blackMarketItemsResourcesPackCount = this.blackMarketItemsResourcesPackCount;
        _loc1_.mobilizers = this.mobilizers;
        _loc1_.inventoryItems = this.inventoryItems == null ? null : new ArrayCustom(this.inventoryItems);
        _loc1_.bonusesId = this.bonusesId;
        _loc1_.nonItemsTypeIds = this.nonItemsTypeIds == null ? null : new ArrayCustom(this.nonItemsTypeIds);
        _loc1_.constructionBlockPrize = this.constructionBlockPrize;
        _loc1_.vipPoints = this.vipPoints;
        _loc1_.robberyCount = this.robberyCount;
        _loc1_.constructionWorkers = this.constructionWorkers;
        _loc1_.miniGameCoins = this.miniGameCoins;
        _loc1_.dust = this.dust;
        _loc1_.dragonPoints = this.dragonPoints;
        _loc1_.allianceResources = this.allianceResources == null ? null : this.allianceResources.clone();
        _loc1_.dragonResources = this.dragonResources == null ? null : this.dragonResources.clone();
        _loc1_.temporarySkins = this.temporarySkins == null ? null : this.temporarySkins.concat();
        if (this.order != null) {
            _loc1_.order = this.order.clone();
        }
        if (this.characters != null) {
            _loc1_.characters = [].concat(this.characters);
        }
        return _loc1_;
    }

    public function sourceMerge(param1:UserPrize):void {
        var _loc2_:* = undefined;
        if (param1 == null) {
            return;
        }
        if (param1.artifactTypeIds != null && param1.artifactTypeIds.Count > 0) {
            if (this.artifactTypeIds == null) {
                this.artifactTypeIds = new ArrayCustom();
            }
            this.artifactTypeIds.addAll(param1.artifactTypeIds);
        }
        if (param1.experience > 0) {
            this.experience = this.experience + param1.experience;
        }
        if (param1.wisdomPoints > 0) {
            this.wisdomPoints = this.wisdomPoints + param1.wisdomPoints;
        }
        if (param1.resources != null && !param1.resources.isNegative()) {
            if (this.resources == null) {
                this.resources = new Resources();
            }
            this.resources.add(param1.resources);
        }
        if (param1.skillPoints > 0) {
            this.skillPoints = this.skillPoints + param1.skillPoints;
        }
        if (param1.dust > 0) {
            this.dust = this.dust + param1.dust;
        }
        if (param1.dragonPoints > 0) {
            this.dragonPoints = this.dragonPoints + param1.dragonPoints;
        }
        if (param1.order != null && this.order == null) {
            this.order = param1.order;
        }
        if (param1.troops != null) {
            if (this.troops == null) {
                this.troops = new Troops();
            }
            this.troops.addTroops(param1.troops);
        }
        if (param1.blackMarketItems != null) {
            if (this.blackMarketItems == null) {
                this.blackMarketItems = new Dictionary();
            }
            for (_loc2_ in param1.blackMarketItems) {
                if (!this.blackMarketItems.hasOwnProperty(_loc2_)) {
                    this.blackMarketItems[_loc2_] = param1.blackMarketItems[_loc2_];
                }
                else {
                    this.blackMarketItems[_loc2_] = this.blackMarketItems[_loc2_] + param1.blackMarketItems[_loc2_];
                }
            }
        }
        if (param1.allianceResources != null) {
            if (this.allianceResources == null) {
                this.allianceResources = new AllianceResources();
            }
            this.allianceResources.cash = this.allianceResources.cash + param1.allianceResources.cash;
            this.allianceResources.techPoints = this.allianceResources.techPoints + param1.allianceResources.techPoints;
        }
        if (param1.dragonResources != null) {
            this.dragonResources = new DragonResources();
            this.dragonResources.add(param1.dragonResources);
        }
        if (this.drawingPart == null && param1.drawingPart != null) {
            this.drawingPart = param1.drawingPart.clone();
        }
        this.blackMarketItemsResourcesPackCount = this.blackMarketItemsResourcesPackCount + param1.blackMarketItemsResourcesPackCount;
        this.mobilizers = this.mobilizers + param1.mobilizers;
        this.constructionBlockPrize = this.constructionBlockPrize + param1.constructionBlockPrize;
        this.constructionWorkers = this.constructionWorkers + param1.constructionWorkers;
        this.miniGameCoins = this.miniGameCoins + param1.minBonusValue;
        this.vipPoints = this.vipPoints + param1.vipPoints;
        this.robberyCount = this.robberyCount + param1.robberyCount;
        if (this.inventoryItems != null && param1.inventoryItems != null) {
            this.inventoryItems = this.inventoryItems.addAll(param1.inventoryItems);
        }
        if (this.temporarySkins == null && param1.temporarySkins != null) {
            this.temporarySkins = [];
        }
        if (this.temporarySkins != null && param1.temporarySkins != null) {
            this.temporarySkins = this.temporarySkins.concat(param1.temporarySkins);
        }
        if (param1.characters != null) {
            this.characters = this.characters.concat(param1.characters);
        }
    }

    public function givePrizeToUser():void {
        var _loc2_:Dictionary = null;
        var _loc3_:* = undefined;
        var _loc4_:BlackMarketItemRaw = null;
        var _loc5_:AllianceCityData = null;
        var _loc6_:int = 0;
        var _loc1_:UserGameData = UserManager.user.gameData;
        if (this.resources != null) {
            _loc1_.account.resources.add(this.resources);
        }
        if (this.levelUpPoints > 0) {
            _loc1_.account.levelUpPoints = _loc1_.account.levelUpPoints + this.levelUpPoints;
        }
        if (this.dust > 0 && _loc1_.inventoryData != null) {
            _loc1_.inventoryData.addDust(this.dust);
        }
        if (this.drawingPart != null) {
            _loc1_.drawingArchive.addDrawingPart(this.drawingPart);
        }
        if (this.troops != null) {
            UnitUtility.AddTroopsToBunker(UserManager.user, this.troops);
        }
        if (this.experience > 0) {
            _loc1_.account.experience = _loc1_.account.experience + this.experience;
        }
        if (this.wisdomPoints > 0) {
            _loc1_.wisdomSkillsData.addWisdomPoints(this.wisdomPoints);
        }
        if (this.skillPoints > 0) {
            _loc1_.skillData.skillPoints = _loc1_.skillData.skillPoints + this.skillPoints;
        }
        if (this.artifactTypeIds != null) {
        }
        if (this.vipPoints > 0) {
            _loc1_.vipData.vipPoints = _loc1_.vipData.vipPoints + this.vipPoints;
        }
        if (this.blackMarketItems != null) {
            _loc2_ = _loc1_.blackMarketData.boughtItems;
            for (_loc3_ in this.blackMarketItems) {
                if (_loc2_.hasOwnProperty(_loc3_)) {
                    _loc2_[_loc3_].freeCount = _loc2_[_loc3_].freeCount + this.blackMarketItems[_loc3_];
                }
                else {
                    _loc2_[_loc3_] = new BlackMarketItemsNode();
                    _loc2_[_loc3_].freeCount = this.blackMarketItems[_loc3_];
                }
                _loc4_ = StaticDataManager.blackMarketData.itemsById[_loc3_];
                if (_loc4_ && _loc4_.packData) {
                    UserManager.user.gameData.blackMarketData.boughtCountByItemPackId[_loc4_.packData.packType] = UserManager.user.gameData.blackMarketData.boughtCountByItemPackId[_loc4_.packData.packType] + _loc4_.packData.itemCount;
                }
                else if (_loc4_ != null && _loc4_.temporarySkinData != null) {
                    this.giveTemporarySkinsToUser(_loc1_, [_loc4_.temporarySkinData]);
                }
            }
            _loc1_.blackMarketData.updateActivators();
        }
        if (this.allianceResources != null && AllianceManager.currentAlliance) {
            _loc5_ = AllianceManager.currentAlliance.gameData.cityData;
            if (_loc5_) {
                _loc5_.resources.cash = _loc5_.resources.cash + this.allianceResources.cash;
                _loc5_.resources.techPoints = _loc5_.resources.techPoints + this.allianceResources.techPoints;
            }
        }
        if (this.dragonResources != null) {
            _loc1_.dragonData.resources.add(this.dragonResources);
        }
        if (this.dragonPoints > 0) {
            _loc1_.dragonData.addDragonPoints(this.dragonPoints);
        }
        if (this.temporarySkins != null) {
            this.giveTemporarySkinsToUser(_loc1_, this.temporarySkins);
        }
        if (this.constructionWorkers > 0) {
            _loc6_ = StaticDataManager.constructionData.getMaxWorkersCount();
            if (_loc1_.constructionData.constructionWorkersCount < _loc6_) {
                _loc1_.constructionData.constructionWorkersCount = _loc1_.constructionData.constructionWorkersCount + this.constructionWorkers;
                _loc1_.constructionData.constructionWorkersChanged = true;
                _loc1_.constructionData.availableWorkersChanged = false;
                if (_loc1_.constructionData.constructionWorkersCount == _loc6_) {
                    _loc1_.constructionData.additionalWorkersExpireDateTimes = null;
                    _loc1_.constructionData.constructionAdditionalWorkersChanged = true;
                }
                _loc1_.updateObjectsBuyStatus(true);
                _loc1_.dispatchEvents();
            }
        }
        if (this.characters != null && this.characters.length > 0) {
            if (_loc1_.characterData == null) {
                _loc1_.characterData = new UserCharacterData();
            }
            _loc1_.characterData.allowedExtraCharacters = _loc1_.characterData.allowedExtraCharacters == null ? this.characters : _loc1_.characterData.allowedExtraCharacters.concat(this.characters);
        }
    }

    public function isEmpty():Boolean {
        return (this.artifactTypeIds == null || this.artifactTypeIds.length == 0) && (this.sectorSkins == null || this.sectorSkins.length == 0) && this.drawingPart == null && (this.troops == null || this.troops.capacity() == 0) && (this.resources == null || this.resources.capacity() < 4 || this.resources.isNegative()) && this.skillPoints == 0 && this.experience == 0 && this.wisdomPoints == 0 && this.blackMarketItems == null && this.constructionWorkers == 0 && this.vipPoints == 0 && this.robberyCount == 0 && (this.inventoryItems == null || this.inventoryItems.length == 0) && this.allianceResources == null && this.tacticsBonuses == null && this.temporarySkins == null && (this.characters == null || this.characters.length == 0);
    }

    private function giveTemporarySkinsToUser(param1:UserGameData, param2:Array):void {
        var _loc3_:TemporarySkin = null;
        if (param1.sectorSkinsData == null) {
            param1.sectorSkinsData = new UserSectorSkinData();
        }
        if (param1.sectorSkinsData.temporarySectorSkinData == null) {
            param1.sectorSkinsData.temporarySectorSkinData = new TemporarySectorSkinData();
        }
        for each(_loc3_ in param2) {
            param1.sectorSkinsData.temporarySectorSkinData.addSkinToUser(_loc3_);
        }
        param1.sectorSkinsData.dirty = true;
    }

    private function findAndPushSkinFromStaticData(param1:Array, param2:int):void {
        if (!this.hasBMI(param2)) {
            return;
        }
        var _loc3_:BlackMarketItemRaw = StaticDataManager.blackMarketData.itemsById[param2];
        if (_loc3_ == null) {
            throw new Error("Item with id=" + param2 + " is missing in static data");
        }
        param1.push(_loc3_.temporarySkinData);
    }

    public function get troopsKindId():int {
        var _loc2_:* = undefined;
        var _loc3_:GeoSceneObjectType = null;
        var _loc1_:UserPrize = this.clone();
        if (_loc1_.troops) {
            for (_loc2_ in _loc1_.troops.countByType) {
                _loc3_ = StaticDataManager.getObjectType(_loc2_) as GeoSceneObjectType;
            }
            return _loc3_.troopsInfo.kindId;
        }
        return -1;
    }

    public function get goldMoneyPrize():int {
        var _loc1_:int = 0;
        var _loc2_:Resources = this.resources;
        if (_loc2_ != null) {
            _loc1_ = _loc2_.goldMoney;
        }
        return _loc1_;
    }
}
}
