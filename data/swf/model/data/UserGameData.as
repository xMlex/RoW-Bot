package model.data {
import Events.EventWithTargetObject;

import common.ArrayCustom;
import common.GameType;
import common.queries.util.query;

import configs.Global;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.Dictionary;

import gameObjects.FormSectorUIManager;
import gameObjects.observableObject.ObservableObject;
import gameObjects.sceneObject.SceneObject;

import model.data.alliances.AllianceMemberRankId;
import model.data.blueLight.UserBlueLightData;
import model.data.clanPurchases.UserClanPurchaseData;
import model.data.clans.ClanInvitation;
import model.data.clans.ClanMember;
import model.data.clans.UserClanData;
import model.data.discountOffers.UserDiscountOfferData;
import model.data.effects.EffectData;
import model.data.giftPoints.UserGiftPointsProgramData;
import model.data.inventory.InventorySlotInfo;
import model.data.inventory.InventorySlotType;
import model.data.inventory.UserInventorySlot;
import model.data.lottery.UserLotteryData;
import model.data.map.MapPos;
import model.data.map.UserMapData;
import model.data.normalization.INConstructible;
import model.data.promotionOffers.UserPromotionOfferData;
import model.data.quests.QuestCategoryId;
import model.data.quests.QuestPrototypeId;
import model.data.ratings.epicBattles.UserEpicBattlesData;
import model.data.scenes.GeoScene;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.ArtifactTypeInfo;
import model.data.scenes.types.info.BuildingTypeId;
import model.data.scenes.types.info.DefensiveKind;
import model.data.scenes.types.info.RequiredObject;
import model.data.scenes.types.info.RequiredType;
import model.data.scenes.types.info.SaleableLevelInfo;
import model.data.scenes.types.info.SaleableTypeInfo;
import model.data.units.MapObjectTypeId;
import model.data.units.Unit;
import model.data.units.resurrection.UserResurrectionData;
import model.data.users.BuyStatus;
import model.data.users.UserAccount;
import model.data.users.UserBuyingData;
import model.data.users.UserCommonData;
import model.data.users.UserUIData;
import model.data.users.UserVipSupportData;
import model.data.users.UserWorldData;
import model.data.users.acceleration.ConstructionData;
import model.data.users.alliances.UserAllianceData;
import model.data.users.alliances.UserAllianceInvitation;
import model.data.users.alliances.UserAllianceRequest;
import model.data.users.artifacts.UserArtifactData;
import model.data.users.buildings.Sector;
import model.data.users.drawings.DrawingArchive;
import model.data.users.globalmessages.GlobalMessageUserData;
import model.data.users.messages.Message;
import model.data.users.messages.UserMessageData;
import model.data.users.misc.FavouriteUser;
import model.data.users.misc.KnownUsersData;
import model.data.users.misc.NotificationData;
import model.data.users.misc.UserBlackMarketData;
import model.data.users.misc.UserChatSettings;
import model.data.users.misc.UserCyborgData;
import model.data.users.misc.UserGameSettings;
import model.data.users.misc.UserSectorSkinData;
import model.data.users.misc.UserTreasureData;
import model.data.users.raids.RaidLocationStoryType;
import model.data.users.raids.RaidLocationStoryTypeStep;
import model.data.users.raids.UserRaidData;
import model.data.users.technologies.TechnologyCenter;
import model.data.users.trading.TradingCenter;
import model.data.users.troops.BattleSupporter;
import model.data.users.troops.TroopsFactory;
import model.data.users.troops.TroopsOrder;
import model.data.users.troops.UserTroopsData;
import model.data.users.troops.UserTroopsNormalizable;
import model.data.wisdomSkills.UserWisdomSkill;
import model.data.wisdomSkills.UserWisdomSkillsData;
import model.data.wisdomSkills.WisdomSkill;
import model.logic.AllianceManager;
import model.logic.ArtifactManager;
import model.logic.BuildingManager;
import model.logic.LocationNoteManager;
import model.logic.MessageManager;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.alliance.UserAllianceNormalizable;
import model.logic.character.UserCharacterData;
import model.logic.commands.sector.RepairBuildingsCmd;
import model.logic.commands.user.GetRaidLocationStoryTypeStepCmd;
import model.logic.filterSystem.ArrayChangesChecker;
import model.logic.gems.UserGemData;
import model.logic.inventory.InventoryManager;
import model.logic.inventory.InventoryNormalizable;
import model.logic.inventory.UserInventoryData;
import model.logic.loyalty.UserLoyaltyProgramData;
import model.logic.occupation.data.UserOccupationData;
import model.logic.occupation.data.UserOccupationInfo;
import model.logic.occupation.normalization.OccupationNormalizable;
import model.logic.quests.completions.QuestCompletion;
import model.logic.quests.completions.QuestCompletionPeriodic;
import model.logic.quests.completions.QuestCompletionRaidLocation;
import model.logic.quests.data.Quest;
import model.logic.quests.data.QuestState;
import model.logic.quests.data.UserQuestData;
import model.logic.resourcesConversion.data.UserResourcesConversionData;
import model.logic.resourcesConversion.normalization.ResourcesConversionNormalizable;
import model.logic.sessionChest.SessionChestData;
import model.logic.skills.SkillManager;
import model.logic.skills.data.Skill;
import model.logic.skills.data.UserSkillData;
import model.logic.skills.normalization.SkillNormalizable;
import model.logic.units.UnitUtility;
import model.logic.vip.UserVipData;
import model.logic.vip.VipNormalizable;
import model.modules.allianceCity.logic.UserAllianceCityNormalizable;
import model.modules.allianceHelp.normalization.UserAllianceHelpNormalizable;
import model.modules.dragonAbilities.data.Ability;
import model.modules.dragonAbilities.logic.UserDragonData;
import model.modules.dragonAbilities.normalization.UserAbilitiesDataNormalizable;

public class UserGameData extends ObservableObject {

    public static const CLASS_NAME:String = "UserGameData";

    public static const ACCOUNT_CHANGED:String = CLASS_NAME + "AccountChanged";

    public static const GLOBAL_DATA_CHANGED:String = CLASS_NAME + "GlobalDataChanged";

    public static const CARAVAN_LIMITS_CHANGED:String = CLASS_NAME + "CaravanLimitsChanged";

    public static const SECTOR_SKIN_DATA_CHANGED:String = CLASS_NAME + "SectorSkinDataChanged";

    public static const MAP_POS_CHANGED:String = CLASS_NAME + "MapPosChanged";

    public static const MAP_STATE_CHANGED:String = CLASS_NAME + "MapStateChanged";

    public static const SESSION_CHEST_CHANGED:String = CLASS_NAME + "SessionChestChanged";

    private static const DEFAULT_PRICE:int = 5;


    public var revision:Number;

    public var normalizationTime:Date;

    public var account:UserAccount;

    public var mapPos:MapPos;

    public var mapStateId:int;

    public var changingToMapPos:MapPos;

    public var mapData:UserMapData;

    public var userGameSettings:UserGameSettings;

    public var userChatSettings:UserChatSettings;

    public var notificationData:NotificationData;

    public var settingsDirty:Boolean;

    public var settingsChatDirty:Boolean;

    public var settingsVipDirty:Boolean;

    public var settingsMessagesDirty:Boolean;

    public var commonData:UserCommonData;

    public var clanData:UserClanData;

    public var messageData:UserMessageData;

    public var sector:Sector;

    public var troopsData:UserTroopsData;

    public var resurrectionData:UserResurrectionData;

    public var tradingCenter:TradingCenter;

    public var technologyCenter:TechnologyCenter;

    public var drawingArchive:DrawingArchive;

    public var worldData:UserWorldData;

    private var _constructionData:ConstructionData;

    public var knownUsersData:KnownUsersData;

    public var treasureData:UserTreasureData;

    public var statsData:UserStatsData;

    public var sectorSkinsData:UserSectorSkinData;

    public var cyborgData:UserCyborgData;

    public var artifactData:UserArtifactData;

    public var allianceData:UserAllianceData;

    public var questData:UserQuestData;

    public var blackMarketData:UserBlackMarketData;

    public var raidData:UserRaidData;

    public var skillData:UserSkillData;

    public var dragonData:UserDragonData;

    public var globalMessageData:GlobalMessageUserData;

    public var resourcesConversionData:UserResourcesConversionData;

    public var occupationData:UserOccupationData;

    public var gemData:UserGemData;

    public var vipData:UserVipData;

    public var discountOfferData:UserDiscountOfferData;

    public var loyaltyData:UserLoyaltyProgramData;

    public var inventoryData:UserInventoryData;

    public var characterData:UserCharacterData;

    public var sessionChestData:SessionChestData;

    public var effectData:EffectData;

    public var uiData:UserUIData;

    public var promotionOfferData:UserPromotionOfferData;

    public var epicBattlesData:UserEpicBattlesData;

    public var lotteryData:UserLotteryData;

    public var wisdomSkillsData:UserWisdomSkillsData;

    public var giftPointsProgramData:UserGiftPointsProgramData;

    public var clanPurchaseData:UserClanPurchaseData;

    public var resourcesUraniumCount:int = 5;

    public var resourcesTitaniumCount:int = 5;

    public var invitationData:UserInvitationData;

    public var vipSupportData:UserVipSupportData;

    public var blueLightData:UserBlueLightData;

    public var buyingData:UserBuyingData;

    private var buyStatusBySceneObject:Dictionary;

    private var currentGameData:UserGameData;

    public function UserGameData() {
        this.buyingData = new UserBuyingData();
        this.buyStatusBySceneObject = new Dictionary();
        super();
    }

    public static function getKnownUserIds(param1:User):Array {
        return param1.gameData.getKnownUserIdsImpl(param1.id);
    }

    public static function getKnownAllianceIds(param1:User):Array {
        return param1.gameData.getKnownAllianceIdsImpl();
    }

    public static function getKnownLocationIds(param1:User):Array {
        return param1.gameData.getKnownLocationIdsImpl();
    }

    public static function addLocationId(param1:Array, param2:Number):void {
        if (param2 < 0) {
            param1.push(-param2);
        }
    }

    public static function fromDto(param1:*, param2:Boolean = false):UserGameData {
        var _loc3_:UserGameData = new UserGameData();
        _loc3_.revision = param1.r;
        _loc3_.normalizationTime = new Date(param1.t);
        _loc3_.account = UserAccount.fromDto(param1.a);
        _loc3_.mapPos = MapPos.fromDto(param1.map);
        _loc3_.mapStateId = param1.ms == null ? 0 : int(param1.ms);
        _loc3_.changingToMapPos = MapPos.fromDto(param1.map2);
        _loc3_.mapData = param1.ud == null ? new UserMapData() : UserMapData.fromDto(param1.ud);
        _loc3_.commonData = UserCommonData.fromDto(param1.cd);
        _loc3_.clanData = UserClanData.fromDto(param1.ld);
        _loc3_.messageData = UserMessageData.fromDto(param1.md);
        _loc3_.sector = Sector.fromDto(param1.sd, param2);
        _loc3_.troopsData = UserTroopsData.fromDto(param1.td);
        _loc3_.resurrectionData = UserResurrectionData.fromDto(param1.rsd);
        _loc3_.tradingCenter = TradingCenter.fromDto(param1.rd);
        _loc3_.technologyCenter = TechnologyCenter.fromDto(param1.hd);
        _loc3_.drawingArchive = DrawingArchive.fromDto(param1.dd);
        _loc3_.worldData = UserWorldData.fromDto(param1.wd);
        _loc3_._constructionData = ConstructionData.fromDto(param1.ad);
        _loc3_.userGameSettings = UserGameSettings.fromDto(param1.s);
        _loc3_.userChatSettings = param1.z == null ? new UserChatSettings() : UserChatSettings.fromDto(param1.z);
        _loc3_.notificationData = !!param1.p ? NotificationData.fromDto(param1.p) : null;
        _loc3_.knownUsersData = KnownUsersData.fromDto(param1.ku);
        _loc3_.treasureData = param1.bd == null ? null : UserTreasureData.fromDto(param1.bd);
        _loc3_.statsData = param1.pd == null ? null : UserStatsData.fromDto(param1.pd);
        _loc3_.sectorSkinsData = param1.sk == null ? null : UserSectorSkinData.fromDto(param1.sk);
        _loc3_.cyborgData = param1.xd == null ? null : UserCyborgData.fromDto(param1.xd);
        _loc3_.artifactData = param1.ad2 == null ? new UserArtifactData() : UserArtifactData.fromDto(param1.ad2);
        _loc3_.allianceData = param1.aa == null ? new UserAllianceData() : UserAllianceData.fromDto(param1.aa);
        _loc3_.questData = UserQuestData.fromDto(param1.qd);
        _loc3_.blackMarketData = param1.bm == null ? new UserBlackMarketData() : UserBlackMarketData.fromDto(param1.bm);
        _loc3_.raidData = param1.ra == null ? new UserRaidData() : UserRaidData.fromDto(param1.ra);
        _loc3_.skillData = param1.sa == null ? new UserSkillData() : UserSkillData.fromDto(param1.sa);
        _loc3_.dragonData = param1.dr == null ? null : UserDragonData.fromDto(param1.dr);
        _loc3_.resourcesConversionData = param1.bc == null ? new UserResourcesConversionData() : UserResourcesConversionData.fromDto(param1.bc);
        _loc3_.globalMessageData = param1.gm == null ? new GlobalMessageUserData() : GlobalMessageUserData.fromDto(param1.gm);
        _loc3_.occupationData = param1.od == null ? new UserOccupationData() : UserOccupationData.fromDto(param1.od);
        _loc3_.gemData = param1.ed == null ? new UserGemData() : UserGemData.fromDto(param1.ed);
        _loc3_.vipData = param1.vd == null ? new UserVipData() : UserVipData.fromDto(param1.vd);
        _loc3_.discountOfferData = param1.da == null ? null : UserDiscountOfferData.fromDto(param1.da);
        _loc3_.loyaltyData = param1.lp == null ? new UserLoyaltyProgramData() : UserLoyaltyProgramData.fromDto(param1.lp);
        _loc3_.inventoryData = UserInventoryData.fromDto(param1.vn);
        _loc3_.characterData = UserCharacterData.fromDto(param1.ap);
        _loc3_.sessionChestData = SessionChestData.fromDto(param1.ch);
        _loc3_.effectData = EffectData.fromDto(param1.ef);
        _loc3_.uiData = !!param1.uu ? UserUIData.fromDto(param1.uu) : new UserUIData();
        _loc3_.epicBattlesData = UserEpicBattlesData.fromDto(param1.eb);
        _loc3_.wisdomSkillsData = UserWisdomSkillsData.fromDto(param1.ws);
        _loc3_.giftPointsProgramData = UserGiftPointsProgramData.fromDto(param1.g);
        _loc3_.clanPurchaseData = UserClanPurchaseData.fromDto(param1.cp);
        _loc3_.invitationData = param1.id == null ? new UserInvitationData() : UserInvitationData.fromDto(param1.id);
        _loc3_.vipSupportData = param1.vs == null ? new UserVipSupportData() : UserVipSupportData.fromDto(param1.vs);
        _loc3_.blueLightData = param1.bl == null ? new UserBlueLightData() : UserBlueLightData.fromDto(param1.bl);
        _loc3_.recalcData();
        _loc3_._constructionData.initAcceleration(_loc3_);
        _loc3_.lotteryData = param1.lt == null ? new UserLotteryData() : UserLotteryData.fromDto(param1.lt);
        _loc3_.promotionOfferData = param1.po == null ? new UserPromotionOfferData() : UserPromotionOfferData.fromDto(param1.po);
        return _loc3_;
    }

    public static function fromVisitUserDto(param1:*):UserGameData {
        var _loc2_:UserGameData = new UserGameData();
        _loc2_.revision = param1.r;
        _loc2_.normalizationTime = new Date(param1.t);
        _loc2_.account = UserAccount.fromDto(param1.a);
        _loc2_.mapPos = MapPos.fromDto(param1.map);
        _loc2_.commonData = new UserCommonData();
        _loc2_.clanData = new UserClanData();
        _loc2_.messageData = new UserMessageData();
        _loc2_.sector = Sector.fromDto(param1.sd);
        _loc2_.troopsData = new UserTroopsData();
        _loc2_.tradingCenter = new TradingCenter();
        _loc2_.technologyCenter = new TechnologyCenter();
        _loc2_.drawingArchive = new DrawingArchive();
        if (param1.dd) {
            _loc2_.drawingArchive.addedDrawingPartsForClicks = new ArrayCustom(param1.dd.a);
        }
        _loc2_.worldData = new UserWorldData();
        _loc2_.worldData.units = param1.wd == null || param1.wd.u == null ? null : Unit.fromDtos(param1.wd.u);
        _loc2_._constructionData = new ConstructionData();
        _loc2_.userGameSettings = new UserGameSettings();
        _loc2_.userChatSettings = new UserChatSettings();
        _loc2_.knownUsersData = new KnownUsersData();
        _loc2_.treasureData = null;
        _loc2_.artifactData = new UserArtifactData();
        _loc2_.inventoryData = UserInventoryData.fromDto(param1.vn);
        _loc2_.wisdomSkillsData = UserWisdomSkillsData.fromDto(param1.ws);
        _loc2_.recalcData();
        _loc2_._constructionData.initAcceleration(_loc2_);
        _loc2_.resourcesUraniumCount = 0;
        _loc2_.resourcesTitaniumCount = 0;
        return _loc2_;
    }

    public static function fromDemoUserDto(param1:*):UserGameData {
        var _loc2_:UserGameData = new UserGameData();
        _loc2_.revision = param1.r;
        _loc2_.normalizationTime = new Date(param1.t);
        _loc2_.account = UserAccount.fromDto(param1.a);
        if (StaticDataManager.levelData != null) {
            _loc2_.account.level = StaticDataManager.levelData.pointsForLevel.length;
            _loc2_.account.experience = StaticDataManager.levelData.pointsForLevel[_loc2_.account.level - 1];
        }
        _loc2_.commonData = UserCommonData.fromDto(param1.cd);
        _loc2_.clanData = UserClanData.fromDto(param1.ld);
        _loc2_.messageData = UserMessageData.fromDto(param1.md);
        _loc2_.sector = Sector.fromDto(param1.sd);
        _loc2_.troopsData = UserTroopsData.fromDto(param1.td);
        _loc2_.tradingCenter = TradingCenter.fromDto(param1.rd);
        _loc2_.technologyCenter = TechnologyCenter.fromDto(param1.hd);
        _loc2_.drawingArchive = DrawingArchive.fromDto(param1.dd);
        _loc2_.worldData = UserWorldData.fromDto(param1.wd);
        _loc2_._constructionData = ConstructionData.fromDto(param1.ad);
        _loc2_.artifactData = new UserArtifactData();
        _loc2_.skillData = new UserSkillData();
        _loc2_.skillData.skills = new ArrayCustom();
        _loc2_.mapPos = new MapPos();
        _loc2_.recalcData();
        _loc2_._constructionData.initAcceleration(_loc2_);
        return _loc2_;
    }

    private static function getMockPromotionOfferDataDto():Object {
        return {
            "n": 71,
            "e": [{
                "i": 70,
                "t": 2,
                "j": -62135596800000,
                "g": 1493973970051,
                "v": 2493981170051,
                "p": {
                    "p": {
                        "i": 0,
                        "e": 0,
                        "s": 0,
                        "v": 0,
                        "b": {
                            "11740": 1,
                            "1702": 20
                        },
                        "c": 0,
                        "w": 0,
                        "m": 1,
                        ".he": 0,
                        "wp": 0,
                        "lu": 0,
                        "un": 0,
                        "ux": 0,
                        "bz": 0,
                        "bn": 0,
                        "bs": 0,
                        ".s": 0,
                        ".m": 0,
                        "po": {}
                    },
                    "s": {
                        "i": 0,
                        "e": 0,
                        "s": 0,
                        "v": 0,
                        "b": {
                            "200": 1,
                            "201": 1,
                            "202": 1,
                            "203": 1,
                            "204": 1,
                            "205": 1,
                            "250": 1,
                            "251": 1,
                            "11740": 3,
                            "1702": 40
                        },
                        "c": 0,
                        "w": 0,
                        "m": 1,
                        ".he": 0,
                        "wp": 0,
                        "lu": 0,
                        "un": 0,
                        "ux": 0,
                        "bz": 0,
                        "bn": 0,
                        "bs": 0,
                        ".s": 0,
                        ".m": 0,
                        "po": {
                            "bio": {
                                "200": 8,
                                "201": 7,
                                "202": 6,
                                "203": 5,
                                "204": 4,
                                "205": 1,
                                "250": 2,
                                "251": 3
                            }
                        }
                    }
                },
                "s": 5,
                "n": 0,
                "e": "101797a6-5145-422a-ae3e-3cb9e62e1b53",
                "h": 1352,
                "y": 409,
                "d": 1589,
                "si": 199,
                "u": 1,
                "b": 0,
                "z": 1,
                "q": {
                    "r": 17,
                    "g": 19,
                    "s": 199,
                    "a": 1,
                    "o": 0,
                    "ss": 1,
                    "or": 1
                },
                "isj": "{\"l\":6,\"t\":1,\"c\":2,\"i\":124}",
                "gp": 0,
                "bp": 0
            }],
            "c": {"5": [1, 1, 1]},
            "b": {
                "r": 17,
                "d": {
                    "g": 19,
                    "s": 199,
                    "a": 1
                },
                "i": 0
            }
        };
    }

    public function getConstructionSeconds(param1:INConstructible):Number {
        return this._constructionData.getConstructionTicks(param1) / 1000;
    }

    public function getConstructionSecondsWithoutEffects(param1:INConstructible):Number {
        return this._constructionData.getConstructionTicksWithoutEffects(param1) / 1000;
    }

    public function getConstructionTicksWithoutBonuses(param1:INConstructible):Number {
        return this._constructionData.getConstructionTicksWithoutBonuses(param1);
    }

    public function mapPosInitialized():Boolean {
        return this.mapPos != null;
    }

    public function canShowSaleWisdomSkill():Boolean {
        var w:UserWisdomSkill = null;
        var lastSkillId:int = 0;
        var lastWisdomSkill:WisdomSkill = null;
        var wisdomSkill:WisdomSkill = null;
        var secondItemIsActive:Boolean = true;
        for each(w in this.wisdomSkillsData.activeSkills) {
            wisdomSkill = StaticDataManager.wisdomSkillsData.getWisdomSkillById(w.id);
            if (wisdomSkill.hasDependedSkill) {
                secondItemIsActive = query(this.wisdomSkillsData.activeSkills).any(function (param1:UserWisdomSkill):Boolean {
                    return param1.id == wisdomSkill.dependedSkillId;
                });
            }
            if (!secondItemIsActive) {
                break;
            }
        }
        lastSkillId = this.wisdomSkillsData.lastSkillId;
        lastWisdomSkill = lastSkillId == -1 ? null : StaticDataManager.wisdomSkillsData.getWisdomSkillById(lastSkillId);
        var maxUserLevel:int = lastWisdomSkill == null ? 0 : int(lastWisdomSkill.parentLevel.level);
        var haveLastItemsForBuying:Boolean = maxUserLevel >= this.wisdomSkillsData.currentWisdomLevel;
        return this.wisdomSkillsData.currentWisdomLevel != 0 && (haveLastItemsForBuying || !secondItemIsActive);
    }

    public function getNormalizableList():Array {
        var _loc1_:Array = [];
        _loc1_.push(this.sector);
        _loc1_.push(this.technologyCenter);
        _loc1_.push(this.troopsData.troopsFactory);
        _loc1_.push(this.worldData);
        _loc1_.push(this._constructionData);
        _loc1_.push(this.commonData);
        _loc1_.push(this.artifactData);
        _loc1_.push(this.effectData);
        _loc1_.push(this.lotteryData);
        _loc1_.push(this.blackMarketData);
        _loc1_.push(SkillNormalizable.instance);
        _loc1_.push(ResourcesConversionNormalizable.instance);
        _loc1_.push(OccupationNormalizable.instance);
        _loc1_.push(VipNormalizable.instance);
        _loc1_.push(InventoryNormalizable.instance);
        _loc1_.push(UserAllianceNormalizable.instance);
        _loc1_.push(UserAllianceCityNormalizable.instance);
        _loc1_.push(UserAbilitiesDataNormalizable.instance);
        _loc1_.push(UserAllianceHelpNormalizable.instance);
        _loc1_.push(UserTroopsNormalizable.instance);
        _loc1_.push(this.giftPointsProgramData);
        return _loc1_;
    }

    public function dispatchEvents():void {
        dispatchEvent(ACCOUNT_CHANGED);
        this.mapData.dispatchEvents();
        this._constructionData.dispatchEvents();
        this.sector.dispatchEvents();
        this.technologyCenter.dispatchEvents();
        this.buyingData.dispatchEvents();
        this.tradingCenter.dispatchEvents();
        this.clanData.dispatchEvents();
        this.statsData.dispatchEvents();
        this.messageData.dispatchEvents();
        this.troopsData.dispatchEvents();
        this.resurrectionData.dispatchEvents();
        this.worldData.dispatchEvents();
        this.knownUsersData.dispatchEvents();
        this.commonData.dispatchEvents();
        this.artifactData.dispatchEvents();
        this.allianceData.dispatchEvents();
        this.questData.dispatchEvents();
        this.blackMarketData.dispatchEvents();
        this.raidData.dispatchEvents();
        this.skillData.dispatchEvents();
        this.resourcesConversionData.dispatchEvents();
        this.occupationData.dispatchEvents();
        this.effectData.dispatchEvents();
        this.epicBattlesData.dispatchEvents();
        this.loyaltyData.dispatchEvents();
        this.promotionOfferData.dispatchEvents();
        this.wisdomSkillsData.dispatchEvents();
        this.giftPointsProgramData.dispatchEvents();
        this.clanPurchaseData.dispatchEvents();
        if (this.dragonData != null) {
            this.dragonData.dispatchEvents();
        }
        if (this.treasureData != null) {
            this.treasureData.dispatchEvents();
        }
        if (this.cyborgData != null) {
            this.cyborgData.dispatchEvents();
        }
        if (this.sessionChestData != null) {
            this.sessionChestData.dispatchEvents();
        }
        this.drawingArchive.dispatchEvents();
        if (this.gemData != null) {
            this.gemData.dispatchEvents();
        }
        if (this.invitationData != null) {
            this.invitationData.dispatchEvents();
        }
        if (this.inventoryData != null) {
            this.inventoryData.dispatchEvents();
        }
        if (this.userChatSettings != null) {
            this.userChatSettings.dispatchEvents();
        }
        if (this.characterData != null) {
            this.characterData.dispatchEvents();
        }
        if (this.vipSupportData != null) {
            this.vipSupportData.dispatchEvents();
        }
        if (this.vipData != null) {
            this.vipData.dispatchEvents();
        }
        if (this.sectorSkinsData != null) {
            this.sectorSkinsData.dispatchEvents();
        }
        this.blueLightData.dispatchEvents();
        this.lotteryData.dispatchEvents();
    }

    public function recalcData():void {
        this.sector.recalcBuildings();
        this.technologyCenter.recalcTechnologies();
        this.recalcGlobalStats();
    }

    public function recalcGlobalStats():void {
        dispatchEvent(GLOBAL_DATA_CHANGED);
    }

    private function getKnownUserIdsImpl(param1:Number):Array {
        var _loc3_:Number = NaN;
        var _loc4_:ClanMember = null;
        var _loc5_:ClanInvitation = null;
        var _loc6_:Unit = null;
        var _loc8_:Message = null;
        var _loc9_:BattleSupporter = null;
        var _loc10_:* = undefined;
        var _loc11_:Array = null;
        var _loc12_:* = undefined;
        var _loc13_:FavouriteUser = null;
        var _loc14_:UserOccupationInfo = null;
        var _loc15_:Boolean = false;
        var _loc16_:Number = NaN;
        var _loc2_:Array = new Array();
        if (this.drawingArchive.clicksForUserIds) {
            for each(_loc3_ in this.drawingArchive.clicksForUserIds) {
                _loc2_.push(_loc3_);
            }
        }
        if (this.drawingArchive.clicksFromUserIds) {
            for each(_loc3_ in this.drawingArchive.clicksFromUserIds) {
                _loc2_.push(_loc3_);
            }
        }
        for each(_loc4_ in this.clanData.members) {
            _loc2_.push(_loc4_.userId);
        }
        for each(_loc5_ in this.clanData.invitations) {
            _loc2_.push(_loc5_.inviterUserId);
        }
        for each(_loc3_ in this.knownUsersData.mateUserIds) {
            _loc2_.push(_loc3_);
        }
        for each(_loc3_ in this.knownUsersData.enemyUserIds) {
            _loc2_.push(_loc3_);
        }
        for each(_loc3_ in this.knownUsersData.allianceEnemyUserIds) {
            _loc2_.push(_loc3_);
        }
        if (this.messageData.blackList != null) {
            for each(_loc3_ in this.messageData.blackList) {
                _loc2_.push(_loc3_);
            }
        }
        if (!Global.EXTERNAL_MASSAGES_ENABLED) {
            for each(_loc8_ in this.messageData.messages) {
                if (!isNaN(_loc8_.userIdFrom)) {
                    _loc2_.push(_loc8_.userIdFrom);
                }
                if (!isNaN(_loc8_.userIdTo)) {
                    _loc2_.push(_loc8_.userIdTo);
                }
                if (_loc8_.battleResult != null) {
                    _loc2_.push(_loc8_.battleResult.attackerUserId);
                    _loc2_.push(_loc8_.battleResult.defenderUserId);
                    _loc2_.push(_loc8_.battleResult.sectorUserId);
                    if (_loc8_.battleResult.supporters != null) {
                        for each(_loc9_ in _loc8_.battleResult.supporters) {
                            _loc2_.push(_loc9_.userId);
                        }
                    }
                }
                if (_loc8_.ratingWinners != null) {
                    for (_loc10_ in _loc8_.ratingWinners.tops) {
                        _loc11_ = _loc8_.ratingWinners.tops[_loc10_];
                        for each(_loc12_ in _loc11_) {
                            _loc2_.push(_loc12_.u);
                        }
                    }
                }
                if (_loc8_.changedUserId > -1) {
                    _loc2_.push(_loc8_.changedUserId);
                }
            }
        }
        for each(_loc6_ in this.worldData.units) {
            _loc2_.push(_loc6_.OwnerUserId);
            if (_loc6_.TargetTypeId == MapObjectTypeId.USER_OR_LOCATION) {
                _loc2_.push(_loc6_.TargetUserId);
            }
        }
        if (this.knownUsersData != null && this.knownUsersData.favouriteUsers != null) {
            for each(_loc13_ in this.knownUsersData.favouriteUsers) {
                _loc2_.push(_loc13_.userId);
            }
        }
        if (Global.serverSettings.occupation.enabled && this.occupationData != null) {
            if (this.occupationData.ownOccupationInfo != null) {
                _loc2_.push(this.occupationData.ownOccupationInfo.userId);
            }
            for each(_loc14_ in this.occupationData.userOccupationInfos) {
                _loc2_.push(_loc14_.userId);
            }
        }
        var _loc7_:Array = new Array();
        for each(_loc3_ in _loc2_) {
            if (_loc3_ != param1) {
                _loc15_ = false;
                for each(_loc16_ in _loc7_) {
                    if (_loc16_ == _loc3_) {
                        _loc15_ = true;
                        break;
                    }
                }
                if (!_loc15_) {
                    _loc7_.push(_loc3_);
                }
            }
        }
        _loc2_ = _loc7_;
        return _loc2_;
    }

    public function getKnownAllianceIdsImpl():Array {
        var _loc2_:UserAllianceInvitation = null;
        var _loc3_:UserAllianceRequest = null;
        var _loc5_:Number = NaN;
        var _loc6_:Message = null;
        var _loc7_:Boolean = false;
        var _loc8_:Number = NaN;
        var _loc1_:Array = new Array();
        if (this.allianceData == null) {
            return _loc1_;
        }
        if (!isNaN(this.allianceData.allianceId)) {
            _loc1_.push(this.allianceData.allianceId);
        }
        for each(_loc2_ in this.allianceData.invitations) {
            _loc1_.push(_loc2_.allianceId);
        }
        for each(_loc3_ in this.allianceData.requests) {
            _loc1_.push(_loc3_.allianceId);
        }
        if (!Global.EXTERNAL_MASSAGES_ENABLED) {
            for each(_loc6_ in this.messageData.messages) {
                if (!isNaN(_loc6_.allianceId) && _loc6_.allianceId != 0) {
                    _loc1_.push(_loc6_.allianceId);
                }
                if (_loc6_.battleResult) {
                    if (!isNaN(_loc6_.battleResult.attackerAllianceId)) {
                        _loc1_.push(_loc6_.battleResult.attackerAllianceId);
                    }
                    if (!isNaN(_loc6_.battleResult.defenderAllianceId)) {
                        _loc1_.push(_loc6_.battleResult.defenderAllianceId);
                    }
                }
            }
        }
        var _loc4_:Array = new Array();
        for each(_loc5_ in _loc1_) {
            _loc7_ = false;
            for each(_loc8_ in _loc4_) {
                if (_loc8_ == _loc5_) {
                    _loc7_ = true;
                    break;
                }
            }
            if (!_loc7_) {
                _loc4_.push(_loc5_);
            }
        }
        _loc1_ = _loc4_;
        return _loc1_;
    }

    public function getKnownLocationIdsImpl():Array {
        var _loc2_:Unit = null;
        var _loc3_:Message = null;
        var _loc1_:Array = new Array();
        if (!Global.EXTERNAL_MASSAGES_ENABLED) {
            for each(_loc3_ in this.messageData.messages) {
                if (!isNaN(_loc3_.refUserId)) {
                    addLocationId(_loc1_, _loc3_.refUserId);
                }
                if (!isNaN(_loc3_.userIdFrom)) {
                    addLocationId(_loc1_, _loc3_.userIdFrom);
                }
                if (!isNaN(_loc3_.userIdTo)) {
                    addLocationId(_loc1_, _loc3_.userIdTo);
                }
                if (_loc3_.battleResult != null) {
                    addLocationId(_loc1_, _loc3_.battleResult.sectorUserId);
                    addLocationId(_loc1_, _loc3_.battleResult.attackerUserId);
                    addLocationId(_loc1_, _loc3_.battleResult.defenderUserId);
                }
            }
        }
        for each(_loc2_ in this.worldData.units) {
            addLocationId(_loc1_, _loc2_.OwnerUserId);
            addLocationId(_loc1_, _loc2_.TargetUserId);
        }
        return _loc1_;
    }

    private function updateGemData(param1:UserGameData):void {
        if (param1.gemData == null) {
            return;
        }
        this.gemData.nextObjectId = param1.gemData.nextObjectId;
        this.gemData.gems = param1.gemData.gems;
        this.gemData.activeGems = param1.gemData.activeGems;
        this.gemData.dirty = true;
    }

    private function updateDiscountOfferData(param1:UserGameData):void {
        if (param1.discountOfferData == null) {
            return;
        }
        if (!this.discountOfferData) {
            this.discountOfferData = new UserDiscountOfferData();
        }
        this.discountOfferData.lastDiscountOpenTime = param1.discountOfferData.lastDiscountOpenTime;
        this.discountOfferData.openingBonus = param1.discountOfferData.openingBonus;
        this.discountOfferData.activeDiscountOffers = param1.discountOfferData.activeDiscountOffers;
        this.discountOfferData.dirty = true;
    }

    private function updateVipData(param1:UserGameData):void {
        var _loc2_:Boolean = this.vipData && param1.vipData.vipLevel > this.vipData.vipLevel;
        var _loc3_:EventDispatcher = this.vipData.events;
        var _loc4_:Boolean = this.vipData && this.vipData.activeState != param1.vipData.activeState;
        this.vipData = param1.vipData;
        this.vipData.events = _loc3_;
        this.vipData.dirtyVipLevel = _loc2_;
        this.vipData.dirtyVipState = _loc4_;
        this.blackMarketData.dirty = true;
    }

    private function updateInvitationData(param1:UserGameData):void {
        if (param1.invitationData == null) {
            return;
        }
        this.invitationData.sentInvitations = param1.invitationData.sentInvitations;
        this.invitationData.acceptedInvitations = param1.invitationData.acceptedInvitations;
        this.invitationData.reachedLevelInvitations = param1.invitationData.reachedLevelInvitations;
        this.invitationData.constructionBlockCount = param1.invitationData.constructionBlockCount;
        this.invitationData.dirty = true;
    }

    private function updateLoyaltyData(param1:UserGameData):void {
        if (param1.loyaltyData == null) {
            return;
        }
        var _loc2_:UserLoyaltyProgramData = param1.loyaltyData;
        this.loyaltyData.viewedLoyalityData = _loc2_.viewedLoyalityData;
        if (this.loyaltyData.currentDay != _loc2_.currentDay) {
            this.loyaltyData.currentDay = _loc2_.currentDay;
            this.loyaltyData.dirty = true;
        }
    }

    private function updateInventoryData(param1:UserGameData):void {
        var _loc2_:Vector.<GeoSceneObject> = null;
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:Dictionary = null;
        var _loc6_:InventorySlotInfo = null;
        var _loc7_:* = undefined;
        var _loc8_:GeoSceneObject = null;
        var _loc9_:int = 0;
        var _loc10_:int = 0;
        var _loc11_:Vector.<InventorySlotInfo> = null;
        var _loc12_:UserInventorySlot = null;
        var _loc13_:int = 0;
        if (param1.inventoryData) {
            if (!this.inventoryData) {
                this.inventoryData = new UserInventoryData();
            }
            if (InventoryManager.haveChangesInInventory) {
                _loc2_ = new Vector.<GeoSceneObject>();
                _loc5_ = new Dictionary();
                for (_loc7_ in param1.inventoryData.inventoryItemsById) {
                    if (this.inventoryData.inventoryItemsById[_loc7_]) {
                        _loc3_ = this.inventoryData.inventoryItemsById[_loc7_].inventoryItemInfo.slotId;
                        _loc4_ = param1.inventoryData.inventoryItemsById[_loc7_].inventoryItemInfo.slotId;
                        if (_loc3_ != _loc4_) {
                            param1.inventoryData.inventoryItemsById[_loc7_].inventoryItemInfo.slotId = _loc3_;
                        }
                        _loc5_[_loc3_] = param1.inventoryData.inventoryItemsById[_loc7_];
                    }
                    else {
                        _loc8_ = param1.inventoryData.inventoryItemsById[_loc7_];
                        _loc9_ = _loc8_.inventoryItemInfo.slotId;
                        _loc6_ = StaticDataManager.InventoryData.inventorySlotsById[_loc9_];
                        if (_loc6_.inventorySlotKind != InventorySlotType.TEMPORARY_STORAGE) {
                            _loc2_.push(param1.inventoryData.inventoryItemsById[_loc7_]);
                        }
                    }
                }
                if (_loc2_.length > 0) {
                    _loc10_ = 0;
                    while (_loc10_ < _loc2_.length) {
                        _loc11_ = StaticDataManager.InventoryData.inventorySlotInfos_inventory;
                        _loc13_ = 0;
                        while (_loc13_ < _loc11_.length) {
                            _loc12_ = param1.inventoryData.inventorySlotsById[_loc11_[_loc13_].id];
                            if (!_loc12_.locked) {
                                _loc6_ = StaticDataManager.InventoryData.inventorySlotsById[_loc12_.id];
                                if (!(_loc6_.inventorySlotKind == InventorySlotType.ACTIVE || _loc6_.inventorySlotKind == InventorySlotType.TEMPORARY_STORAGE)) {
                                    if (!_loc5_[_loc12_.id]) {
                                        _loc2_[_loc10_].inventoryItemInfo.slotId = _loc12_.id;
                                        _loc5_[_loc12_.id] = _loc2_[_loc10_];
                                        break;
                                    }
                                }
                            }
                            _loc13_++;
                        }
                        _loc10_++;
                    }
                }
            }
            this.inventoryData.inventoryItemsById = param1.inventoryData.inventoryItemsById;
            this.inventoryData.inventorySlotsById = param1.inventoryData.inventorySlotsById;
            this.inventoryData.inventoryItemsBySlotId = param1.inventoryData.updateInventoryItemsBySlotId();
            this.inventoryData.dustAmount = param1.inventoryData.dustAmount;
            this.inventoryData.nextInventoryItemId = param1.inventoryData.nextInventoryItemId;
            this.inventoryData.sealedItemDataById = param1.inventoryData.sealedItemDataById;
            this.inventoryData.dirty = true;
        }
    }

    private function updateCharacterData(param1:UserGameData):void {
        var _loc2_:ArrayChangesChecker = null;
        if (param1.characterData) {
            if (!this.characterData) {
                this.characterData = new UserCharacterData();
            }
            _loc2_ = new ArrayChangesChecker();
            if (this.characterData.characterName != param1.characterData.characterName || this.characterData.typeId != param1.characterData.typeId || _loc2_.hasChanges(this.characterData.allowedExtraCharacters, param1.characterData.allowedExtraCharacters)) {
                this.characterData.characterName = param1.characterData.characterName;
                this.characterData.typeId = param1.characterData.typeId;
                this.characterData.allowedExtraCharacters = param1.characterData.allowedExtraCharacters;
                this.characterData.dirty = true;
            }
        }
    }

    private function updateSessionChestData(param1:UserGameData):void {
        if (!this.sessionChestData && param1.sessionChestData) {
            this.sessionChestData = param1.sessionChestData;
            return;
        }
        if (!this.sessionChestData) {
            return;
        }
        if (param1.sessionChestData && !this.sessionChestData.equals(param1.sessionChestData)) {
            this.sessionChestData.update(param1.sessionChestData);
        }
    }

    private function updateVipSupportData(param1:UserGameData):void {
        if (param1.vipSupportData == null) {
            return;
        }
        if (this.vipSupportData.joinedProgram != param1.vipSupportData.joinedProgram || this.vipSupportData.lastVipChatMessageId != param1.vipSupportData.lastVipChatMessageId) {
            this.vipSupportData.joinedProgram = param1.vipSupportData.joinedProgram;
            this.vipSupportData.lastVipChatMessageId = param1.vipSupportData.lastVipChatMessageId;
            this.vipSupportData.dirty = true;
        }
    }

    private function updateBlueLightData(param1:UserGameData):void {
        var _loc2_:* = null;
        var _loc3_:Boolean = false;
        var _loc4_:Dictionary = null;
        if (param1.blueLightData == null) {
            return;
        }
        if (!this.blueLightData.equals(param1.blueLightData)) {
            _loc3_ = true;
        }
        else {
            _loc3_ = false;
            for (_loc2_ in param1.blueLightData.bluelightByIds) {
                if (this.blueLightData.bluelightByIds[_loc2_] == null) {
                    _loc3_ = true;
                    break;
                }
                if (param1.blueLightData.bluelightByIds[_loc2_].state != this.blueLightData.bluelightByIds[_loc2_].state || param1.blueLightData.bluelightByIds[_loc2_].stepId != this.blueLightData.bluelightByIds[_loc2_].stepId || param1.blueLightData.bluelightByIds[_loc2_].points != this.blueLightData.bluelightByIds[_loc2_].points) {
                    _loc3_ = true;
                    break;
                }
            }
        }
        if (_loc3_) {
            _loc4_ = new Dictionary(true);
            for (_loc2_ in this.blueLightData.bluelightByIds) {
                _loc4_[_loc2_] = this.blueLightData.bluelightByIds[_loc2_].points;
            }
            this.blueLightData.bluelightByIds = param1.blueLightData.bluelightByIds;
            for (_loc2_ in this.blueLightData.bluelightByIds) {
                this.blueLightData.bluelightByIds[_loc2_].previousPoints = !!_loc4_[_loc2_] ? _loc4_[_loc2_] : 0;
            }
            this.blueLightData.dirty = true;
        }
    }

    private function updatePromotionOfferData(param1:UserGameData):void {
        this.promotionOfferData.update(param1.promotionOfferData);
    }

    public function updateLotteryData(param1:UserGameData):void {
        var _loc2_:* = false;
        if (param1.lotteryData != null) {
            this.lotteryData.freeTicketsCountByTypeId = param1.lotteryData.freeTicketsCountByTypeId;
            this.lotteryData.contributedTicketTypesCountByLotteryId = param1.lotteryData.contributedTicketTypesCountByLotteryId;
            this.lotteryData.ticketsDirty = true;
            if (this.lotteryData.wonLotteries == null) {
                _loc2_ = param1.lotteryData.wonLotteries != null;
            }
            else {
                _loc2_ = Boolean(param1.lotteryData.wonLotteries == null || this.lotteryData.wonLotteries.length != param1.lotteryData.wonLotteries.length);
            }
            if (!_loc2_) {
                if (this.lotteryData.lostLotteries == null) {
                    _loc2_ = param1.lotteryData.lostLotteries != null;
                }
                else {
                    _loc2_ = Boolean(param1.lotteryData.lostLotteries == null || this.lotteryData.lostLotteries.length != param1.lotteryData.wonLotteries.length);
                }
            }
            this.lotteryData.wonLotteries = param1.lotteryData.wonLotteries;
            this.lotteryData.lostLotteries = param1.lotteryData.lostLotteries;
            this.lotteryData.dirty = _loc2_;
        }
    }

    private function updateDragonData(param1:UserGameData):void {
        var _loc3_:Ability = null;
        var _loc4_:int = 0;
        var _loc5_:* = undefined;
        var _loc6_:Ability = null;
        if (param1.dragonData == null) {
            return;
        }
        var _loc2_:Boolean = false;
        if (this.dragonData.monsterHitsList.length != param1.dragonData.monsterHitsList.length) {
            _loc2_ = true;
        }
        if (param1.dragonData.dragonName != this.dragonData.dragonName) {
            _loc2_ = true;
        }
        else if (param1.dragonData.renameCount != this.dragonData.renameCount) {
            _loc2_ = true;
        }
        else if (this.dragonData.activationFinishTime == null && param1.dragonData.activationFinishTime != null) {
            _loc2_ = true;
        }
        else if (this.dragonData.activationFinishTime != null && param1.dragonData.activationFinishTime == null) {
            _loc2_ = true;
        }
        else if (this.dragonData.activationFinishTime != null && param1.dragonData.activationFinishTime != null && param1.dragonData.activationFinishTime.time != this.dragonData.activationFinishTime.time) {
            _loc2_ = true;
        }
        else if (param1.dragonData.maxActiveAbilities != this.dragonData.maxActiveAbilities) {
            _loc2_ = true;
        }
        else if (param1.dragonData.dragonPoints != this.dragonData.dragonPoints) {
            _loc2_ = true;
        }
        else if (!param1.dragonData.resources.equal(this.dragonData.resources)) {
            _loc2_ = true;
        }
        else if (param1.dragonData.hitsRefreshTime != this.dragonData.hitsRefreshTime || param1.dragonData.todayFightsCount != this.dragonData.todayFightsCount || param1.dragonData.hitsCount != this.dragonData.hitsCount) {
            _loc2_ = true;
        }
        else {
            _loc4_ = 0;
            while (_loc4_ < this.dragonData.monsterHitsList.length) {
                if (param1.dragonData.monsterHitsList[_loc4_].used != this.dragonData.monsterHitsList[_loc4_].used || param1.dragonData.monsterHitsList[_loc4_].damage != this.dragonData.monsterHitsList[_loc4_].damage || param1.dragonData.monsterHitsList[_loc4_].points != this.dragonData.monsterHitsList[_loc4_].points) {
                    _loc2_ = true;
                    break;
                }
                _loc4_++;
            }
        }
        if (!_loc2_) {
            for (_loc5_ in param1.dragonData.selectedAbilitiesLevelById) {
                if (param1.dragonData.selectedAbilitiesLevelById[_loc5_] != this.dragonData.selectedAbilitiesLevelById[_loc5_]) {
                    _loc2_ = true;
                    break;
                }
            }
        }
        for each(_loc3_ in param1.dragonData.abilities) {
            _loc6_ = this.dragonData.getAbilityById(_loc3_.typeId);
            if (_loc6_ == null) {
                this.dragonData.addAbilityToUser(_loc3_);
                _loc2_ = true;
            }
            else if (!_loc6_.isEqual(_loc3_)) {
                _loc6_.constructionObjInfo.level = _loc3_.constructionObjInfo.level;
                _loc6_.constructionObjInfo.constructionStartTime = _loc3_.constructionObjInfo.constructionStartTime;
                _loc6_.constructionObjInfo.constructionFinishTime = _loc3_.constructionObjInfo.constructionFinishTime;
                _loc6_.constructionObjInfo.progressPercentage = _loc3_.constructionObjInfo.progressPercentage;
                _loc6_.dirtyNormalized = true;
                _loc2_ = true;
            }
        }
        if (_loc2_) {
            this.dragonData.hitsRefreshTime = param1.dragonData.hitsRefreshTime;
            this.dragonData.hitsCount = param1.dragonData.hitsCount;
            this.dragonData.todayFightsCount = param1.dragonData.todayFightsCount;
            this.dragonData.monsterHitsList = param1.dragonData.monsterHitsList;
            this.dragonData.dragonPoints = param1.dragonData.dragonPoints;
            this.dragonData.dragonName = param1.dragonData.dragonName;
            this.dragonData.renameCount = param1.dragonData.renameCount;
            this.dragonData.activationFinishTime = param1.dragonData.activationFinishTime;
            this.dragonData.maxActiveAbilities = param1.dragonData.maxActiveAbilities;
            this.dragonData.selectedAbilitiesIds = param1.dragonData.selectedAbilitiesIds;
            this.dragonData.selectedAbilitiesLevelById = param1.dragonData.selectedAbilitiesLevelById;
            this.dragonData.resources = param1.dragonData.resources;
            this.dragonData.updateActiveDragonData();
            this.dragonData.dirty = true;
        }
    }

    public function update(param1:UserGameData):void {
        if (param1 == null) {
            return;
        }
        this.revision = Math.max(this.revision, param1.revision);
        this.normalizationTime = param1.normalizationTime;
        if (this.mapPos == null) {
            this.mapPos = param1.mapPos;
            dispatchEvent(MAP_POS_CHANGED);
        }
        this.account.update(param1.account);
        this.updateMapData(param1);
        this.updateMapPosition(param1);
        this.updateMapState(param1);
        this.updateSector(param1);
        this.updateMessageCenter(param1);
        this.updateTechnologyCenter(param1);
        this.updateDrawingArchive(param1);
        this.updateTradingCenter(param1);
        this.updateTroopsData(param1);
        this.updateResurrectionData(param1);
        this.updateWorldData(param1);
        this.updateClanData(param1);
        this.updateConstructionData(param1);
        this.updateKnownUsersData(param1);
        this.updateTreasureData(param1);
        this.updateCommonData(param1);
        this.updateEffectData(param1);
        this.updateEpicBattleData(param1);
        this.updateStatsData(param1);
        this.updateSectorSkinsData(param1);
        this.updateCyborgsData(param1);
        this.updateArtifactData(param1);
        this.updateAllianceData(param1);
        this.updateQuestData(param1);
        this.updateBlackMarketData(param1);
        this.updateRaidData(param1);
        this.updateSkillData(param1);
        this.updateResourcesConversionData(param1);
        this.updateOccupationData(param1);
        this.updateVipData(param1);
        this.updateLoyaltyData(param1);
        this.updateGemData(param1);
        this.updateInvitationData(param1);
        this.updateVipSupportData(param1);
        this.updateDiscountOfferData(param1);
        this.updateInventoryData(param1);
        this.updateCharacterData(param1);
        this.updateSessionChestData(param1);
        this.updateBlueLightData(param1);
        this.updateDragonData(param1);
        this.updateLotteryData(param1);
        this.updatePromotionOfferData(param1);
        this.wisdomSkillsData.update(param1.wisdomSkillsData);
        this.giftPointsProgramData.update(param1.giftPointsProgramData);
        this.clanPurchaseData.update(param1.clanPurchaseData);
        this.resetBuyStatusBySceneObject();
        this.updateObjectsBuyStatus(true, false, true);
        param1.skillData.updateStatus();
        this.recalcData();
        this._constructionData.initAcceleration(this);
        this.raiseCaravanLimitsChanged();
        UserClanData.refreshFriendIds(UserManager.user);
    }

    private function updateMapPosition(param1:UserGameData):void {
        if (this.mapPos != null && param1.mapPos != null && (this.mapPos.x != param1.mapPos.x || this.mapPos.y != param1.mapPos.y)) {
            this.mapPos = param1.mapPos;
            dispatchEvent(MAP_POS_CHANGED);
        }
    }

    private function updateMapData(param1:UserGameData):void {
        if (param1.mapData == null) {
            return;
        }
        this.mapData.lastTeleportationTime = param1.mapData.lastTeleportationTime;
        this.mapData.lastRandomTeleportationTime = param1.mapData.lastRandomTeleportationTime;
        this.mapData.dateDirty = true;
    }

    private function updateMapState(param1:UserGameData):void {
        if (this.mapStateId != param1.mapStateId) {
            this.mapStateId = param1.mapStateId;
            dispatchEvent(MAP_STATE_CHANGED);
        }
    }

    private function updateSector(param1:UserGameData):void {
        var _loc2_:Array = null;
        var _loc3_:Boolean = false;
        var _loc4_:GeoScene = null;
        var _loc5_:GeoSceneObject = null;
        var _loc6_:GeoSceneObject = null;
        var _loc7_:RepairBuildingsCmd = null;
        if (param1.sector == null) {
            return;
        }
        if (!FormSectorUIManager.Instance.isInEditModeView) {
            this.sector.name = param1.sector.name;
            this.updateSectorScene(param1);
        }
        else {
            this.currentGameData = param1;
            FormSectorUIManager.Instance.addEventHandler(FormSectorUIManager.EVENT_EDIT_MODE_CHANGED_VIEW, this.editModeManipulation);
            _loc2_ = [];
            _loc3_ = false;
            _loc4_ = this.sector.sectorScene;
            for each(_loc5_ in param1.sector.sectorScene.sceneObjects) {
                _loc6_ = _loc4_.getObjectById(_loc5_.id) as GeoSceneObject;
                if (!_loc3_ && _loc6_ && _loc6_.type && _loc6_.type.id == BuildingTypeId.RobotRepair) {
                    _loc3_ = true;
                }
                if (_loc6_ && _loc6_.buildingInfo.broken != _loc5_.buildingInfo.broken) {
                    _loc6_.buildingInfo.broken = _loc5_.buildingInfo.broken;
                    _loc6_.dirtyNormalized = true;
                    if (_loc6_.buildingInfo.broken) {
                        _loc2_.push(_loc6_);
                    }
                }
            }
            if (_loc3_ && _loc2_.length > 0) {
                _loc7_ = new RepairBuildingsCmd(_loc2_);
                _loc7_.execute();
            }
        }
        this.sector.buildingRepairedByUserIds = param1.sector.buildingRepairedByUserIds;
        this.sector.buildingRepairedForUserIds = param1.sector.buildingRepairedForUserIds;
        this.sector.lastDateBuildingRepairedByUser = param1.sector.lastDateBuildingRepairedByUser;
        this.sector.buildingsDeletedByUserTypeIds = param1.sector.buildingsDeletedByUserTypeIds;
        if (this.sector.lastClickId < param1.sector.lastClickId) {
            this.sector.lastClickId = param1.sector.lastClickId;
        }
    }

    protected function editModeManipulation(param1:Event):void {
        if (!FormSectorUIManager.Instance.isInEditMode && this.currentGameData != null) {
            FormSectorUIManager.Instance.removeEventHandler(FormSectorUIManager.EVENT_EDIT_MODE_CHANGED_VIEW, this.editModeManipulation);
            this.updateSectorScene(this.currentGameData);
        }
    }

    private function updateSectorScene(param1:UserGameData):void {
        var _loc8_:GeoSceneObject = null;
        var _loc9_:SceneObject = null;
        var _loc10_:GeoSceneObject = null;
        var _loc11_:GeoSceneObject = null;
        var _loc12_:RepairBuildingsCmd = null;
        var _loc2_:Array = [];
        var _loc3_:Boolean = false;
        var _loc4_:GeoScene = this.sector.sectorScene;
        var _loc5_:GeoScene = param1.sector.sectorScene;
        var _loc6_:int = _loc4_.sceneObjects.length - 1;
        var _loc7_:int = _loc6_;
        while (_loc7_ >= 0) {
            _loc9_ = _loc4_.sceneObjects[_loc7_];
            _loc10_ = _loc5_.getObjectById(_loc9_.id) as GeoSceneObject;
            if (_loc10_ == null) {
                _loc4_.sceneObjectRemove(_loc9_);
            }
            _loc7_--;
        }
        for each(_loc8_ in param1.sector.sectorScene.sceneObjects) {
            _loc11_ = _loc4_.getObjectById(_loc8_.id) as GeoSceneObject;
            if (!_loc3_ && _loc11_ && _loc11_.type && _loc11_.type.id == BuildingTypeId.RobotRepair) {
                _loc3_ = true;
            }
            if (_loc11_ == null) {
                _loc4_.sceneObjectAdd(_loc8_, true);
            }
            else {
                if (_loc11_.column != _loc8_.column) {
                    _loc11_.column = _loc8_.column;
                }
                if (_loc11_.row != _loc8_.row) {
                    _loc11_.row = _loc8_.row;
                }
                if (_loc11_.isMirrored != _loc8_.isMirrored) {
                    _loc11_.isMirrored = _loc8_.isMirrored;
                }
                if (_loc11_.buildingInfo.broken != _loc8_.buildingInfo.broken) {
                    _loc11_.buildingInfo.broken = _loc8_.buildingInfo.broken;
                    _loc11_.dirtyNormalized = true;
                    if (_loc11_.buildingInfo.broken) {
                        _loc2_.push(_loc11_);
                    }
                }
                if (_loc8_.constructionObjInfo.level != _loc11_.constructionObjInfo.level || _loc11_.buildingInProgress != _loc8_.buildingInProgress || _loc11_.constructionObjInfo.constructionFinishTime != _loc8_.constructionObjInfo.constructionFinishTime) {
                    _loc11_.constructionObjInfo.level = _loc8_.constructionObjInfo.level;
                    _loc11_.constructionObjInfo.constructionStartTime = _loc8_.constructionObjInfo.constructionStartTime;
                    _loc11_.constructionObjInfo.constructionFinishTime = _loc8_.constructionObjInfo.constructionFinishTime;
                    _loc11_.constructionObjInfo.progressPercentage = 0;
                    _loc11_.dirtyNormalized = true;
                }
            }
        }
        if (_loc3_ && _loc2_.length > 0) {
            _loc12_ = new RepairBuildingsCmd(_loc2_);
            _loc12_.execute();
        }
        if (UserManager.user.gameData.sector.sectorScene.sizeX != param1.sector.sectorScene.sizeX) {
            UserManager.user.gameData.sector.sectorScene.setSize(param1.sector.sectorScene.sizeX, param1.sector.sectorScene.sizeY);
        }
    }

    private function updateTechnologyCenter(param1:UserGameData):void {
        var _loc3_:GeoSceneObject = null;
        var _loc4_:GeoSceneObject = null;
        var _loc2_:TechnologyCenter = this.technologyCenter;
        for each(_loc3_ in param1.technologyCenter.technologies) {
            _loc4_ = _loc2_.getTechnology(_loc3_.type.id);
            if (_loc4_.constructionObjInfo.level != _loc3_.constructionObjInfo.level || _loc4_.buildingInProgress != _loc3_.buildingInProgress || _loc4_.constructionObjInfo.constructionFinishTime != _loc3_.constructionObjInfo.constructionFinishTime) {
                _loc4_.constructionObjInfo.level = _loc3_.constructionObjInfo.level;
                _loc4_.constructionObjInfo.constructionStartTime = _loc3_.constructionObjInfo.constructionStartTime;
                _loc4_.constructionObjInfo.constructionFinishTime = _loc3_.constructionObjInfo.constructionFinishTime;
                _loc4_.constructionObjInfo.progressPercentage = 100;
                _loc4_.dirtyNormalized = true;
            }
        }
    }

    private function updateDrawingArchive(param1:UserGameData):void {
        var _loc3_:GeoSceneObject = null;
        var _loc4_:GeoSceneObject = null;
        var _loc5_:int = 0;
        var _loc2_:DrawingArchive = this.drawingArchive;
        for each(_loc3_ in param1.drawingArchive.drawings) {
            _loc4_ = _loc2_.getDrawing(_loc3_.type.id);
            if (!(_loc4_ == null || _loc4_.drawingInfo == null || _loc4_.drawingInfo.drawingParts == null)) {
                _loc5_ = 0;
                while (_loc5_ < _loc4_.drawingInfo.drawingParts.length) {
                    if (_loc4_.drawingInfo.drawingParts[_loc5_] != _loc3_.drawingInfo.drawingParts[_loc5_]) {
                        _loc4_.drawingInfo.drawingParts[_loc5_] = _loc3_.drawingInfo.drawingParts[_loc5_];
                    }
                    _loc5_++;
                }
            }
        }
        this.drawingArchive.clicksForUserIds = param1.drawingArchive.clicksForUserIds;
        this.drawingArchive.clicksFromUserIds = param1.drawingArchive.clicksFromUserIds;
        this.drawingArchive.currentClicksCount = param1.drawingArchive.currentClicksCount;
        this.drawingArchive.lastClickDateByOtherUser = param1.drawingArchive.lastClickDateByOtherUser;
        this.drawingArchive.addedDrawingPartsForClicks = param1.drawingArchive.addedDrawingPartsForClicks;
        this.drawingArchive.clicksDirty = true;
    }

    private function updateTradingCenter(param1:UserGameData):void {
        if (param1.tradingCenter == null) {
            return;
        }
        this.tradingCenter.offers = param1.tradingCenter.offers;
        this.tradingCenter.dispatchEvents();
    }

    private function updateMessageCenter(param1:UserGameData):void {
        if (param1.messageData == null) {
            return;
        }
        var _loc2_:Boolean = Global.EXTERNAL_MASSAGES_ENABLED && (this.messageData.blackList.length != param1.messageData.blackList.length || this.messageData.messagesSentToday != param1.messageData.messagesSentToday);
        var _loc3_:Boolean = Global.EXTERNAL_MASSAGES_ENABLED && (this.messageData.battleReportOwnSectorLossesThreshold != param1.messageData.battleReportOwnSectorLossesThreshold || this.messageData.battleReportMyAllianceCityLossesThreshold != param1.messageData.battleReportMyAllianceCityLossesThreshold || this.messageData.ignoreSuccessIntelligenceDefense != param1.messageData.ignoreSuccessIntelligenceDefense || this.messageData.ignoreSuccessTowerGuardDefense != param1.messageData.ignoreSuccessTowerGuardDefense || this.messageData.diplomaticAdviserBattleReportsTypes != param1.messageData.diplomaticAdviserBattleReportsTypes);
        if (Global.EXTERNAL_MASSAGES_ENABLED && this.messageData.hasPersonalChanges(param1.messageData.messagesCountByGroup)) {
            this.messageData.messagesCountByGroup = param1.messageData.messagesCountByGroup;
            _loc2_ = true;
            MessageManager.waitWhenMessagesIsReadOnServer = false;
        }
        if (Global.EXTERNAL_MASSAGES_ENABLED && this.messageData.hasAdviserChanges(param1.messageData.messagesCountByGroup)) {
            if (!_loc2_) {
                this.messageData.messagesCountByGroup = param1.messageData.messagesCountByGroup;
            }
            _loc3_ = true;
            MessageManager.waitWhenMessagesIsReadOnServer = false;
        }
        this.messageData.messages = param1.messageData.messages;
        this.messageData.battleReportOwnSectorLossesThreshold = param1.messageData.battleReportOwnSectorLossesThreshold;
        this.messageData.battleReportMyAllianceCityLossesThreshold = param1.messageData.battleReportMyAllianceCityLossesThreshold;
        this.messageData.ignoreSuccessIntelligenceDefense = param1.messageData.ignoreSuccessIntelligenceDefense;
        this.messageData.ignoreSuccessTowerGuardDefense = param1.messageData.ignoreSuccessTowerGuardDefense;
        this.messageData.diplomaticAdviserBattleReportsTypes = param1.messageData.diplomaticAdviserBattleReportsTypes;
        this.messageData.blackList = param1.messageData.blackList;
        this.messageData.nextMessageId = param1.messageData.nextMessageId;
        this.messageData.messagesSentToday = param1.messageData.messagesSentToday;
        this.messageData.personalExternalMessagesDirty = _loc2_;
        this.messageData.advisersExternalMessagesDirty = _loc3_;
        this.messageData.messagesDirty = true;
    }

    private function updateTroopsData(param1:UserGameData):void {
        if (param1.troopsData == null) {
            return;
        }
        this.troopsData.troops.countByType = param1.troopsData.troops.countByType;
        this.troopsData.troops.dirtyNormalized = true;
        this.troopsData.missileStorage.countByType = param1.troopsData.missileStorage.countByType;
        this.troopsData.missileStorage.dirtyNormalized = true;
        if (Global.TROOPS_LEVELS_ENABLED) {
            this.troopsData.updateTiers(param1.troopsData);
        }
        this.updateTroopsFactory(param1);
    }

    private function updateTroopsFactory(param1:UserGameData):void {
        var _loc4_:TroopsOrder = null;
        var _loc5_:int = 0;
        var _loc6_:TroopsOrder = null;
        var _loc7_:TroopsOrder = null;
        if (param1.troopsData.troopsFactory == null) {
            return;
        }
        var _loc2_:TroopsFactory = this.troopsData.troopsFactory;
        var _loc3_:TroopsFactory = param1.troopsData.troopsFactory;
        _loc2_.nextOrderId = _loc3_.nextOrderId;
        for each(_loc4_ in _loc3_.orders) {
            _loc6_ = _loc2_.getOrder(_loc4_.id);
            if (_loc6_ == null) {
                _loc2_.addOrder2(_loc4_);
            }
            else if (_loc6_.constructionObjInfo.constructionStartTime != _loc4_.constructionObjInfo.constructionStartTime || _loc6_.pendingCount != _loc4_.pendingCount || _loc6_.totalCount != _loc4_.totalCount) {
                _loc6_.constructionObjInfo.constructionStartTime = _loc4_.constructionObjInfo.constructionStartTime;
                _loc6_.constructionObjInfo.constructionFinishTime = _loc4_.constructionObjInfo.constructionFinishTime;
                _loc6_.totalCount = _loc4_.totalCount;
                _loc6_.pendingCount = _loc4_.pendingCount;
                _loc6_.dirtyNormalized = true;
            }
        }
        _loc5_ = _loc2_.orders.length - 1;
        while (_loc5_ >= 0) {
            _loc7_ = _loc3_.getOrder(_loc2_.orders[_loc5_].id);
            if (_loc7_ == null) {
                _loc2_.removeOrder(_loc2_.orders[_loc5_]);
            }
            _loc5_--;
        }
        if (param1.troopsData.troopsFactory.extraTroopsSlots != null) {
            _loc2_.extraTroopsSlots = param1.troopsData.troopsFactory.extraTroopsSlots;
        }
    }

    private function updateResurrectionData(param1:UserGameData):void {
        if (param1.resurrectionData == null) {
            return;
        }
        this.resurrectionData.resurrectionKits = param1.resurrectionData.resurrectionKits;
        this.resurrectionData.dirtyNormalized = true;
    }

    private function updateWorldData(param1:UserGameData):void {
        var _loc2_:Unit = null;
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:Unit = null;
        var _loc6_:Unit = null;
        var _loc7_:Unit = null;
        if (param1.worldData == null) {
            return;
        }
        for each(_loc2_ in param1.worldData.units) {
            _loc5_ = this.worldData.getUnitById(_loc2_.UnitId, _loc2_.OwnerUserId);
            if (_loc5_ == null) {
                this.worldData.units.addItem(_loc2_);
            }
            else {
                _loc5_.fromClone(_loc2_);
            }
        }
        _loc3_ = this.worldData.units.length - 1;
        _loc4_ = _loc3_;
        while (_loc4_ >= 0) {
            _loc6_ = this.worldData.units[_loc4_];
            _loc7_ = param1.worldData.getUnitById(_loc6_.UnitId, _loc6_.OwnerUserId);
            if (_loc7_ == null) {
                this.worldData.units.removeItemAt(_loc4_);
            }
            _loc4_--;
        }
        this.worldData.resourceCaravansSentToday = param1.worldData.resourceCaravansSentToday;
        this.worldData.drawingCaravansSentToday = param1.worldData.drawingCaravansSentToday;
        this.worldData.resourcesFlow = param1.worldData.resourcesFlow;
        this.worldData.robberyCounter = param1.worldData.robberyCounter;
        this.worldData.nextAvailableRobberyDate = param1.worldData.nextAvailableRobberyDate;
        this.worldData.incomingResourcesToday = param1.worldData.incomingResourcesToday;
        this.worldData.nextAvailableMissileStrikeDate = param1.worldData.nextAvailableMissileStrikeDate;
        this.worldData.missileStrikesCounter = param1.worldData.missileStrikesCounter;
        this.worldData.lastMissileStrikeDate = param1.worldData.lastMissileStrikeDate;
        this.worldData.resourcesRobbed = param1.worldData.resourcesRobbed;
        this.worldData.lastResourcesRobbedDate = param1.worldData.lastResourcesRobbedDate;
        UnitUtility.UpdateReturningInSectorUnits(UserManager.user);
        this.worldData.dirtyUnitListChanged = true;
        this.worldData.dirtyRobberyCounter = true;
    }

    private function updateClanData(param1:UserGameData):void {
        if (param1.clanData == null) {
            return;
        }
        this.clanData.members = param1.clanData.members;
        this.clanData.invitations = param1.clanData.invitations;
        this.clanData.dirty = true;
    }

    private function updateConstructionData(param1:UserGameData):void {
        if (param1._constructionData == null) {
            return;
        }
        this._constructionData.resourceMiningBoosts = param1._constructionData.resourceMiningBoosts;
        this._constructionData.resourceConsumptionBonusBoosts = param1._constructionData.resourceConsumptionBonusBoosts;
        this._constructionData.troopsQueueHoursLimit = param1._constructionData.troopsQueueHoursLimit;
        this._constructionData.buildTrooperFaster = param1._constructionData.buildTrooperFaster;
        this._constructionData.constructionWorkersCount = param1._constructionData.constructionWorkersCount;
        this._constructionData.freeTechnologiesResearched = param1._constructionData.freeTechnologiesResearched;
        this._constructionData.currentRepariRobotsCount = param1._constructionData.currentRepariRobotsCount;
        this._constructionData.additionalWorkersExpireDateTimes = param1._constructionData.additionalWorkersExpireDateTimes;
        this._constructionData.constructionWorkersChanged = true;
        this._constructionData.availableWorkersChanged = true;
        this._constructionData.hasDiscountForBuildingRobot = param1._constructionData.hasDiscountForBuildingRobot;
    }

    private function updateKnownUsersData(param1:UserGameData):void {
        if (param1.knownUsersData == null) {
            return;
        }
        this.knownUsersData.mateUserIds = param1.knownUsersData.mateUserIds;
        this.knownUsersData.enemyUserIds = param1.knownUsersData.enemyUserIds;
        this.knownUsersData.allianceEnemyUserIds = param1.knownUsersData.allianceEnemyUserIds;
        this.knownUsersData.favouriteUsers = param1.knownUsersData.favouriteUsers;
        this.knownUsersData.enemyUserIdsWithTime = param1.knownUsersData.enemyUserIdsWithTime;
        this.knownUsersData.knownTowers = param1.knownUsersData.knownTowers;
        this.knownUsersData.dirty = true;
        this.knownUsersData.favouritesDirty = true;
    }

    private function updateTreasureData(param1:UserGameData):void {
        if (param1.treasureData == null) {
            return;
        }
        if (this.treasureData == null) {
            this.treasureData = new UserTreasureData();
        }
        if (this.treasureData.lastBoxId < param1.treasureData.lastBoxId) {
            this.treasureData.lastBoxId = param1.treasureData.lastBoxId;
        }
        this.treasureData.boxesByUsers = param1.treasureData.boxesByUsers;
        this.treasureData.boxesValues = param1.treasureData.boxesValues;
        this.treasureData.userBoxesQuantity = param1.treasureData.userBoxesQuantity;
        this.treasureData.friendsBoxesQuantity = param1.treasureData.friendsBoxesQuantity;
        this.treasureData.dirty = true;
    }

    private function updateSectorSkinsData(param1:UserGameData):void {
        if (param1.sectorSkinsData == null) {
            return;
        }
        var _loc2_:Boolean = false;
        if (this.sectorSkinsData == null) {
            this.sectorSkinsData = new UserSectorSkinData();
            _loc2_ = true;
        }
        if (this.sectorSkinsData.currentSkinTypeId != param1.sectorSkinsData.currentSkinTypeId) {
            this.sectorSkinsData.currentSkinTypeId = param1.sectorSkinsData.currentSkinTypeId;
            _loc2_ = true;
        }
        if (this.sectorSkinsData.purchasedSkinTypes.length != param1.sectorSkinsData.purchasedSkinTypes.length) {
            this.sectorSkinsData.purchasedSkinTypes = param1.sectorSkinsData.purchasedSkinTypes;
            _loc2_ = true;
        }
        if (param1.sectorSkinsData.temporarySectorSkinData != null) {
            if (this.sectorSkinsData.temporarySectorSkinData == null || !this.sectorSkinsData.temporarySectorSkinData.isEqual(param1.sectorSkinsData.temporarySectorSkinData)) {
                this.sectorSkinsData.temporarySectorSkinData = param1.sectorSkinsData.temporarySectorSkinData;
                this.sectorSkinsData.temporarySkinDirty = true;
                _loc2_ = true;
            }
        }
        if (_loc2_) {
            this.sectorSkinsData.dirty = true;
            dispatchEvent(SECTOR_SKIN_DATA_CHANGED);
        }
    }

    private function updateCyborgsData(param1:UserGameData):void {
        if (param1.cyborgData == null) {
            return;
        }
        if (this.cyborgData == null) {
            this.cyborgData = new UserCyborgData();
        }
        this.cyborgData.createdCyborgForUserIds = param1.cyborgData.createdCyborgForUserIds;
        this.cyborgData.cyborgsCreated = param1.cyborgData.cyborgsCreated;
        this.cyborgData.cyborgsCreatedByOtherUsers = param1.cyborgData.cyborgsCreatedByOtherUsers;
        this.cyborgData.cyborgUserIds = param1.cyborgData.cyborgUserIds;
        this.cyborgData.dirty = true;
    }

    private function updateArtifactData(param1:UserGameData):void {
        var oldLayout:Array = null;
        var i:int = 0;
        var gameData:UserGameData = param1;
        try {
            if (gameData.artifactData == null) {
                return;
            }
            if (this.artifactData == null) {
                this.artifactData = new UserArtifactData();
            }
            oldLayout = this.artifactData.artifactsLayout;
            this.artifactData.artifacts = gameData.artifactData.artifacts;
            this.artifactData.artifactsLayout = gameData.artifactData.artifactsLayout;
            this.artifactData.earnedLossesPoints = gameData.artifactData.earnedLossesPoints;
            this.artifactData.issuedArtifacts = gameData.artifactData.issuedArtifacts;
            this.artifactData.lastTimeGotArtifact = gameData.artifactData.lastTimeGotArtifact;
            this.artifactData.nextObjectId = gameData.artifactData.nextObjectId;
            this.artifactData.storageSlotsAvailable = gameData.artifactData.storageSlotsAvailable;
            this.artifactData.storageSlotsBought = gameData.artifactData.storageSlotsBought;
            this.artifactData.artifactsDirty = true;
            i = ArtifactManager.TempLowerBound;
            while (i <= ArtifactManager.TempUpperBound) {
                if (i < this.artifactData.artifactsLayout.length && oldLayout[i] != this.artifactData.artifactsLayout[i]) {
                    this.artifactData.temporarySlotsChanged = true;
                    break;
                }
                i++;
            }
            return;
        }
        catch (e:Error) {
            trace(e.message);
            return;
        }
    }

    public function updateAllianceData(param1:UserGameData):void {
        if (param1.allianceData == null) {
            return;
        }
        var _loc2_:Number = this.allianceData.allianceId;
        this.allianceData.allianceId = param1.allianceData.allianceId;
        this.allianceData.rankId = param1.allianceData.rankId;
        this.allianceData.requests = param1.allianceData.requests;
        this.allianceData.invitations = param1.allianceData.invitations;
        this.allianceData.mobilizersCount = param1.allianceData.mobilizersCount;
        this.allianceData.canUseAntigen = param1.allianceData.canUseAntigen;
        this.allianceData.joinDate = param1.allianceData.joinDate;
        this.allianceData.trialFinishExpectedDate = param1.allianceData.trialFinishExpectedDate;
        this.allianceData.isTrial = param1.allianceData.isTrial;
        this.allianceData.allianceMissions = param1.allianceData.allianceMissions;
        this.allianceData.troopsTrainedPowerPoints = param1.allianceData.troopsTrainedPowerPoints;
        this.allianceData.raidLocationsCompleted = param1.allianceData.raidLocationsCompleted;
        this.allianceData.resourcesRobbed = param1.allianceData.resourcesRobbed;
        this.allianceData.dailyQuestsCompleted = param1.allianceData.dailyQuestsCompleted;
        this.allianceData.opponentLossesPowerPoints = param1.allianceData.opponentLossesPowerPoints;
        this.allianceData.rooms = param1.allianceData.rooms;
        this.allianceData.lastHistoryProcessedDate = param1.allianceData.lastHistoryProcessedDate;
        this.allianceData.allianceHelpData = param1.allianceData.allianceHelpData;
        this.allianceData.activityData = param1.allianceData.activityData;
        if ((AllianceManager.currentAlliance == null || _loc2_ != this.allianceData.allianceId) && !isNaN(this.allianceData.allianceId) && this.allianceData.rankId != AllianceMemberRankId.INVITED) {
            AllianceManager.loadAlliance(UserManager.user);
        }
        if (isNaN(this.allianceData.allianceId)) {
            AllianceManager.currentAlliance = null;
            if (AllianceManager.currentAllianceCity) {
                if (LocationNoteManager._notes[AllianceManager.currentAllianceCity.id]) {
                    LocationNoteManager._notes[AllianceManager.currentAllianceCity.id].finalized = true;
                    LocationNoteManager.events.dispatchEvent(new Event(LocationNoteManager.EVENT_CHANGED));
                }
                AllianceManager.currentAllianceCity = null;
                AllianceManager.cityIsAlreadyLoaded = false;
            }
        }
        this.allianceData.dirty = true;
    }

    public function updateQuestData(param1:UserGameData):void {
        var _loc2_:Boolean = false;
        var _loc3_:Boolean = false;
        var _loc4_:QuestState = null;
        var _loc5_:Quest = null;
        var _loc6_:QuestState = null;
        var _loc7_:QuestCompletionPeriodic = null;
        var _loc8_:QuestCompletionPeriodic = null;
        var _loc9_:EventWithTargetObject = null;
        if (param1.questData == null || param1.questData.openedStates == null) {
            return;
        }
        if (this.questData.openedStates == null || this.questData.openedStates.length != param1.questData.openedStates.length) {
            this.questData.dirty = true;
            this.questData.dirtyTournaments = true;
            this.questData.dirtyRobberyQuest = true;
            this.questData.dirtyPeriodicQuest = true;
        }
        else {
            for each(_loc4_ in param1.questData.openedStates) {
                _loc2_ = false;
                _loc3_ = false;
                if (_loc4_.completions != null && _loc4_.completions[0] != null && _loc4_.completions[0].tournament != null) {
                    this.questData.dirtyTournaments = true;
                }
                if (_loc4_.prototypeId >= QuestPrototypeId.CollectibleThemedItemsMin && _loc4_.prototypeId <= QuestPrototypeId.CollectibleThemedItemsMax) {
                    this.questData.dirtyCollectibleThemedItemsEvent = true;
                }
                if (_loc4_.prototypeId >= QuestPrototypeId.RobSpecificLevelOfPlayer && _loc4_.prototypeId <= QuestPrototypeId.RaidLocationTimes) {
                    this.questData.dirtyRobberyQuest = true;
                }
                if (_loc4_.prototypeId == QuestPrototypeId.OpenLotteries) {
                    this.questData.dirtyLotteryQuest = true;
                }
                _loc5_ = UserManager.user.gameData.questData.questById[_loc4_.questId];
                if (_loc5_ && _loc5_.categoryId == QuestCategoryId.Mines) {
                    this.questData.dirtyMinesQuest = true;
                }
                for each(_loc6_ in this.questData.openedStates) {
                    if (_loc4_.questId == _loc6_.questId) {
                        if (_loc4_.stateId != _loc6_.stateId) {
                            _loc3_ = true;
                        }
                        if (_loc4_.timeToRemind && (!_loc6_.timeToRemind || _loc4_.timeToRemind.time != _loc6_.timeToRemind.time)) {
                            _loc3_ = true;
                        }
                        if (_loc4_.timeDeadline && (!_loc6_.timeDeadline || _loc4_.timeDeadline.time != _loc6_.timeDeadline.time) || _loc6_.timeDeadline && (!_loc4_.timeDeadline || _loc6_.timeDeadline.time != _loc4_.timeDeadline.time)) {
                            _loc3_ = true;
                        }
                        if (_loc4_.completion != null && _loc4_.completion.periodic != null && _loc6_.completion != null && _loc6_.completion.periodic != null) {
                            _loc7_ = _loc6_.completion.periodic;
                            _loc8_ = _loc4_.completion.periodic;
                            if (_loc8_.currentPoints != _loc7_.currentPoints) {
                                this.questData.dirtyPeriodicQuest = true;
                                if (_loc8_.currentPoints > _loc7_.currentPoints && _loc8_.currentPoints >= _loc8_.questData.needCollectPoints) {
                                    _loc9_ = new EventWithTargetObject(UserQuestData.PERIODIC_QUEST_COMPLETED);
                                    _loc9_.targetObject = _loc4_;
                                    this.questData.events.dispatchEvent(_loc9_);
                                }
                            }
                        }
                        _loc2_ = true;
                        break;
                    }
                }
                if (_loc5_.categoryId == QuestCategoryId.StoryRaid) {
                    this.updateRaidLocationStories(_loc4_);
                }
                if (!_loc2_ || _loc3_) {
                    this.questData.dirty = true;
                    break;
                }
            }
        }
        this.questData.openedStates = param1.questData.openedStates;
        this.questData.activeThemedEvent = param1.questData.activeThemedEvent;
        this.questData.discountData = param1.questData.discountData;
        this.questData.questsForAutoRefresh = param1.questData.questsForAutoRefresh;
        this.questData.wizardCompletedPrototypeIds = param1.questData.wizardCompletedPrototypeIds;
        this.questData.dataRobbery = param1.questData.dataRobbery;
        this.questData.dailyData = param1.questData.dailyData;
        this.questData.periodicData = param1.questData.periodicData;
        this.questData.fluentData = param1.questData.fluentData;
    }

    private function updateRaidLocationStories(param1:QuestState):void {
        var _loc5_:Boolean = false;
        var _loc6_:RaidLocationStoryType = null;
        var _loc7_:RaidLocationStoryTypeStep = null;
        var _loc2_:QuestCompletionRaidLocation = (param1.completions[0] as QuestCompletion).raidLocation;
        var _loc3_:int = _loc2_.storyId;
        var _loc4_:int = _loc2_.stepId;
        for each(_loc6_ in StaticDataManager.raidLocationStoryTypes) {
            if (_loc6_.storyId == _loc3_) {
                for each(_loc7_ in _loc6_.steps) {
                    if (_loc7_.stepId == _loc4_) {
                        _loc5_ = true;
                        break;
                    }
                }
            }
        }
        if (!_loc5_) {
            new GetRaidLocationStoryTypeStepCmd(_loc3_, _loc4_).execute();
        }
    }

    private function updateBlackMarketData(param1:UserGameData):void {
        this.blackMarketData.strategyTroopsPurchasesCount = param1.blackMarketData.strategyTroopsPurchasesCount;
        this.blackMarketData.troopsPurchasesCount = param1.blackMarketData.troopsPurchasesCount;
        this.blackMarketData.drawingsPurchasesCount = param1.blackMarketData.drawingsPurchasesCount;
        this.blackMarketData.buildingsPurchasesCount = param1.blackMarketData.buildingsPurchasesCount;
        this.blackMarketData.boughtCountBySceneObjectTypeId = param1.blackMarketData.boughtCountBySceneObjectTypeId;
        this.blackMarketData.boughtCountByItemPackId = param1.blackMarketData.boughtCountByItemPackId;
        this.blackMarketData.purchaseCountById = param1.blackMarketData.purchaseCountById;
        this.blackMarketData.boughtItems = param1.blackMarketData.boughtItems;
        this.blackMarketData.dirty = true;
    }

    private function updateRaidData(param1:UserGameData):void {
        this.raidData.nextLocationId = param1.raidData.nextLocationId;
        this.raidData.locations = param1.raidData.locations;
        this.raidData.stats = param1.raidData.stats;
        this.raidData.storyData = param1.raidData.storyData;
        this.raidData.maxWonLevel = param1.raidData.maxWonLevel;
        this.raidData.todayBonusRefreshesCount = param1.raidData.todayBonusRefreshesCount;
        this.raidData.dirty = true;
    }

    private function updateSkillData(param1:UserGameData):void {
        var _loc2_:Skill = null;
        var _loc3_:Skill = null;
        var _loc4_:Skill = null;
        var _loc5_:Skill = null;
        if (this.skillData == null || this.skillData.skills == null || param1 == null || param1.skillData == null) {
            return;
        }
        this.skillData.skillPoints = param1.skillData.skillPoints;
        this.skillData.pointDiscardsCount = param1.skillData.pointDiscardsCount;
        for each(_loc2_ in param1.skillData.skills) {
            _loc4_ = SkillManager.getSkill(this.skillData, _loc2_.typeId);
            if (_loc4_ == null) {
                this.skillData.skills.addItem(_loc2_);
            }
            else if (_loc4_.constructionInfo.constructionStartTime != _loc2_.constructionInfo.constructionStartTime || _loc4_.constructionInfo.level != _loc2_.constructionInfo.level) {
                _loc4_.constructionInfo.level = _loc2_.constructionInfo.level;
                _loc4_.constructionInfo.constructionStartTime = _loc2_.constructionInfo.constructionStartTime;
                _loc4_.constructionInfo.constructionFinishTime = _loc2_.constructionInfo.constructionFinishTime;
                _loc4_.dirtyNormalized = true;
            }
        }
        for each(_loc3_ in this.skillData.skills) {
            _loc5_ = SkillManager.getSkill(param1.skillData, _loc3_.typeId);
            if (_loc5_ == null) {
                this.skillData.skills.removeItemAt(this.skillData.skills.getItemIndex(_loc3_));
            }
        }
        this.skillData.dirty = true;
    }

    private function updateResourcesConversionData(param1:UserGameData):void {
        if (this.resourcesConversionData == null || param1.resourcesConversionData == null || param1.resourcesConversionData == null) {
            return;
        }
        this.resourcesConversionData.nextJobId = param1.resourcesConversionData.nextJobId;
        this.resourcesConversionData.currentJobs = param1.resourcesConversionData.currentJobs;
        this.resourcesConversionData.dirty = true;
    }

    private function updateOccupationData(param1:UserGameData):void {
        var _loc2_:UserOccupationInfo = null;
        var _loc3_:UserOccupationInfo = null;
        var _loc4_:UserOccupationInfo = null;
        var _loc5_:UserOccupationInfo = null;
        if (!Global.serverSettings.occupation.enabled || param1.occupationData == null) {
            return;
        }
        if (this.occupationData.ownOccupationInfo == null) {
            this.occupationData.ownOccupationInfo = param1.occupationData.ownOccupationInfo;
        }
        else if (param1.occupationData.ownOccupationInfo == null) {
            this.occupationData.ownOccupationInfo = param1.occupationData.ownOccupationInfo;
        }
        else {
            if (!this.occupationData.ownOccupationInfo.equalsTo(param1.occupationData.ownOccupationInfo)) {
                this.occupationData.ownOccupationInfo.update(param1.occupationData.ownOccupationInfo);
                this.occupationData.ownOccupationInfo.dirtyNormalized = true;
            }
            this.occupationData.ownOccupationInfo.dirtyNormalized = true;
        }
        for each(_loc2_ in param1.occupationData.userOccupationInfos) {
            _loc4_ = this.occupationData.getUserInfo(_loc2_.userId);
            if (_loc4_ == null) {
                this.occupationData.userOccupationInfos.addItem(_loc2_);
            }
            else if (!_loc4_.equalsTo(_loc2_)) {
                _loc4_.update(_loc2_);
                _loc4_.dirtyNormalized = true;
            }
        }
        for each(_loc3_ in this.occupationData.userOccupationInfos) {
            _loc5_ = param1.occupationData.getUserInfo(_loc3_.userId);
            if (_loc5_ == null) {
                this.occupationData.userOccupationInfos.removeItemAt(this.occupationData.userOccupationInfos.getItemIndex(_loc3_));
            }
        }
        this.occupationData.dirty = true;
    }

    private function updateCommonData(param1:UserGameData):void {
        if (param1.commonData == null) {
            return;
        }
        this.commonData.boughtTroopKitIds = param1.commonData.boughtTroopKitIds;
        this.commonData.boughtResourceKitIds = param1.commonData.boughtResourceKitIds;
        this.commonData.specialOffers = param1.commonData.specialOffers;
        this.commonData.kitsDirty = true;
        this.commonData.specialOffersDirty = true;
        this.commonData.isVip = param1.commonData.isVip;
    }

    private function updateEffectData(param1:UserGameData):void {
        if (param1.effectData == null) {
            return;
        }
        this.effectData.effectsList = param1.effectData.effectsList;
        this.effectData.dirty = true;
    }

    private function updateEpicBattleData(param1:UserGameData):void {
        if (this.epicBattlesData == null || param1.epicBattlesData == null) {
            return;
        }
        this.epicBattlesData.battlesLiked = param1.epicBattlesData.battlesLiked;
        this.epicBattlesData.hasUnreadBattles = param1.epicBattlesData.hasUnreadBattles;
        this.epicBattlesData.dirty = true;
    }

    private function updateStatsData(param1:UserGameData):void {
        if (this.statsData == null || param1.statsData == null) {
            return;
        }
        this.statsData.achievements = param1.statsData.achievements;
        this.statsData.allianceAchievements = param1.statsData.allianceAchievements;
        this.statsData.bonuses = param1.statsData.bonuses;
        this.statsData.minedResources = param1.statsData.minedResources;
        this.statsData.treasuresCollected = param1.statsData.treasuresCollected;
        this.statsData.reachedTop10 = param1.statsData.reachedTop10;
        this.statsData.wonRating = param1.statsData.wonRating;
        this.statsData.liberatedOtherSectors = param1.statsData.liberatedOtherSectors;
        this.statsData.reinforcementTroopsSent = param1.statsData.reinforcementTroopsSent;
        this.statsData.functionalBuildingsFinished = param1.statsData.functionalBuildingsFinished;
        this.statsData.functionalBuildingsUpgraded = param1.statsData.functionalBuildingsUpgraded;
        this.statsData.decorBuildingsFinished = param1.statsData.decorBuildingsFinished;
        this.statsData.defensiveBuildingsFinished = param1.statsData.defensiveBuildingsFinished;
        this.statsData.technologiesLearned = param1.statsData.technologiesLearned;
        this.statsData.technologiesUpgraded = param1.statsData.technologiesUpgraded;
        this.statsData.infantryTroopsBuilt = param1.statsData.infantryTroopsBuilt;
        this.statsData.armouredTroopsBuilt = param1.statsData.armouredTroopsBuilt;
        this.statsData.artilleryTroopsBuilt = param1.statsData.artilleryTroopsBuilt;
        this.statsData.aerospaceTroopsBuilt = param1.statsData.aerospaceTroopsBuilt;
        this.statsData.attackingTroopsBuilt = param1.statsData.attackingTroopsBuilt;
        this.statsData.defensiveTroopsBuilt = param1.statsData.defensiveTroopsBuilt;
        this.statsData.successfulIntelligenceCount = param1.statsData.successfulIntelligenceCount;
        this.statsData.reconTroopsBuilt = param1.statsData.reconTroopsBuilt;
        this.statsData.friendsInvitedCount = param1.statsData.friendsInvitedCount;
        this.statsData.ownOffersAccepted = param1.statsData.ownOffersAccepted;
        this.statsData.cyborgsCreated = param1.statsData.cyborgsCreated;
        this.statsData.isDepositor = param1.statsData.isDepositor;
        this.statsData.lastDepositDate = param1.statsData.lastDepositDate;
        this.statsData.clanMembers = param1.statsData.clanMembers;
        this.statsData.registeredFriends = param1.statsData.registeredFriends;
        this.statsData.friendsReached15 = param1.statsData.friendsReached15;
        this.statsData.invitationSent = param1.statsData.invitationSent;
        this.statsData.successfulAttackCount = param1.statsData.successfulAttackCount;
        this.statsData.allianceDailyQuestCompleted = param1.statsData.allianceDailyQuestCompleted;
        this.statsData.vipDailyQuestCompleted = param1.statsData.vipDailyQuestCompleted;
        this.statsData.caravansSent = param1.statsData.caravansSent;
        this.statsData.dailyQuestCompleted = param1.statsData.dailyQuestCompleted;
        if (this.statsData.goldMoneyJournal != param1.statsData.goldMoneyJournal) {
            this.statsData.goldMoneyJournal = param1.statsData.goldMoneyJournal;
            this.statsData.journalDirty = true;
        }
        if (this.statsData.depositsCount != param1.statsData.depositsCount) {
            this.statsData.depositsCount = param1.statsData.depositsCount;
            this.statsData.depositsDirty = true;
        }
        this.statsData.freeGiftsInfo = param1.statsData.freeGiftsInfo;
        this.statsData.statsDirty = true;
        this.statsData.achievementsDirty = true;
        this.statsData.giftsDirty = true;
    }

    public function getBuyStatus(param1:GeoSceneObject, param2:int, param3:Boolean = false):int {
        var _loc8_:Array = null;
        var _loc9_:int = 0;
        var _loc10_:GeoSceneObject = null;
        var _loc11_:int = 0;
        var _loc12_:RequiredObject = null;
        var _loc13_:int = 0;
        var _loc4_:GeoSceneObjectType = param1.objectType;
        var _loc5_:SaleableLevelInfo = param1.getSaleableLevelInfo();
        var _loc6_:SaleableTypeInfo = _loc4_.saleableInfo;
        if (_loc6_ == null || param2 == 1 && _loc6_.limit == 0) {
            return BuyStatus.OBJECT_CANNOT_BE_BOUGHT;
        }
        if (param2 == 1) {
            if (_loc4_.technologyInfo != null) {
                if (this.technologyCenter.getTechnology(_loc4_.id).getLevel() > 0) {
                    return BuyStatus.OBJECT_LIMIT_REACHED;
                }
            }
            if (_loc4_.buildingInfo != null) {
                _loc8_ = null;
                if (_loc6_.requiresAllExistingMaxLevel) {
                    _loc8_ = this.sector.getBuildings(_loc4_.id);
                    _loc9_ = _loc6_.levelsCount;
                    for each(_loc10_ in _loc8_) {
                        if (_loc10_.getLevel() != _loc9_) {
                            return BuyStatus.EXISTING_OBJECTS_OF_SAME_TYPE_SHOULD_HAVE_MAX_LEVEL;
                        }
                    }
                }
                if (GameType.isMilitary && _loc4_.isRobot && _loc4_.id != BuildingTypeId.RobotRepair) {
                    if (this.sector.defensiveObjectsWall == 20) {
                        if (UserManager.user.gameData.sector.hasActiveBuilding(BuildingTypeId.RobotBoostResources, 1)) {
                            return BuyStatus.OBJECT_CAN_BE_BOUGHT;
                        }
                        if (_loc4_.id == BuildingTypeId.RobotBoostResources) {
                            return BuyStatus.OBJECT_CAN_BE_BOUGHT;
                        }
                        return BuyStatus.OBJECT_LIMIT_REACHED;
                    }
                }
                if (_loc8_ != null) {
                    if (_loc8_.length >= _loc6_.limit) {
                        return BuyStatus.OBJECT_LIMIT_REACHED;
                    }
                }
                else if (this.sector.getBuildingsCount(_loc4_.id) >= _loc6_.limitWithBonuses(_loc4_.id)) {
                    return BuyStatus.OBJECT_LIMIT_REACHED;
                }
                if ((_loc4_.isPerimeter || GameType.isMilitary && _loc4_.isDecorForSectorAndWalls) && _loc4_.isDefensiveKind(DefensiveKind.TOWER) && this.sector.towersCount >= 12) {
                    return BuyStatus.OBJECT_LIMIT_REACHED;
                }
                if (_loc4_.isPerimeter && _loc4_.isDefensiveKind(DefensiveKind.GATE) && this.sector.gatesCount >= 4) {
                    return BuyStatus.OBJECT_LIMIT_REACHED;
                }
                if (_loc4_.isDecorForWalls && _loc4_.isTurret && this.sector.defensiveObjectsWall >= this.sector.getMaxDefenseObjectsAllowed()) {
                    return BuyStatus.OBJECT_LIMIT_REACHED;
                }
            }
        }
        if (param2 > _loc6_.levelsCount) {
            return BuyStatus.MAXIMUM_LEVEL_REACHED;
        }
        if (this.account.level < _loc6_.getLevelInfo(param2).requiredUserLevel) {
            return BuyStatus.LOW_USER_LEVEL;
        }
        if (param1.missingResources != null || !(param1.type.id != BuildingTypeId.LogisticsCenter || _loc5_ && UserManager.user.gameData.invitationData.constructionBlockCount >= _loc5_.constructionBlockPrize)) {
            return BuyStatus.NOT_ENOUGH_RESOURCES;
        }
        if (!param3 && this.objectFromSameGroupIsInProgress(_loc4_)) {
            return BuyStatus.OBJECT_OF_SAME_GROUP_IN_PROGRESS;
        }
        var _loc7_:SaleableLevelInfo = _loc6_.getLevelInfo(param2);
        if (!param3 && _loc7_ && _loc7_.requiredObjects) {
            _loc11_ = 0;
            while (_loc11_ < _loc7_.requiredObjects.length) {
                _loc12_ = _loc7_.requiredObjects[_loc11_] as RequiredObject;
                if (_loc12_.requiredType == RequiredType.BLACK_MARKET_PACK_ITEM) {
                    _loc13_ = this.blackMarketData.boughtCountByItemPackId[_loc12_.typeId];
                    if (_loc13_ < _loc12_.count) {
                        return BuyStatus.NOT_ENOUGHT_BLACK_MARKET_ITEMS;
                    }
                }
                _loc11_++;
            }
        }
        return BuyStatus.OBJECT_CAN_BE_BOUGHT;
    }

    public function objectAdditionalWorkerNotEnoughTime(param1:GeoSceneObject):Boolean {
        var _loc3_:SaleableLevelInfo = null;
        var _loc4_:int = 0;
        var _loc5_:Date = null;
        var _loc2_:Boolean = false;
        if (UserManager.user.gameData.constructionData.additionalWorkersExpireDateTimes && UserManager.user.gameData.constructionData.additionalWorkersExpireDateTimes.length != 0 && UserManager.user.gameData.constructionData.additionalWorkersUsed) {
            _loc3_ = param1.getSaleableLevelInfo();
            if (_loc3_) {
                for each(_loc5_ in UserManager.user.gameData.constructionData.additionalWorkersExpireDateTimes) {
                    _loc4_ = (_loc5_.time - ServerTimeManager.serverTimeNow.time) / 1000;
                    if (_loc3_.constructionSeconds > _loc4_) {
                        _loc2_ = true;
                    }
                }
            }
        }
        return _loc2_;
    }

    public function objectFromSameGroupIsInProgress(param1:GeoSceneObjectType):Boolean {
        var _loc2_:Boolean = false;
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:GeoSceneObject = null;
        if (param1.technologyInfo != null) {
            return this.technologyCenter.technologiesResearching > 0;
        }
        if (param1.buildingInfo != null) {
            _loc2_ = param1.buildingInfo.isFunctional;
            if (!_loc2_) {
                return false;
            }
            if (param1.id == BuildingTypeId.RobotBoostResources) {
                return false;
            }
            if (this._constructionData.workersUsed == -1) {
                _loc5_ = 0;
                for each(_loc6_ in this.sector.sectorScene.sceneObjects) {
                    if (_loc6_.buildingInProgress && _loc6_.buildingInfo.broken == false && _loc6_.type.id != BuildingTypeId.RobotBoostResources) {
                        _loc5_++;
                    }
                }
                this._constructionData.workersUsed = _loc5_;
            }
            _loc3_ = 0;
            _loc3_ = this._constructionData.additionalWorkersExpireDateTimes != null ? int(this._constructionData.additionalWorkersExpireDateTimes.length) : 0;
            _loc4_ = this._constructionData.constructionWorkersCount + _loc3_;
            if (_loc4_ == 0) {
                _loc4_ = 1;
            }
            if (this._constructionData.workersUsed >= _loc4_) {
                return true;
            }
        }
        return false;
    }

    public function checkRequirements(param1:GeoSceneObjectType):Boolean {
        return this.checkRequirementsByObjects(param1.saleableInfo.requiredObjects);
    }

    public function checkRequirementsByObjects(param1:ArrayCustom):Boolean {
        var _loc2_:RequiredObject = null;
        for each(_loc2_ in param1) {
            if (!this.hasRequiredObject(_loc2_)) {
                return false;
            }
        }
        return true;
    }

    public function getRequiredDrawingType(param1:GeoSceneObjectType):GeoSceneObjectType {
        var _loc3_:RequiredObject = null;
        var _loc4_:GeoSceneObjectType = null;
        var _loc2_:SaleableTypeInfo = param1.saleableInfo;
        if (_loc2_ == null) {
            return null;
        }
        for each(_loc3_ in _loc2_.requiredObjects) {
            _loc4_ = StaticDataManager.getObjectType(_loc3_.typeId);
            if (_loc4_.drawingInfo != null) {
                return _loc4_;
            }
        }
        return null;
    }

    private function getComplexId(param1:int, param2:int, param3:int):* {
        return "id:" + param1 + ",l:" + param2 + ",c:" + param3;
    }

    public function hasRequiredObject(param1:RequiredObject):Boolean {
        var _loc2_:int = param1.typeId;
        var _loc3_:int = param1.level;
        var _loc4_:int = param1.count;
        var _loc5_:* = this.getComplexId(_loc2_, _loc3_, _loc4_);
        if (!this.buyStatusBySceneObject.hasOwnProperty(_loc5_)) {
            this.buyStatusBySceneObject[_loc5_] = this.sector.hasActiveBuilding(_loc2_, _loc3_, _loc4_) || this.technologyCenter.hasActiveTechnology(_loc2_, _loc3_) || this.drawingArchive.hasCompleteDrawing(_loc2_);
        }
        return this.buyStatusBySceneObject[_loc5_];
    }

    public function resetBuyStatusBySceneObject():void {
        this.buyStatusBySceneObject = new Dictionary();
    }

    public function updateObjectsBuyStatus(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false):void {
        var _loc4_:GeoSceneObject = null;
        var _loc5_:GeoSceneObject = null;
        this.buyingData.updateStatus(this, param1, param2 || param3);
        for each(_loc4_ in this.sector.sectorScene.sceneObjects) {
            UserBuyingData.updateObjectStatus(_loc4_, this, param1, param2);
        }
        for each(_loc5_ in this.technologyCenter.technologies) {
            UserBuyingData.updateObjectStatus(_loc5_, this, param1, param2);
        }
    }

    public function getTechnologyUpgradeBonus(param1:GeoSceneObjectType, param2:int):TechnologyUpgradeRequirement {
        var _loc3_:SaleableLevelInfo = null;
        var _loc4_:int = 0;
        var _loc5_:RequiredObject = null;
        var _loc6_:TechnologyUpgradeRequirement = null;
        if (param2 == -1) {
            return null;
        }
        if (param1.saleableInfo != null) {
            _loc3_ = param1.saleableInfo.getLevelInfo(param2);
            if (_loc3_.requiredObjects) {
                _loc4_ = 0;
                while (_loc4_ < _loc3_.requiredObjects.length) {
                    _loc5_ = _loc3_.requiredObjects[_loc4_];
                    if (_loc5_.requiredType == RequiredType.BLACK_MARKET_PACK_ITEM) {
                        _loc6_ = new TechnologyUpgradeRequirement();
                        _loc6_.isHighLevel = _loc5_.typeId == 101;
                        _loc6_.requiredItemsCount = _loc5_.count;
                        return _loc6_;
                    }
                    _loc4_++;
                }
            }
        }
        return null;
    }

    public function getBuildingUpgradeBonus(param1:GeoSceneObjectType, param2:int):int {
        var _loc3_:SaleableLevelInfo = null;
        var _loc4_:int = 0;
        var _loc5_:RequiredObject = null;
        if (param2 == -1) {
            return -1;
        }
        if (param1.saleableInfo != null) {
            _loc3_ = param1.saleableInfo.getLevelInfo(param2);
            if (_loc3_.requiredObjects) {
                _loc4_ = 0;
                while (_loc4_ < _loc3_.requiredObjects.length) {
                    _loc5_ = _loc3_.requiredObjects[_loc4_];
                    if (_loc5_.requiredType == RequiredType.BLACK_MARKET_PACK_ITEM) {
                        return _loc5_.count;
                    }
                    _loc4_++;
                }
            }
        }
        return -1;
    }

    public function getPrice(param1:User, param2:GeoSceneObjectType, param3:int, param4:GeoSceneObject = null, param5:GeoSceneObjectType = null, param6:Boolean = false, param7:Boolean = false):Resources {
        var _loc8_:Resources = null;
        var _loc9_:Dictionary = null;
        var _loc10_:ArtifactTypeInfo = null;
        var _loc11_:Number = NaN;
        if (param2.buildingInfo != null) {
            if (GameType.isMilitary && param2.isPerimeterBuildings) {
                if (param2.isDecorForSector && !this.sector.hasDecorForSectorBuilding(param2.buildingInfo.defensiveKind, param4) || param2.isDecorForSectorAndWalls && !this.sector.hasDecorForSectorAndWallsBuilding(param2.buildingInfo.defensiveKind, param4)) {
                    return Resources.fromGoldMoney(DEFAULT_PRICE);
                }
            }
            if (param2.isPerimeter) {
                if (GameType.isNords) {
                    if (param2.id == BuildingTypeId.WallLevel1Gate && param3 != -1 || param2.isRobot && !this.sector.hasOutsideRobotBuilding()) {
                        return param2.saleableInfo.getLevelInfo(param3).price;
                    }
                    if (param2.id == BuildingTypeId.Robot1 && this.constructionData.hasDiscountForBuildingRobot) {
                        return Resources.fromGoldMoney(DEFAULT_PRICE);
                    }
                }
                else if (!this.sector.hasDefensiveBuilding(param2.buildingInfo.defensiveKind, param4) && StaticDataManager.defensiveInformation != null && StaticDataManager.defensiveInformation.IsDefensiveObjectLevelEqualOrLess(param2.id, 1)) {
                    return Resources.fromGoldMoney(DEFAULT_PRICE);
                }
            }
            if ((param2.id == BuildingTypeId.GunTurrets || param2.id == BuildingTypeId.MissileTurrets) && !(this.sector.hasAnyBuilding(BuildingTypeId.BUILDING_IDS_TURRETS, param4) || this.sector.hasAnyBuilding(BuildingTypeId.BUILDING_IDS_MISSILE_TURRETS, param4))) {
                return Resources.fromGoldMoney(DEFAULT_PRICE);
            }
            if (param2.id == BuildingTypeId.Detectors && !this.sector.hasAnyBuilding(BuildingTypeId.BUILDING_IDS_DETECTORS, param4)) {
                return Resources.fromGoldMoney(25);
            }
        }
        if (param7) {
            return BuildingManager.getBuildingInstantPriceByObjectType(param2, param3);
        }
        if (param3 >= 1 && param2.saleableInfo != null) {
            _loc8_ = !!param6 ? param2.saleableInfo.getLevelInfo(param3).goldPrice : param2.saleableInfo.getLevelInfo(param3).price;
            if (param6 && _loc8_ == null) {
                return null;
            }
            if (param2.id == BuildingTypeId.LogisticsCenter && param2.buildingInfo != null) {
                _loc8_.idols = int(param2.saleableInfo.getLevelInfo(param3).constructionBlockPrize);
            }
            _loc8_ = _loc8_.clone();
            if (param6) {
                return _loc8_;
            }
            if ((GameType.isElves || GameType.isMilitary) && (param2.id == BuildingTypeId.Bank || param2.id == BuildingTypeId.Warehouse) && this.sector.hasActiveBuilding(param2.id, param2.buildingInfo.levelInfos.length)) {
                _loc8_.scale(StaticDataManager.bankAndWarehousePriceAndTimeCoef);
            }
            _loc9_ = param1.gameData.artifactData.getBonusesByAffectedTypes(null);
            _loc10_ = _loc9_[param2.id];
            if (_loc10_ != null && !isNaN(_loc10_.priceBonus)) {
                _loc11_ = 1 - _loc10_.priceBonus / 100;
                _loc8_.money = _loc8_.money * _loc11_;
                _loc8_.uranium = _loc8_.uranium * _loc11_;
                _loc8_.titanite = _loc8_.titanite * _loc11_;
                _loc8_.biochips = _loc8_.biochips * _loc11_;
            }
            if (param2.buildingInfo != null && param5 != null) {
                _loc8_.substract(param5.saleableInfo.getLevelInfo(param3).price);
            }
            return _loc8_;
        }
        return new Resources(0, 0, 0, 0);
    }

    public function getDefenceBonusPoints():Number {
        if (this.artifactData != null) {
            return this.artifactData.GetSectorDefenseBonus();
        }
        return 0;
    }

    public function getIntelligengeBonusPoints():Number {
        if (this.artifactData != null) {
            return this.artifactData.GetSectorIntelligenceDefenseBonus();
        }
        return 0;
    }

    public function raiseCaravanLimitsChanged():void {
        dispatchEvent(CARAVAN_LIMITS_CHANGED);
    }

    override public function addEventHandler(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        super.addEventHandler(param1, param2, param3, param4, param5);
    }

    public function get constructionData():ConstructionData {
        return this._constructionData;
    }

    public function set constructionData(param1:ConstructionData):void {
        this._constructionData = param1;
    }
}
}
