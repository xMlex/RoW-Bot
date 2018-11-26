package ru.xmlex.row.game.logic.quests.data;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.common.RowName;
import ru.xmlex.row.game.data.User;

/**
 * Created by xMlex on 01.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class Quest {
    public static final int CategoryId_None = 0;

    public static final int CategoryId_Wizard = 5;

    public static final int CategoryId_WizardProgress = 6;

    public static final int CategoryId_Construction = 10;

    public static final int CategoryId_BuildConsulate = 27;

    public static final int CategoryId_Gift = 30;

    public static final int CategoryId_GiftBoxes = 31;

    public static final int CategoryId_GiftDiscount = 32;

    public static final int CategoryId_Raid = 40;

    public static final int CategoryId_GlobalMissions = 50;

    public static final int CategoryId_OpenTreasure = 56;

    public static final int CategoryId_FirstDeposit = 60;

    public static final int CategoryId_OneTimeDiscount = 61;

    public static final int CategoryId_Mines = 70;

    /**
     * Ежедневные эпические, (грабь сервер противника, оккупируй и т.п.)
     */
    public static final int CategoryId_Features = 80;

    public static final int CategoryId_WheelOfFortune = 90;

    public static final int CategoryId_Story_Raid = 100;

    public static final int CategoryId_Story_Farming = 110;

    public static final int CategoryId_Achievements = 120;

    public static final int CategoryId_PvP = 130;

    public static final int CategotyId_Daily = 140;

    public static final int CategoryId_Tutorial = 150;

    public static final int CategoryId_Military = 160;

    public static final int CategoryId_Research = 170;

    public static final int CategotyId_BlackMarket = 180;

    public static final int CategotyId_VipSupport = 190;

    /**
     * Эпические - война в локах, и т.п.
     */
    public static final int CategoryId_Tournament = 200;

    public static final int CategoryId_Robbery = 210;

    public static final int CategoryId_GlobalEventGift = 230;

    public static final int CategoryId_DirectDeposit = 240;

    public static final int CategoryId_AvpTutorial = 220;

    public static final int CategoryId_DynamicMine = 250;

    public static final int CategoryId_DragonWizard = 310;

    public static final int CategoryId_DragonAbilityResearch = 320;

    public static final int DailyQuestKind_Daily = 1;

    public static final int DailyQuestKind_Alliance = 2;

    public static final int DailyQuestKind_Vip = 3;

    public static final int DailyQuestRareness_Basic = 1;

    public static final int DailyQuestRareness_Common = 2;

    public static final int DailyQuestRareness_Uncommon = 3;

    public static final int DailyQuestRareness_Rare = 4;

    public static final int DailyQuestRareness_Epic = 5;

    public static final int QuestId_WizardProgressPrototypeId = 900;

    public static final int QuestId_ThanksgivingSalePrototypeId = 33000;

    public static final int QuestId_StartNowPrototypeId = 33500;

    public static final int QuestId_ChristmasGiftsPrototypeId = 33555;

    public static final int QuestId_UnlimitedWeekendPrototypeId = 33100;

    public static final int QuestId_MayHolidaysDiscountPrototypeId = 33852;

    public static final int QuestId_MailruMinigamePrototypeId01 = 33666;

    public static final int QuestId_MailruMinigamePrototypeId02 = 33667;

    public static final int QuestId_MailruMinigamePrototypeId03 = 33668;

    public static final int QuestId_MailruMinigamePrototypeId05 = 33670;

    public static final int QuestId_Day1Dragons = 33650;

    public static final int QuestId_ComebackPlayer = 33680;

    public static final int QuestId_ComebackPlayer_1 = 33681;

    public static final int QuestId_ComebackPlayer_2 = 33682;

    public static final int QuestId_ComebackPlayer_3 = 33683;

    public static final int QuestId_ComebackPlayer_4 = 33684;

    public static final int QuestId_FbOpenAlbumJesperKyd = 39888;

    public static final int QuestId_Collect02PrototypeId = 33850;

    public static final int QuestId_Collect03PrototypeId = 33851;

    public static final int QuestId_FacebookLikePrototypeId = 33800;

    public static final int QuestId_OdnoklassnikiJoinGroupPrototypeId = 33857;

    public static final int QuestId_MailRuJoinGroupPrototypeId = 33858;

    public static final int QuestId_VkJoinGroupPrototypeId = 33859;

    public static final int QuestId_GrantPermissions = 33860;

    public static final int QuestId_ForumJoinPrototypeId = 38000;

    public static final int QuestId_VkAddToMenuPrototypeId = 39777;

    public static final int QuestId_StrategyMin = 70720;

    public static final int QuestId_StrategyMax = 70750;

    public static final int QuestId_MutagenMin = 70600;

    public static final int QuestId_RobotMax = 70700;

    public static final int QuestId_RobotMilitaryMin = 70760;

    public static final int QuestId_RobotMilitaryMax = 70779;

    public static final int QuestId_RobotBoostResources = 70752;

    public static final int QuestId_WheelOfFortuneMin = 120000;

    public static final int QuestId_WheelOfFortuneMax = 129999;

    public static final int QuestId_TreasureMin = 130000;

    public static final int QuestId_TreasureMax = 139999;

    public static final int QuestId_ChooseAvatar = 70755;

    public static final int QuestId_FreeResurrection = 70757;

    public static final int QuestId_Alliance = 70710;

    public static final int QuestId_CreateAcademy = 70711;

    public static final int QuestId_CreateAllianceCity = 70712;

    public static final int AdditionalWorkers1PrototypeId = 70751;

    public static final int AdditionalWorkers2PrototypeId = 70753;

    public static final int AdditionalWorkers3PrototypeId = 70754;

    public static final int QuestId_OpenBlackMarket = 70791;

    public static final int QuestId_OkCreateGiftPrototypeId = 80392;

    public static final int QuestId_RobSpecificLevelOfPlayer = 160000;

    public static final int QuestId_DoNRobberies = 160001;

    public static final int QuestId_RobSpecificAmountOfResources = 160002;

    public static final int QuestId_RobSpecificAmountOfResourcesNtimes = 160003;

    public static final int QuestId_OccupyAndGetResources = 160004;

    public static final int QuestId_RaidLocationLevel = 160005;

    public static final int QuestId_FreeOccupiedSector = 160006;

    public static final int QuestId_KillTroopsInEnemySector = 160007;

    public static final int QuestId_RaidLocationTimes = 160008;

    public static final int QuestId_TradingCurse = 150001;

    public static final int QuestId_BuildGemFactory = 1512;

    public static final int QuestId_BuildVirality = 1511;

    public static final int QuestId_BuildVirality_TD_KP = 1513;

    public static final int QuestId_BuildVirality_SP = 1514;

    public static final int QuestId_ViralityAchievement = 70756;

    public static final int QuestId_EMailPrototypeId1 = 30050;

    public static final int QuestId_EMailPrototypeId2 = 30051;

    public static final int QuestId_PromotionSale = 33103;

    public static final int QuestId_JoinVipSupportPrototypeId = 270000;

    public static final int QuestId_BirthdayPrototypeId = 270001;

    public static final int QuestId_AnniversaryPrototypeId = 270002;

    public static final int QuestId_Inactivity7RewardsPrototypeId = 270003;

    public static final int QuestId_Inactivity14RewardsPrototypeId = 270004;

    public static final int QuestId_Inactivity30RewardsPrototypeId = 270005;

    public static final int QuestId_Inactivity60RewardsPrototypeId = 270006;

    public static final int QuestId_Inactivity90RewardsPrototypeId = 270007;

    public static final int QuestId_FirstDepositMin = 61500;

    public static final int QuestId_FirstDepositMax = 62000;

    public static final int QuestId_FirstDepositNewMin = 62000;

    public static final int QuestId_FirstDepositNewMax = 62031;

    public static final int QuestId_AVP_PackMin = 62300;

    public static final int QuestId_AVP_PackMax = 62314;

    public static final int Quest_OpenChest = 220000;

    public static final int Quest_CraftGems = 220001;

    public static final int QuestId_FreeGift = 34000;

    public static final int QuestId_FacebookId = 215001;

    public static final int QuestId_TutorialProgress = 200161;

    public static final int QuestId_AchievementInviteFriend = 200200;

    public static final int QuestId_BuildDragline = 200104;

    public static final int QuestId_BuildShroomGarden = 200103;

    public static final int QuestId_BuildAleLevel4 = 200319;

    public static final int QuestId_BuildRobot = 200163;

    public static final int QuestId_GlobalTournamentMin = 240000;

    public static final int QuestId_GlobalTournamentMax = 249999;

    public static final int QuestId_EventGiftMin = 280000;

    public static final int QuestId_EventGiftMax = 289999;

    public static final int QuestId_MinesQuestMin = 70000;

    public static final int QuestId_MinesQuestMax = 70500;

    public static final int QuestId_RobMagicMines = 70009;

    public static final int QuestId_GetMagicMinesResources = 70010;

    public static final int QuestId_CaptureAndDefendPrototypeId = 70101;

    public static final int QuestId_CaptureAndCollectPrototypeId = 70102;

    public static final int QuestId_FightOffMinePrototypeId = 70103;

    public static final int QuestId_GenericRaid = 45000;

    public static final int QuestId_Recon = 43;

    public static final int QuestId_FirstLocation = 40001;

    public static final int QuestId_PostBattleReplay = 80426;

    public static final int QuestId_EnterMobileVersion = 80393;

    public static final int QuestId_EnterWebVersion = 80394;

    public static final int QuestId_AvpIntro = 260001;

    public static final int QuestId_AvpTemple = 260002;

    public static final int QuestId_AvpBuildLab = 260003;

    public static final int QuestId_AvpShowLab = 260004;

    public static final int QuestId_AvpCreateUnit = 260005;

    public static final int QuestId_AvpUnlockUnit = 260006;

    public static final int QuestId_AvpShowUnit = 260007;

    public static final int QuestId_AvpUpgradeBuilding = 260008;

    public static final int QuestId_AvpConvert = 260009;

    public static final int QuestId_AvpShowRadar = 260010;

    public static final int QuestId_AvpMissions = 260011;

    public static final int QuestId_AvpStrategy = 260012;

    public static final int QuestId_AvpOutro = 260013;

    public static final int QuestId_DragonBuilding = 310000;

    public static final int QuestId_minDirectDeposit = 290000;

    public static final int QuestId_maxDirectDeposit = 309999;

    public static final int QuestId_selectYoursDiscount = 120330;

    @Expose
    @SerializedName("l")
    public int id;
    @Expose
    @SerializedName("i")
    public int prototypeId;
    @Expose
    @SerializedName("c")
    public int categoryId;

    public int locationLevel = 10;
    @Expose
    @SerializedName("u")
    public String iconUrl;
    @Expose
    @SerializedName("n")
    public RowName name = new RowName();
    @Expose
    @SerializedName("t")
    public RowName text = new RowName();
    @Expose
    @SerializedName("hc")
    public int hideOnClient = -1;
    @Expose
    @SerializedName("dk")
    public int dailyQuestKind = 0;

    public boolean isDaily() {
        return categoryId == CategotyId_Daily;
    }

    public boolean isAviable(User user) {
        if (hideOnClient != -1)
            return false;
        if (isDaily()) {
            if (isDailyQuestKindDaily())
                return true;
            if (isDailyQuestKindAlliance() && user.gameData.allianceData.isInAlliance()) {
                return true;
            }
        }
        return false;
    }

    public boolean isDailyQuestKindDaily() {
        return dailyQuestKind == DailyQuestKind_Daily;
    }

    public boolean isDailyQuestKindAlliance() {
        return dailyQuestKind == DailyQuestKind_Alliance;
    }

}
