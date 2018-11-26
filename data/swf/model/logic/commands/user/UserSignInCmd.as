package model.logic.commands.user {
import common.ArrayCustom;
import common.localization.LocaleDict;
import common.localization.LocaleUtil;

import configs.Global;

import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.external.ExternalInterface;
import flash.utils.Dictionary;

import integration.SocialNetworkIdentifier;
import integration.billing.Billing;
import integration.facebook.MobilePaymentsInfo;

import json.JSONOur;

import model.data.DiscountPricePackManager;
import model.data.Resources;
import model.data.ResourcesKit;
import model.data.SectorExtension;
import model.data.SectorSkinType;
import model.data.TroopsKit;
import model.data.User;
import model.data.UserSocialData;
import model.data.acceleration.types.ResourceMiningBoostType;
import model.data.alliances.AllianceMemberRankId;
import model.data.alliances.AllianceNote;
import model.data.clientInfo.ClientInfo;
import model.data.defensiveData.StaticDefensiveInformation;
import model.data.discountOffers.DiscountOfferType;
import model.data.effects.BlackMarketItemGroupLimit;
import model.data.giftPoints.StaticGiftPointsProgramData;
import model.data.globalEvent.GlobalEvent;
import model.data.locations.LocationNote;
import model.data.lottery.TicketTypeInfo;
import model.data.misc.FacebookPrice;
import model.data.raids.GlobalMissionManager;
import model.data.raids.GlobalMissionUIData;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.users.UserNote;
import model.data.users.bonuses.Bonus;
import model.data.users.messages.GlobalMessage;
import model.data.users.raids.RaidLocationStoryType;
import model.data.wisdomSkills.WisdomSkillsData;
import model.logic.AllianceActivityStaticData;
import model.logic.AllianceManager;
import model.logic.AllianceNoteManager;
import model.logic.ErrorManager;
import model.logic.GlobalMessageManager;
import model.logic.LocationManager;
import model.logic.LocationNoteManager;
import model.logic.ResourcesKitLimit;
import model.logic.ServerManager;
import model.logic.ServerTimeManager;
import model.logic.StaticAchievementData;
import model.logic.StaticAllianceCityData;
import model.logic.StaticAllianceData;
import model.logic.StaticArtifactData;
import model.logic.StaticBlackMarketData;
import model.logic.StaticBonusData;
import model.logic.StaticConstructionData;
import model.logic.StaticCyborgData;
import model.logic.StaticDataManager;
import model.logic.StaticDrawingData;
import model.logic.StaticInventoryData;
import model.logic.StaticKnownUsersData;
import model.logic.StaticLoyaltyProgramData;
import model.logic.StaticMineData;
import model.logic.StaticQuestData;
import model.logic.StaticRaidData;
import model.logic.StaticResurrectionData;
import model.logic.StaticSpecialOfferData;
import model.logic.StaticTowerData;
import model.logic.StaticTroopsTiersData;
import model.logic.StaticUserLevelData;
import model.logic.SurveyManager;
import model.logic.UnitResurrectionHelper;
import model.logic.UserManager;
import model.logic.UserNormalizationManager;
import model.logic.UserNoteManager;
import model.logic.abTest.AbTestHelper;
import model.logic.autoRefresh.AutoRefreshManager;
import model.logic.blackMarketModel.BlackMarketDataInitializer;
import model.logic.character.StaticCharacterData;
import model.logic.chats.ChatManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.FaultDto;
import model.logic.commands.server.JsonCallCmd;
import model.logic.discountOffers.UserDiscountOfferManager;
import model.logic.freeGifts.FreeGiftsManager;
import model.logic.globalEvents.GlobalEventsManager;
import model.logic.journal.JournalAutoRefreshManager;
import model.logic.lotteries.LotteryManager;
import model.logic.misc.SocialManager;
import model.logic.occupation.OccupationManager;
import model.logic.quests.completions.GlobalMissionCurrentState;
import model.logic.quests.completions.GlobalMissionStateTypeId;
import model.logic.quests.completions.QuestCompletion;
import model.logic.quests.data.Quest;
import model.logic.quests.data.QuestState;
import model.logic.resourcesConversion.data.StaticResourcesConversionData;
import model.logic.serverBoost.ServerBoostManager;
import model.logic.skills.data.StaticSkillData;
import model.logic.slots.SlotData;
import model.logic.staticDiscount.StaticDiscountManager;
import model.logic.units.StaticDailyQuestData;
import model.logic.vip.StaticVipData;
import model.modules.allianceCity.logic.AllianceCityManager;
import model.modules.dragonAbilities.data.StaticDragonAbilitiesData;

public class UserSignInCmd extends BaseCmd {


    private var _dto;

    private var _socialId:String;

    private var _hashedId:String;

    private var _userSocialAuthKey:String;

    private var _userSocialAuthSeed:String;

    private var _tracer:Function;

    public function UserSignInCmd(param1:String, param2:UserSocialData, param3:Boolean, param4:ArrayCustom, param5:String, param6:String, param7:Function, param8:String, param9:String = null, param10:Object = null) {
        super();
        var _loc11_:Date = new Date();
        var _loc12_:ClientInfo = new ClientInfo();
        this._dto = {
            "f": param4,
            "i": param5,
            "l": param6,
            "mr": param2.mailruMinigameUserId,
            "t": _loc11_.getTimezoneOffset(),
            "rr": param9 || null,
            "c": _loc12_.toDto()
        };
        this._socialId = param2.socialId;
        this._hashedId = param2.hashedId;
        if (param3) {
            this._dto.s = param2.toDto();
        }
        if (param10) {
            this._dto.fv = param10;
        }
        this._userSocialAuthKey = param1;
        this._userSocialAuthSeed = param8;
        this._tracer = param7;
    }

    override public function execute():void {
        var _loc1_:String = this.getRandomServerAddress();
        this.doSignIn(_loc1_, this._dto, _loc1_ != this.getDefaultServerAddress());
    }

    private function doSignIn(param1:String, param2:*, param3:Boolean):void {
        var address:String = param1;
        var signInDto:* = param2;
        var tryDefaultAddressIfFailed:Boolean = param3;
        JsonCallCmd.setUserCredentials(this._socialId, this._userSocialAuthKey, this._userSocialAuthSeed, this._hashedId);
        var segmentName:String = address.substr(address.lastIndexOf("/") + 1, address.length);
        JsonCallCmd.setDefaultAddress(address);
        this.doTrace("Connecting to " + segmentName);
        if (ExternalInterface.available) {
            ExternalInterface.call("Plarium.Events.beforeSignIn");
        }
        new JsonCallCmd("SignIn", signInDto, "POST").ifResult(function (param1:*):void {
            var x:* = undefined;
            var segmentId:* = undefined;
            var userDto:* = undefined;
            var socialUserDto:* = undefined;
            var dto:* = param1;
            var redirectionSegmentAddress:* = dto.r;
            if (redirectionSegmentAddress != null) {
                doTrace("Redirection to " + redirectionSegmentAddress.substr(redirectionSegmentAddress.lastIndexOf("/") + 1, redirectionSegmentAddress.length));
                doSignIn(redirectionSegmentAddress, signInDto, false);
            }
            else {
                if (ExternalInterface.available) {
                    ExternalInterface.call("Plarium.Events.onSignIn");
                }
                ServerManager.updateSegmentServerAddresses(dto.a);
                segmentId = dto.i;
                JsonCallCmd.setDefaultAddress(ServerManager.SegmentServerAddresses[segmentId]);
                if (dto.c) {
                    LocaleUtil.currentLocale = dto.c;
                    LocaleUtil.serverLocale = dto.c;
                    ServerManager.updateLocale(dto.c);
                }
                ServerTimeManager.initialize(dto.t, dto.u.g.cd.g);
                UserNormalizationManager.RefreshTimeoutMs = dto.e;
                if (dto.al != null) {
                    LotteryManager.updateFromDto(dto.al);
                }
                if (dto.tt != null) {
                    LotteryManager.initializeLotteryTicketTypeInfos(TicketTypeInfo.fromDtos(dto.tt));
                }
                if (ExternalInterface.available) {
                    ExternalInterface.call("Plarium.Events.beforeStaticDataFetched");
                    userDto = dto.u;
                    socialUserDto = !!userDto ? dto.u.s : null;
                    Billing.onRegularPacksLoaded(saveRegularPacks);
                    if (SocialNetworkIdentifier.isPP) {
                        Billing.onPricePacksLoaded(savePortalCurrency);
                    }
                    Billing.initialize();
                    Billing.setIdentity({
                        "appKey": (!!dto.si ? dto.si.ak : null),
                        "segmentId": segmentId,
                        "userGameId": (!!userDto ? userDto.i : null),
                        "userSocialId": (!!socialUserDto ? socialUserDto.i : null),
                        "userIp": dto.ip,
                        "gameLocale": LocaleUtil.currentLocale,
                        "gameSessionId": dto.k
                    });
                    if (SocialNetworkIdentifier.isFB) {
                        Billing.onFbMobileRatesLoaded(saveMobileRates);
                    }
                }
                if (dto.pop != null) {
                    DiscountPricePackManager.addPacksDto(dto.pop);
                }
                doTrace("Getting static data...");
                new StaticDataGetCmd(dto.s).ifResult(function (param1:*):void {
                    var _loc24_:* = undefined;
                    var _loc25_:* = undefined;
                    var _loc26_:* = undefined;
                    var _loc27_:* = undefined;
                    var _loc28_:* = undefined;
                    var _loc29_:* = undefined;
                    if (ExternalInterface.available) {
                        ExternalInterface.call("Plarium.Events.onStaticDataFetched");
                    }
                    if (param1.nbe) {
                        StaticDataManager.newBalanceEnabled = Boolean(param1.nbe);
                    }
                    var _loc2_:* = GeoSceneObjectType.fromDtos(param1.sot);
                    var _loc3_:* = SectorExtension.fromDtos(param1.se);
                    var _loc4_:* = param1.cc;
                    var _loc5_:* = param1.cs;
                    LocaleDict.initializeByServer(param1.cl);
                    var _loc6_:* = dto.z == null ? [] : dto.z;
                    Global.setServerSettings(_loc6_);
                    ErrorManager.addServerConfiguredCodes();
                    StaticDataManager.initialize(_loc2_, _loc3_, _loc4_, _loc5_);
                    StaticDataManager.freeTroopsMaxOrderSize = param1.ft == null ? 100 : int(param1.ft);
                    StaticDataManager.levelData = StaticUserLevelData.fromDto(param1.ld);
                    StaticDataManager.knownUsersData = StaticKnownUsersData.fromDto(param1.ku);
                    StaticDataManager.troopsPerSceneObject = param1.tps;
                    StaticDataManager.resourceMiningBoostTypes = ResourceMiningBoostType.fromDtos(param1.rmt);
                    StaticDataManager.resourcesKits = ResourcesKit.fromDtos(param1.rc);
                    StaticDataManager.resourcesKitsLimits = ResourcesKitLimit.fromDtos(param1.rl);
                    StaticDataManager.troopsKits = TroopsKit.fromDtos(param1.tc);
                    StaticDataManager.instantObjectPrice15Minutes = param1.ip15m == null ? null : Resources.fromDto(param1.ip15m);
                    StaticDataManager.instantObjectPrice30Minutes = param1.ip30m == null ? null : Resources.fromDto(param1.ip30m);
                    StaticDataManager.instantObjectPrice1Hour = param1.ip1 == null ? null : Resources.fromDto(param1.ip1);
                    StaticDataManager.instantObjectPrice5Hours = Resources.fromDto(param1.ip5);
                    StaticDataManager.instantObjectPrice10Hours = Resources.fromDto(param1.ip10);
                    StaticDataManager.instantObjectPrice10PlusHours = Resources.fromDto(param1.ip);
                    StaticDataManager.instantTroopsOrderPrice = Resources.fromDto(param1.io);
                    StaticDataManager.instantUnitReturnPricePerHour = Resources.fromDto(param1.ir);
                    StaticDataManager.freeBoostMinutes = param1.fbm;
                    StaticDataManager.instantObjectHours = param1.ih == null ? new ArrayCustom() : new ArrayCustom(param1.ih);
                    StaticDataManager.instantObjectMinPrice = param1.mp;
                    StaticDataManager.instantObjectMaxPrice = param1.xp;
                    StaticDataManager.instantObjectPricePerHour = param1.ph == null ? new ArrayCustom() : new ArrayCustom(param1.ph);
                    StaticDataManager.boostCoef = param1.sbc;
                    StaticDataManager.constrCoef = param1.scc;
                    StaticDataManager.totalCoef = param1.stc;
                    StaticDataManager.crystalsPerResourceUnit = param1.cpr;
                    StaticDataManager.crystalsPerConstructionItem = param1.cpc;
                    StaticDataManager.instantTroopsOrderPricePerHour = param1.it;
                    StaticDataManager.instantTroopsOrderMinPrice = param1.zp;
                    StaticDataManager.bankAndWarehousePriceAndTimeCoef = param1.bw;
                    StaticDataManager.additionalStorage = param1.al == null ? Number(0) : Number(param1.al);
                    StaticDataManager.freeTechnologiesResearchedMiningBonusCoeff = param1.trb = !!null ? new Resources() : Resources.fromDto(param1.trb);
                    StaticDataManager.boostMaxLimitGoldMoney = param1.bmx;
                    StaticDataManager.bonusReducesTime = Boolean(param1.brt);
                    StaticDataManager.loaltyProgramDays = param1.lpd;
                    StaticDataManager.loaltyProgramGoldMoneyBonus = param1.lpb;
                    StaticDataManager.skilledUserDays = param1.sud;
                    StaticDataManager.skilledUserLevel = param1.sul;
                    StaticDataManager.noviceUserLevel = param1.nul;
                    StaticDataManager.achievementData = param1.sad == null ? null : StaticAchievementData.fromDto(param1.sad);
                    StaticDataManager.sectorSkinTypes = param1.ss == null ? null : SectorSkinType.fromDtos(param1.ss);
                    StaticDataManager.mineData = param1.smd == null ? null : StaticMineData.fromDto(param1.smd);
                    StaticDataManager.specialOfferData = param1.sod == null ? null : StaticSpecialOfferData.fromDto(param1.sod);
                    StaticDataManager.userMessagesPerDayLimit = param1.uml == null ? 250 : int(param1.uml);
                    StaticDataManager.maximumBattleReportLossesThreshold = param1.bt == null ? 5 : int(param1.bt);
                    StaticDataManager.cyborgData = param1.scd == null ? new StaticCyborgData() : StaticCyborgData.fromDto(param1.scd);
                    StaticDataManager.artifactData = param1.ad == null ? new StaticArtifactData() : StaticArtifactData.fromDto(param1.ad);
                    StaticDataManager.drawingData = param1.sdd = !!null ? new StaticDrawingData() : StaticDrawingData.fromDto(param1.sdd);
                    StaticDataManager.allianceData = param1.yd == null ? new StaticAllianceData() : StaticAllianceData.fromDto(param1.yd);
                    StaticDataManager.allianceCityData = param1.acd == null ? new StaticAllianceCityData() : StaticAllianceCityData.fromDto(param1.acd);
                    StaticDataManager.towerData = param1.td == null ? new StaticTowerData() : StaticTowerData.fromDto(param1.td);
                    StaticDataManager.bonusData = param1.bd == null ? new StaticBonusData() : StaticBonusData.fromDto(param1.bd);
                    StaticDataManager.blackMarketData = param1.bk == null ? new StaticBlackMarketData() : StaticBlackMarketData.fromDto(param1.bk);
                    StaticDataManager.blackMarketData.blackMarketItemGroupsLimitItems = BlackMarketItemGroupLimit.fromDtos(param1.gli);
                    StaticDataManager.loyaltyProgramData = param1.lp == null ? new StaticLoyaltyProgramData() : StaticLoyaltyProgramData.fromDto(param1.lp);
                    var _loc7_:* = param1.rd == null ? new StaticRaidData() : StaticRaidData.fromDto(param1.rd);
                    if (_loc7_) {
                        StaticDataManager.raidData = _loc7_;
                    }
                    StaticDataManager.resurrectionData = param1.sx == null ? new StaticResurrectionData() : StaticResurrectionData.fromDto(param1.sx);
                    StaticDataManager.skillData = param1.sa == null ? new StaticSkillData() : StaticSkillData.fromDto(param1.sa);
                    StaticDataManager.dragonAbilitiesData = param1.at == null ? new StaticDragonAbilitiesData() : StaticDragonAbilitiesData.fromDto(param1.at);
                    StaticDataManager.resourcesConversionData = param1.bc == null ? new StaticResourcesConversionData() : StaticResourcesConversionData.fromDto(param1.bc);
                    StaticDataManager.constructionData = param1.sc == null ? new StaticConstructionData() : StaticConstructionData.fromDto(param1.sc);
                    StaticDataManager.dailyQuestData = param1.dd == null ? new StaticDailyQuestData() : StaticDailyQuestData.fromDto(param1.dd);
                    StaticDataManager.vipData = param1.vd == null ? new StaticVipData() : StaticVipData.fromDto(param1.vd);
                    StaticDataManager.questData = param1.sqd == null ? new StaticQuestData() : StaticQuestData.fromDto(param1.sqd);
                    StaticDataManager.MaxLevelAttack = param1.mla;
                    StaticDataManager.MaxLevelRobbery = param1.mlr;
                    StaticDataManager.MaxLevelReinforcement = param1.mlf;
                    StaticDataManager.MaxLevelOccupation = param1.mlo;
                    StaticDataManager.MaxTowersPerSector = param1.mt;
                    StaticDataManager.MaxGatesPerSector = param1.mg;
                    StaticDataManager.DefenseObjectsPerGates = param1.dpg;
                    StaticDataManager.MaxDefenseObjects = param1.mdo;
                    StaticDataManager.RaidLevelupLocationMaxLevel = param1.rlmax;
                    StaticDataManager.WizardTaskCount = dto.wtc == null ? Number(-1) : Number(dto.wtc);
                    StaticDataManager.minimalMoneyBalance = param1.mmb == null ? Number(-100000) : Number(param1.mmb);
                    StaticDataManager.minDegradationMiningValue = param1.dmin == null ? Number(100) : Number(param1.dmin);
                    StaticDataManager.maxDegradationMiningValue = param1.dmax == null ? Number(200) : Number(param1.dmax);
                    StaticDataManager.raidLocationStoryTypes = param1.rst == null ? new ArrayCustom() : RaidLocationStoryType.fromDtos(param1.rst);
                    StaticDataManager.tournamentCollectedResourcesCoefs = param1.crg == null ? null : Resources.fromDto(param1.crg);
                    StaticDataManager.bonusRefreshesMaxCountRaid = param1.brl;
                    StaticDataManager.maxActiveLocations = param1.rla;
                    StaticDataManager.maxNewLocationsPerRefresh = param1.rlr;
                    StaticDataManager.plariumTowerIds = param1.pti;
                    StaticDataManager.plariumAllianceId = param1.pai;
                    StaticDataManager.wisdomSkillsData = param1.ws != null ? WisdomSkillsData.fromDto(param1.ws) : null;
                    StaticDataManager.giftPointsProgramData = param1.gp != null ? StaticGiftPointsProgramData.fromDto(param1.gp) : null;
                    StaticDataManager.defensiveInformation = StaticDefensiveInformation.fromDto(param1.sdi);
                    StaticDataManager.allianceActivityData = param1.aap != null ? AllianceActivityStaticData.fromDto(param1.aap) : null;
                    if (param1.id) {
                        StaticDataManager.InventoryData = StaticInventoryData.fromDto(param1.id);
                    }
                    if (param1.shd) {
                        StaticDataManager.characterData = StaticCharacterData.fromDto(param1.shd);
                    }
                    if (param1.hasOwnProperty("drl")) {
                        StaticDataManager.DailyIncomingResourcesLimit = Resources.fromDto(param1.drl);
                    }
                    if (_loc7_ && _loc7_.raidLocationTypes && _loc7_.raidLocationTypes.length > 0) {
                        StaticDataManager.addRaidLocationTypes(_loc7_.raidLocationTypes);
                    }
                    if (StaticDataManager.raidLocationStoryTypes.length > 0) {
                        for each(_loc24_ in StaticDataManager.raidLocationStoryTypes) {
                            if (_loc24_.raidLocationTypes && _loc24_.raidLocationTypes.length > 0) {
                                StaticDataManager.addRaidLocationTypes(_loc24_.raidLocationTypes);
                            }
                        }
                    }
                    StaticDataManager.isNeedToShowPermissionsWindow = !!dto.hasOwnProperty("pw") ? Boolean(Boolean(dto.pw)) : false;
                    if (param1.us != null) {
                        StaticDataManager.unitSlotPrices = new Dictionary();
                        for (_loc25_ in param1.us) {
                            StaticDataManager.unitSlotPrices[_loc25_] = Resources.fromDto(param1.us[_loc25_]);
                        }
                    }
                    var _loc8_:* = new Date(dto.t);
                    var _loc9_:* = dto.n;
                    var _loc10_:* = false;
                    if (dto.hasOwnProperty("kb")) {
                        _loc10_ = dto.kb;
                    }
                    StaticDataManager.sectorSlotsData.slotSizeData = param1.tt == null ? null : param1.tt.z;
                    StaticDataManager.sectorSlotsData.slotsAll = param1.tt == null ? null : SlotData.fromDtos(param1.tt.s);
                    if (param1.tt != null) {
                        StaticDataManager.sectorSlotsData.slotsExtensionPack = param1.sse == null ? null : param1.sse;
                        StaticDataManager.sectorSlotsData.slotsExtensionPrice = param1.sep == null ? null : param1.sep;
                    }
                    if (param1.blc2 != null) {
                        for (_loc26_ in param1.blc2) {
                            StaticDataManager.BlueLightDepositTypes[_loc26_] = param1.blc2[_loc26_];
                        }
                    }
                    if (param1.gpc != null) {
                        for (_loc27_ in param1.gpc) {
                            StaticDataManager.GiftPointsCurrencies[_loc27_] = param1.gpc[_loc27_];
                        }
                    }
                    if (param1.blc3 != null) {
                        for (_loc28_ in param1.blc3) {
                            StaticDataManager.BlueLightCurrencies[_loc28_] = param1.blc3[_loc28_];
                        }
                    }
                    if (param1.gpcp != null) {
                        for (_loc29_ in param1.gpcp) {
                            StaticDataManager.GiftPointsCurrenciesPortal[_loc29_] = param1.gpcp[_loc29_];
                        }
                    }
                    StaticDataManager.troopsTiersData = param1.ti != null ? StaticTroopsTiersData.fromDto(param1.ti) : new StaticTroopsTiersData();
                    var _loc11_:* = User.fromDto(dto.u);
                    if (SocialNetworkIdentifier.socialService.isUserAnonymous) {
                        SocialNetworkIdentifier.socialService.loadedGData.currentUserProfile.name = _loc11_.socialData.fullName;
                    }
                    var _loc12_:* = dto.f;
                    var _loc13_:* = UserNote.fromDtos(dto.o);
                    var _loc14_:* = dto.l == null ? new ArrayCustom() : LocationNote.fromDtos(dto.l);
                    var _loc15_:* = dto.y == null ? new ArrayCustom() : AllianceNote.fromDtos(dto.y);
                    var _loc16_:* = dto.lb;
                    var _loc17_:* = dto.g;
                    var _loc18_:* = dto.x;
                    var _loc19_:* = dto.b == null ? null : Bonus.fromDtos(dto.b);
                    var _loc20_:* = dto.ipua;
                    var _loc21_:* = dto.ps;
                    UserManager.firstSignInToday = _loc17_;
                    UserManager.registeredToday = _loc18_;
                    UserManager.segmentId = segmentId;
                    UserManager.facebookPrices = FacebookPrice.fromDtos(dto.p);
                    UserManager.isPurchasedPackageForAtLeast20 = dto.be == null ? false : Boolean(dto.be);
                    if (dto.hasOwnProperty(dto.ps)) {
                        UserManager.facebookOfferPrices = FacebookPrice.fromDtos(dto.ps);
                    }
                    if (dto.k != null) {
                        JsonCallCmd.setSessionId(dto.k);
                    }
                    OccupationManager.initialize(dto.ou);
                    StaticDiscountManager.activeStaticDiscounts = GlobalEvent.fromDtos(dto.asd);
                    StaticDiscountManager.upcomingStaticDiscounts = GlobalEvent.fromDtos(dto.usd);
                    ServerBoostManager.activeServerBoosts = GlobalEvent.fromDtos(dto.asb);
                    ServerBoostManager.upcomingServerBoosts = GlobalEvent.fromDtos(dto.usb);
                    GlobalEventsManager.upcomingGlobalEvents = GlobalEvent.fromDtos(dto.uge);
                    UserManager.initialize(_loc11_, _loc12_, _loc9_, _loc16_, _loc19_, _loc10_);
                    var _loc22_:* = dto.lm == null ? [] : GlobalMessage.fromDtos(dto.lm);
                    var _loc23_:* = dto.sgm == null ? [] : GlobalMessage.fromDtos(dto.sgm);
                    GlobalMessageManager.setMessages(_loc22_, _loc23_);
                    LocationManager.initialize(dto);
                    UserDiscountOfferManager.discountOfferTypes = DiscountOfferType.fromDtos(dto.dot);
                    UserDiscountOfferManager.dontShowDiscountOffer = dto.nsh == null ? false : Boolean(dto.nsh);
                    UserManager.abTestGroupIds = dto.j == null ? new ArrayCustom() : new ArrayCustom(dto.j);
                    AbTestHelper.addClientTestGroups();
                    if (dto.q != null) {
                        _loc11_.gameData.questData.setQuestById(Quest.fromDtos(dto.q));
                    }
                    if (dto.cm) {
                        SocialManager.initializeTasks(dto.cm);
                    }
                    UserNoteManager.initialize(_loc11_, _loc13_);
                    LocationNoteManager.initialize(_loc14_);
                    AllianceNoteManager.initialize(_loc15_);
                    if (!isNaN(_loc11_.gameData.allianceData.allianceId) && _loc11_.gameData.allianceData.rankId != AllianceMemberRankId.INVITED) {
                        AllianceManager.loadAlliance(_loc11_);
                    }
                    AllianceCityManager.initialize(dto);
                    ChatManager.initialize(dto.chu, dto.chm);
                    JournalAutoRefreshManager.initialize(dto.lci == null ? Number(0) : Number(dto.lci));
                    AutoRefreshManager.enabled = dto.auto == null ? false : Boolean(dto.auto);
                    if (dto.sr != null) {
                        SurveyManager.parseSurveyFromSignInDto(dto.sr);
                    }
                    processGlobalMissions(dto);
                    processVip(dto);
                    if (dto.rp != null) {
                        UnitResurrectionHelper.setResurrectionPrices(dto.rp);
                    }
                    if (SocialNetworkIdentifier.isFB) {
                        SocialNetworkIdentifier.socialService.setLikeHandler(UserManager.fbLikeHandler);
                        FreeGiftsManager.initialize(_loc11_.gameData.statsData.freeGiftsInfo);
                    }
                    BlackMarketDataInitializer.initialize();
                    if (dto.si) {
                        ServerManager.appId = dto.si.ai;
                        ServerManager.socialNetworkId = dto.si.si;
                        ServerManager.clusterGroupId = dto.si.cg;
                    }
                    if (ExternalInterface.available) {
                        ExternalInterface.call("Plarium.Events.afterStaticDataFetched");
                        Billing.setIdentity({
                            "userEmail": (!!SocialNetworkIdentifier.isPP ? null : UserManager.user.socialData.email),
                            "userIsDepositor": UserManager.user.gameData.statsData.isDepositor
                        });
                    }
                    if (_loc9_) {
                        _loc11_.gameData.userGameSettings.locale = _loc11_.socialData.locale;
                        new SetUserLocaleCmd(_loc11_.socialData.locale).execute();
                    }
                    _onResult(_loc9_);
                }).ifFault(_onFault).ifIoFault(_onIoFault).execute();
            }
            if (dto.pp != null) {
                for (x in dto.pp) {
                    if (dto.pp.hasOwnProperty(x)) {
                        StaticDataManager.portalBankPriseValues[x] = dto.pp[x];
                    }
                }
            }
            if (dto.ip) {
                StaticDataManager.userIp = dto.ip;
            }
            if (dto.ipk) {
                StaticDataManager.userIpKey = dto.ipk;
            }
            if (dto.ppl) {
                StaticDataManager.lastPaymentMethod = dto.ppl;
            }
            if (ExternalInterface.available) {
                ExternalInterface.call("Plarium.Events.afterSignIn");
            }
        }).ifFault(_onFault).ifIoFault(function (param1:Event):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            if (tryDefaultAddressIfFailed) {
                _loc2_ = getDefaultServerAddress();
                doTrace("Network Error");
                doSignIn(_loc2_, signInDto, false);
            }
            else {
                _loc3_ = 0;
                if (param1 is HTTPStatusEvent) {
                    _loc3_ = (param1 as HTTPStatusEvent).status;
                }
                _loc4_ = new FaultDto();
                _loc4_.setAdditionalProperty("SignIn", address, JSONOur.encode(signInDto), _socialId, new Date(), _loc3_);
                JsonCallCmd.handleOnIoFault(param1, _onIoFault, _onFault, _loc4_);
            }
        }).doFinally(_onFinally).execute();
    }

    private function processVip(param1:*):void {
        StaticDataManager.vipData.newActivator = param1.va != null;
        StaticDataManager.vipData.newLevel = param1.vl != null;
    }

    private function saveRegularPacks(param1:Object):void {
        var _loc2_:* = null;
        if (param1 == null) {
            return;
        }
        for (_loc2_ in param1) {
            StaticDataManager.bankRegularPacks[_loc2_] = param1[_loc2_];
        }
    }

    private function savePortalCurrency(param1:Object):void {
        if (param1 != null && "currency" in param1) {
            StaticDataManager.portalCurrency = param1.currency;
        }
    }

    private function saveMobileRates(param1:Object):void {
        MobilePaymentsInfo.fromDto(param1);
    }

    private function processGlobalMissions(param1:*):void {
        var _loc2_:QuestState = null;
        var _loc3_:QuestCompletion = null;
        var _loc4_:* = undefined;
        GlobalMissionCurrentState.globalMissionWonQuestPrototypeIds = param1.gmw == null ? [] : param1.gmw;
        GlobalMissionCurrentState.globalMissionLostQuestPrototypeIds = param1.gml == null ? [] : param1.gml;
        for each(_loc2_ in UserManager.user.gameData.questData.openedStates) {
            if (_loc2_.completions) {
                for each(_loc3_ in _loc2_.completions) {
                    if (_loc3_ && _loc3_.globalMission) {
                        if (_loc3_.globalMission.state == GlobalMissionStateTypeId.WON) {
                            GlobalMissionCurrentState.globalMissionWonQuestPrototypeIds.push(_loc2_.prototypeId);
                        }
                        else if (_loc3_.globalMission.state == GlobalMissionStateTypeId.LOST) {
                            GlobalMissionCurrentState.globalMissionLostQuestPrototypeIds.push(_loc2_.prototypeId);
                        }
                    }
                }
            }
        }
        if (param1.gmd != null) {
            for (_loc4_ in param1.gmd) {
                GlobalMissionManager.objectsDataByGlobalMission[_loc4_] = GlobalMissionUIData.fromDto(param1.gmd[_loc4_]);
            }
        }
    }

    private function getDefaultServerAddress():String {
        return ServerManager.SegmentServerAddresses[0];
    }

    private function getRandomServerAddress():String {
        var _loc1_:Array = ServerManager.SegmentServerAddresses;
        var _loc2_:int = int(Math.random() * _loc1_.length);
        if (_loc2_ == _loc1_.length) {
            _loc2_ = _loc1_.length - 1;
        }
        return _loc1_[_loc2_];
    }

    private function doTrace(param1:String):void {
        if (typeof this._tracer == "function") {
            this._tracer.call(null, param1);
        }
    }
}
}
