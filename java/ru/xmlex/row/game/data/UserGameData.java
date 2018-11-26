package ru.xmlex.row.game.data;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.map.MapPos;
import ru.xmlex.row.game.data.map.UserMapData;
import ru.xmlex.row.game.data.scenes.objects.GeoSceneObject;
import ru.xmlex.row.game.data.scenes.types.info.BuildingTypeId;
import ru.xmlex.row.game.data.scenes.types.info.RequiredObject;
import ru.xmlex.row.game.data.scenes.types.info.RequiredType;
import ru.xmlex.row.game.data.scenes.types.info.SaleableLevelInfo;
import ru.xmlex.row.game.data.trading.TradingCenter;
import ru.xmlex.row.game.data.users.*;
import ru.xmlex.row.game.data.users.acceleration.ConstructionData;
import ru.xmlex.row.game.data.users.alliances.UserAllianceData;
import ru.xmlex.row.game.data.users.buildings.Sector;
import ru.xmlex.row.game.data.users.drawings.DrawingArchive;
import ru.xmlex.row.game.data.users.globalmessages.GlobalMessageUserData;
import ru.xmlex.row.game.data.users.messages.UserMessageData;
import ru.xmlex.row.game.data.users.misc.KnownUsersData;
import ru.xmlex.row.game.data.users.misc.UserBlackMarketData;
import ru.xmlex.row.game.data.users.misc.UserGameSettings;
import ru.xmlex.row.game.data.users.misc.UserTreasureData;
import ru.xmlex.row.game.data.users.raids.UserRaidData;
import ru.xmlex.row.game.data.users.technologies.TechnologyCenter;
import ru.xmlex.row.game.data.users.troops.UserTroopsData;
import ru.xmlex.row.game.logic.inventory.UserInventoryData;
import ru.xmlex.row.game.logic.quests.data.Quest;
import ru.xmlex.row.game.logic.quests.data.UserQuestData;
import ru.xmlex.row.game.logic.skills.data.UserSkillData;
import xmlex.vk.row.model.data.scenes.types.GeoSceneObjectType;

import java.util.List;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserGameData {
    @Expose
    @SerializedName("r")
    public int revision;
    @Expose
    @SerializedName("t")
    public long normalizationTime;
    @Expose
    @SerializedName("a")
    public UserAccount account;
    @Expose
    @SerializedName("map")
    public MapPos mapPos;
    @Expose
    @SerializedName("ms")
    public int mapStateId;
    @Expose
    @SerializedName("map2")
    public MapPos changingToMapPos;
    @Expose
    @SerializedName("sd")
    public Sector sector;
    @Expose
    @SerializedName("cd")
    public UserCommonData commonData;
    @Expose
    @SerializedName("ud")
    public UserMapData mapData;
    @Expose
    @SerializedName("s")
    public UserGameSettings userGameSettings;
    //
//    public UserChatSettings userChatSettings;
//
//    public NotificationData notificationData;
//
//    public Boolean settingsDirty;
//
//    public Boolean settingsChatDirty;
//
//    public Boolean settingsVipDirty;
//
//    public Boolean settingsMessagesDirty;
//
//    public UserCommonData commonData;
//
//    public UserClanData clanData;
    @Expose
    @SerializedName("md")
    public UserMessageData messageData;
    //
//    public Sector sector;
    @Expose
    @SerializedName("td")
    public UserTroopsData troopsData;
    @Expose
    @SerializedName("rd")
    public TradingCenter tradingCenter;
    @Expose
    @SerializedName("hd")
    public TechnologyCenter technologyCenter;
    @Expose
    @SerializedName("dd")
    public DrawingArchive drawingArchive;
    @Expose
    @SerializedName("wd")
    public UserWorldData worldData;
    @Expose
    @SerializedName("ad")
    public ConstructionData constructionData;

    @Expose
    @SerializedName("ku")
    public KnownUsersData knownUsersData;
    @Expose
    @SerializedName("bd")
    public UserTreasureData treasureData;
    //
//    public UserSectorSkinData statsData:model.data.UserStatsData;
//
//    public var sectorSkinsData;
//
//    public UserCyborgData cyborgData;
//
//    public UserArtifactData artifactData;
    @Expose
    @SerializedName("aa")
    public UserAllianceData allianceData = new UserAllianceData();
    @Expose
    @SerializedName("qd")
    public UserQuestData questData;
    @Expose
    @SerializedName("bm")
    public UserBlackMarketData blackMarketData;
    @Expose
    @SerializedName("ra")
    public UserRaidData raidData;
    //
    @Expose
    @SerializedName("sa")
    public UserSkillData skillData;
    //
//    public UserDragonData dragonData;
    @Expose
    @SerializedName("gm")
    public GlobalMessageUserData globalMessageData;
    //
//    public UserResourcesConversionData resourcesConversionData;
//
//    public UserOccupationData occupationData;
//
//    public UserGemData gemData;
//
//    public UserVipData vipData;
//
//    public UserDiscountOfferData discountOfferData;
//
//    public UserLoyaltyProgramData loyaltyData;
//vn
    @Expose
    @SerializedName("vn")
    public UserInventoryData inventoryData;
    //
//    public UserCharacterData characterData;
//
//    public SessionChestData sessionChestData;
//
//    public EffectData effectData;
//
//    public UserUIData uiData;
//
//    public int resourcesUraniumCount = 5;
//
//    public int resourcesTitaniumCount = 5;
    @Expose
    @SerializedName("id")
    public UserInvitationData invitationData;
//
//    public UserVipSupportData vipSupportData;
//
//    public UserBlueLightData blueLightData;

    public UserBuyingData buyingData = new UserBuyingData();

    //
//    private Dictionary buyStatusBySceneObject;
//
//    private var currentGameData:model.data.UserGameData;

    private Quest[] quests = null;

    public Quest[] getQuests() {
        return quests;
    }

    public void setQuests(Quest[] quests) {
        this.quests = quests;
    }

    public Resources getPrice(User user, GeoSceneObjectType objectType, int level) {
        return getPrice(user, objectType, level, null, null, false, false);
    }

    public Resources getPrice(User param1, GeoSceneObjectType objectType, int level, GeoSceneObject param4, GeoSceneObjectType param5, boolean param6e, boolean param7) {

        Resources result = null;

        SaleableLevelInfo levelInfo = objectType.saleableInfo.getLevelInfo(level);
        if (levelInfo != null && levelInfo.price != null) {
            result = levelInfo.price;
        }

        return result;
    }

    public int getBuyStatus(GeoSceneObjectType t, int level) {
        return getBuyStatus(t, level, false);
    }

    public int getBuyStatus(GeoSceneObjectType t, int level, boolean ignoreGroupInProgress) {
        if (t.saleableInfo == null || level == 1 && t.saleableInfo.limit == 0) {
            return BuyStatus.OBJECT_CANNOT_BE_BOUGHT;
        }
        if (level > t.saleableInfo.levelsCount()) {
            return BuyStatus.MAXIMUM_LEVEL_REACHED;
        }
        if (this.account.level < t.saleableInfo.getLevelInfo(level).requiredUserLevel) {
            return BuyStatus.LOW_USER_LEVEL;
        }
        if (!ignoreGroupInProgress && this.objectFromSameGroupIsInProgress(t)) {
            return BuyStatus.OBJECT_OF_SAME_GROUP_IN_PROGRESS;
        }
        SaleableLevelInfo levelInfo = t.saleableInfo.getLevelInfo(level);
        if (!ignoreGroupInProgress && levelInfo != null && levelInfo.requiredObjects.length > 0) {
            for (RequiredObject requiredObject : levelInfo.requiredObjects) {
                if (requiredObject.requiredType == RequiredType.BLACK_MARKET_PACK_ITEM) {
                    if (!blackMarketData.boughtCountByItemPackId.containsKey(requiredObject.typeId))
                        return BuyStatus.NOT_ENOUGHT_BLACK_MARKET_ITEMS;
                    if (blackMarketData.boughtCountByItemPackId.get(requiredObject.typeId) < requiredObject.count)
                        return BuyStatus.NOT_ENOUGHT_BLACK_MARKET_ITEMS;
                }
            }

        }
        if (level == 1) {
            if (t.isTechnology()) {
                if (this.technologyCenter.getTechnology(t.id).getLevel() > 0)
                    return BuyStatus.OBJECT_LIMIT_REACHED;
            }
            if (t.isBuilding()) {
                List<GeoSceneObject> buildings = sector.getBuildings(t.id);
                if (t.saleableInfo.requiresAllExistingMaxLevel) {
                    for (GeoSceneObject object : buildings) {
                        if (object.getLevel() != t.saleableInfo.levelsCount()) {
                            return BuyStatus.EXISTING_OBJECTS_OF_SAME_TYPE_SHOULD_HAVE_MAX_LEVEL;
                        }
                    }
                }
                if (buildings != null) {
                    if (buildings.size() >= t.saleableInfo.limit) {
                        return BuyStatus.OBJECT_LIMIT_REACHED;
                    }
//                    else if(this.sector.getBuildingsCount(param1.id) >= _loc4_.limit)
//                    {
//                        return BuyStatus.OBJECT_LIMIT_REACHED;
//                    }
//                    if((param1.buildingInfo.groupId == BuildingGroupId.DEFENSIVE || Boolean(GameType.isMilitary) && param1.buildingInfo.groupId == BuildingGroupId.DECOR_FOR_SECTOR_AND_WALLS) && param1.buildingInfo.defensiveKind == DefensiveKind.TOWER && this.sector.towersCount >= 12)
//                    {
//                        return BuyStatus.OBJECT_LIMIT_REACHED;
//                    }
//                    if(param1.buildingInfo.groupId == BuildingGroupId.DEFENSIVE && param1.buildingInfo.defensiveKind == DefensiveKind.GATE && this.sector.gatesCount >= 4)
//                    {
//                        return BuyStatus.OBJECT_LIMIT_REACHED;
//                    }
//                    if(param1.buildingInfo.groupId == BuildingGroupId.DECOR_FOR_WALLS && param1.buildingInfo.defensiveKind == DefensiveKind.DEFENSE_OBJECTS && this.sector.defensiveObjectsWall >= this.sector.getMaxDefenseObjectsAllowed())
//                    {
//                        return BuyStatus.OBJECT_LIMIT_REACHED;
//                    }
                }
            }
        }

        return BuyStatus.OBJECT_CAN_BE_BOUGHT;
    }

    public boolean objectFromSameGroupIsInProgress(GeoSceneObjectType t) {
        if (t == null)
            return true;
        if (t.isTechnology()) {
            return technologyCenter.inProgress();
        }
        if (t.isBuilding()) {
            boolean isFunctional = t.buildingInfo.isFunctional();
            if (!isFunctional) {
                return false;
            }
            if (t.id == BuildingTypeId.BuildingIdRobotBoostResources) {
                return false;
            }
            if (constructionData.workersUsed == -1) {
                constructionData.workersUsed = 0;
                for (GeoSceneObject object : this.sector.scene.objects) {
                    if (object.buildingInProgress() && !object.buildingInfo.broken && object.objectType().id != BuildingTypeId.BuildingIdRobotBoostResources) {
                        constructionData.workersUsed++;
                    }
                }
            }
            int workerCount = 0;
            if (workerCount == 0)
                workerCount = 1;
            if (constructionData.workersUsed >= workerCount)
                return true;
        }
        return false;
    }

    public boolean hasRequiredObject(RequiredObject param1) {
        int id = param1.typeId;
        int level = param1.level;
        int count = param1.count;
        return this.sector.hasActiveBuilding(id, level, count) || this.technologyCenter.hasActiveTechnology(id, level) || this.drawingArchive.hasCompleteDrawing(id);
    }

    public void update(UserGameData g) {
        if (g == null)
            return;
        this.revision = Math.max(this.revision, g.revision);
        this.normalizationTime = g.normalizationTime;
        if (this.mapPos == null) {
            this.mapPos = g.mapPos;
            //dispatchEvent(MAP_POS_CHANGED);
        }
        this.account.update(g.account);

        //updateObjectsBuyStatus(true); // last
    }

    public int getCaravanMax() {
        int count = 0;
        for (GeoSceneObject object : sector.scene.objects) {
            if (!object.isBuilding())
                continue;

            count += object.getBuildingLevelInfo().caravanQuantity;
        }
        return count;
    }
}
