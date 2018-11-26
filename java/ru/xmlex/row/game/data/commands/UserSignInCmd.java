package ru.xmlex.row.game.data.commands;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.common.ConfigSystem;
import ru.xmlex.common.Util;
import ru.xmlex.row.game.GameClient;
import ru.xmlex.row.game.SocialUser;
import ru.xmlex.row.game.data.User;
import ru.xmlex.row.game.data.UserSocialData;
import ru.xmlex.row.game.data.map.unitMoving.MapPosBlockExtensions;
import ru.xmlex.row.game.data.scenes.objects.GeoSceneObject;
import ru.xmlex.row.game.data.units.Unit;
import ru.xmlex.row.game.data.users.raids.RaidLocation;
import ru.xmlex.row.game.db.models.RowAuthKeys;
import ru.xmlex.row.game.logic.RaidLocationType;
import ru.xmlex.row.game.logic.StaticDataManager;
import ru.xmlex.row.game.logic.commands.world.unitMoving.GetMapBlocksCmd;
import ru.xmlex.row.game.logic.quests.data.Quest;

import java.util.ArrayList;
import java.util.logging.Level;

/**
 * Created by xMlex on 29.03.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserSignInCmd extends BaseCommand {

    @Expose
    @SerializedName("f")
    public ArrayList<String> friends = new ArrayList<String>();

    @Expose
    @SerializedName("c")
    public ClientInfo clientInfo = new ClientInfo();

    @Expose
    @SerializedName("i")
    public String socialId = null;

    @Expose
    @SerializedName("l")
    public String l = "user_apps";

    @Expose
    @SerializedName("mr")
    public String mailruMinigameUserId = "";

    @Expose
    @SerializedName("rr")
    public String rr = null;

    @Expose
    @SerializedName("t")
    public int t = -180;

    @Expose
    @SerializedName("s")
    public UserSocialData userSocialData = null;

    @Override
    public void onCommandInit() {
        socialId = getClient().getAccount().getSocialId();

        SocialUser user = new SocialUser();
        user.setUid(socialId);
        user.setFirstName(getClient().getAccount().first_name);
        user.setLastName(getClient().getAccount().last_name);

        userSocialData = new UserSocialData();
        userSocialData.socialId = socialId;
        userSocialData.fullName = user.last_name + " " + user.first_name;
        userSocialData.photoUrl = getClient().getAccount().photo;
        userSocialData.locale = "ru-RU";
        userSocialData.customData = user.getSocialNetworkData();
        //friends.addAll(getClient().getAccount().friends);
        setAction("SignIn");
        setBody(getGsonWithoutExpose().toJson(this));
        setUserRefresh(false);
    }

    @Override
    public void onCommandResult(String result) {
        if (ConfigSystem.DEBUG)
            log.info("answer: " + result);
        //Util.writeFile("./log/userSigIn." + getClient().getAccount().getUserId() + ".json", result);
        UserSignInCmdResult cmdResult;
        try {
            cmdResult = getGsonWithoutExpose().fromJson(result, UserSignInCmdResult.class);
        } catch (Throwable e) {
            log.log(Level.WARNING, "onCommandResult fromJson: " + getClient().getAccount().id, e);
            getClient().getAccount().deactivateByServerError("С аккаунтом что то не так, проверьте настройки", -1);
            return;
        }
        if (cmdResult == null) {
            log.warning("Responce null");
            return;
        }
        if (cmdResult.redirectionSegmentAddress != null) {
            if (ConfigSystem.DEBUG)
                log.info("Redirect to: " + cmdResult.redirectionSegmentAddress);
            getClient().getCrypt().setUrl(cmdResult.redirectionSegmentAddress + "/segment.ashx");
            getClient().executeCmd(new UserSignInCmd());
            return;
        }
        // Мы в системе, разбираем пакет + стартуем получение статики
        if (cmdResult.locale != null)
            getClient().serverManager.updateLocale(cmdResult.locale);

        assert cmdResult.segmentServerList != null;
        assert cmdResult.sessionId != null;
        if (ConfigSystem.DEBUG)
            log.info("SessionId: " + cmdResult.sessionId);

        getClient().serverManager.segmentServerAddresses = cmdResult.segmentServerList;
        getClient().getCrypt().setSessionId(cmdResult.sessionId);

        getClient().getCrypt().setUrl(cmdResult.segmentServerList[cmdResult.segmentId] + "/segment.ashx");
        //getClient().executeCmdCurrent(new StaticDataGetCmd(cmdResult.getStaticDataKey));

        // Теперь мы полностью готовы к работе - получаем основную инфу
        getClient().getCrypt().setSessionId(cmdResult.sessionId);
        getClient().setUser(cmdResult.user);
        getClient().serverTimeManager.initialize(cmdResult.serverLocale, cmdResult.user.gameData.commonData.totalTimeInGame);

        cmdResult.user.setClient(getClient());
        cmdResult.user.userManager.segmentId = cmdResult.segmentId;
        cmdResult.user.userQuestManager.setQuest(cmdResult.quest);

        if (ConfigSystem.DEBUG) {
            log.info("Debug mode");

//            // лучшение технологий
//            cmdResult.user.gameData.technologyCenter.processUser(cmdResult.user);
            // Улучшение зданий
            cmdResult.user.gameData.sector.scene.processUser(cmdResult.user);
//            // Выполнение квестов
//            cmdResult.user.userQuestManager.processUser(cmdResult.user);
//            // Войска, Создаем
//            cmdResult.user.gameData.troopsData.processUser(cmdResult.user);
            // Проходимся по локам
//            if (cmdResult.user.gameData.raidData != null)
//                cmdResult.user.gameData.raidData.processUser(cmdResult.user);
//            // Прячем в бункер
//            cmdResult.user.gameData.troopsData.sendTroopsToBunker(cmdResult.user, cmdResult.user.gameData.troopsData.troops);

            // Наемник
//            cmdResult.user.gameData.inventoryData.processUser(cmdResult.user);

            // Inventory
//            for (GeoSceneObject inventoryItem : cmdResult.user.gameData.inventoryData.inventoryItems) {
//                log.info("Item: " + inventoryItem.objectType().name);
//            }

            // Map
            for (int i = 1; i < 8; i++) {
                getClient().executeCmd(new GetMapBlocksCmd(cmdResult.user.gameData.mapPos.x - (20 * i), true));
            }

//            getClient().executeCmd(new MapGetCmd(new MapRect(
//                    cmdResult.user.gameData.mapPos.x,
//                    cmdResult.user.gameData.mapPos.y,
//                    cmdResult.user.gameData.mapPos.x + 3,
//                    cmdResult.user.gameData.mapPos.y + 3
//            )));
//            getClient().executeCmd(new MapGetCmd(new MapRect(
//                    cmdResult.user.gameData.mapPos.x,
//                    cmdResult.user.gameData.mapPos.y,
//                    cmdResult.user.gameData.mapPos.x - 3,
//                    cmdResult.user.gameData.mapPos.y + 3
//            )));
//            getClient().executeCmd(new MapGetCmd(new MapRect(
//                    cmdResult.user.gameData.mapPos.x,
//                    cmdResult.user.gameData.mapPos.y,
//                    cmdResult.user.gameData.mapPos.x - 3,
//                    cmdResult.user.gameData.mapPos.y - 3
//            )));

            //cmdResult.user.userQuestManager.processUser(cmdResult.user);
            //cmdResult.user.gameData.raidData.processUser(cmdResult.user);
            //cmdResult.user.gameData.troopsData.processUser(cmdResult.user);
//            MapPos pos = cmdResult.user.gameData.mapPos;
//            for (int i = 0; i < 25; i++) {
//                MapRect rect = new MapRect(pos.x, pos.y, pos.x + i, pos.y + i);
//                getClient().executeCmd(new MapGetCmd(rect));
//            }
//            log.info("Total: " + MapGetCmd.users.size());
//            String str = "";
//            List<JsonObject> list = new ArrayList<>(MapGetCmd.users.size());
//            for (Map.Entry<Integer, JsonObject> entry : MapGetCmd.users.entrySet()) {
//                list.add(entry.getValue());
//            }
//            str = "{\"response\":" + getGson().toJson(list) + ",{";
//            Util.writeFile(str, "./log/friends.json");
//
//            //app-friends
//            list = new ArrayList<>(MapGetCmd.users.size());
//            for (Map.Entry<Integer, JsonObject> entry : MapGetCmd.users.entrySet()) {
//                JsonObject obj = new JsonObject();
//                obj.add("uid", entry.getValue().get("uid"));
//                obj.add("first_name", entry.getValue().get("first_name"));
//                obj.add("last_name", entry.getValue().get("last_name"));
//                obj.add("photo_big", entry.getValue().get("photo_big"));
//                obj.addProperty("sex", (int) Rnd.get(1));
//                obj.addProperty("bdate", "2.7.19" + (int) Rnd.get(88, 99));
//
//                list.add(obj);
//            }
//
//            str = "\"app_friends\":" + getGson().toJson(list) + ",";
//            Util.writeFile(str, "./log/friends-app.json");
        } else {
            // Улучшение зданий
            cmdResult.user.gameData.sector.scene.processUser(cmdResult.user);
            // лучшение технологий
            cmdResult.user.gameData.technologyCenter.processUser(cmdResult.user);
            // Войска, Создаем
            cmdResult.user.gameData.troopsData.processUser(cmdResult.user);
            // Прячем в бункер
            cmdResult.user.gameData.troopsData.sendTroopsToBunker(cmdResult.user, cmdResult.user.gameData.troopsData.troops);
            // Наемник
            cmdResult.user.gameData.inventoryData.processUser(cmdResult.user);
            // Проходимся по локам
            if (cmdResult.user.gameData.raidData != null)
                cmdResult.user.gameData.raidData.processUser(cmdResult.user);
            // Выполнение квестов
            cmdResult.user.userQuestManager.processUser(cmdResult.user);
        }
    }

    public static void main(String[] args) throws Exception {
        ConfigSystem.load();
        StaticDataManager.initializeFromCache();

        RowAuthKeys accountx = RowAuthKeys.getDao().queryForId(4);

        GameClient client = new GameClient(accountx);
        UserSignInCmdResult r = getGsonWithoutExpose().fromJson(Util.readFile("./log/1.UserSignInCmd.json"), UserSignInCmdResult.class);
        r.user.setClient(client);
        client.serverTimeManager.initialize(r.serverLocale, r.user.gameData.commonData.totalTimeInGame);
        client.setUser(r.user);
        r.user.userQuestManager.setQuest(r.quest);

        // Debug
        //r.user.gameData.troopsData.processUser(r.user);
        r.user.gameData.raidData.processUser(r.user);
        for (Unit unit : r.user.gameData.worldData.units) {
            log.info("Unit: " + unit.OwnerUserId);
        }

        // Inventory
        log.info("InventoryItem nextInventoryItemId: " + r.user.gameData.inventoryData.nextInventoryItemId);
        log.info("InventoryItem count: " + r.user.gameData.inventoryData.inventoryItems.size());
        for (GeoSceneObject item : r.user.gameData.inventoryData.inventoryItems) {
            log.info("Item: " + item.objectType().name + " : " + item.id);
        }


        log.info("Inventory sealedItem count: " + r.user.gameData.inventoryData.sealedItems.size());
        log.info("Inventory slotInfo count: " + r.user.gameData.inventoryData.slotInfo.size());


        int[] autoTroops = new int[]{1, 2};
        for (int troopId : autoTroops) {
            int totalCount = r.user.gameData.troopsData.getTroopCountById(troopId, r.user);
            log.info("Всего в секторе и в бункере " + troopId + ": " + totalCount);
            if (r.user.gameData.troopsData.troopsFactory != null) {
                int processTroops = r.user.gameData.troopsData.troopsFactory.getTotalCountByTypeId(troopId);
                totalCount += processTroops;
                log.info("В постройке " + troopId + ": " + processTroops);
            }
            log.info("Всего " + troopId + ": " + totalCount);
        }

        log.info("Всего караванов " + r.user.gameData.getCaravanMax());
        log.info("MapBlockId: " + MapPosBlockExtensions.getBlockId(0, 0));
        MapPosBlockExtensions.debug(100, 100);

        if (true) {
            return;
        }

        GeoSceneObject forUpgrade = r.user.gameData.sector.scene.getBestForUpgrade(r.user);
        if (forUpgrade != null) {
            log.info("SceneUpgrade: " + forUpgrade.getName() + " lvl: " + forUpgrade.getLevel());
        } else {
            log.info("scene update null");
        }

        GeoSceneObject techForUpgrade = r.user.gameData.technologyCenter.getBestForUpgrade(r.user);
        if (forUpgrade != null) {
            log.info("TechUpgrade: " + forUpgrade.getName() + " lvl: " + forUpgrade.getLevel());
        } else {
            log.info("tech update null");
        }
//
//        GeoSceneObjectType gladiatorType = StaticDataManager.getInstance().getObjectType(3);
//        GeoSceneObject glad = r.user.gameData.technologyCenter.technologies.get(1);
//        client.executeCmdDebug(new BuyCommand(glad));

        //r.user.gameData.troopsData.processUser(r.user);
        //r.user.userQuestManager.processUser(r.user);

//        String tmp = Util.readFile("./log/89516984307.CloseQuestCmd.json");
//        UserRefreshCmd.updateUserByResultDto(tmp, r.user);

        // Локации
        for (RaidLocation location : r.user.gameData.raidData.locations) {
            log.info("Loc: " + location.id + " lvl: " + location.level + " t: " + location.typeId + " k: " + location.getType());
        }

        for (RaidLocationType type : StaticDataManager.getInstance().raidData.raidLocationTypes) {
            log.info("RL: " + type.name + " id: " + type.id);
        }
        //r.user.gameData.raidData.processUser(r.user);

        // Производство войск
//        for (GeoSceneObjectType type :r.user.gameData. troopsData.troops) {
//            log.info("Troop: " + type.name+" id: "+type.id);
//            type.saleableInfo.requiredObjects
//        }


//        GeoSceneObject drawForUpgrade = r.user.gameData.drawingArchive.getBestForUpgrade(r.user);
//        if (forUpgrade != null) {
//            log.info("DrawUpgrade: " + forUpgrade.getName() + " lvl: " + forUpgrade.getLevel());
//        } else {
//            log.info("draw update null");
//        }

        // отправка войск в бункер
//        TroopsPayload troopsPayload = new TroopsPayload();
//        troopsPayload.troops = new Troops();
//        troopsPayload.troops.countByType.put(7, 2);
//        client.executeCmdDebug(new UnitSendCmd(r.user.id, r.user.id, null, troopsPayload));


//        for (GeoSceneObjectType type : StaticDataManager.getInstance().getTroops()) {
//            log.info("Troop: " + type.name);
//        }

        //dailyQuestType
//        for (DailyQuestType dailyQuestType : StaticDataManager.getInstance().dailyQuestData.dailyQuestTypes) {
//            log.info("DailyQuest: " + dailyQuestType.nameLocalized + " Id: " + dailyQuestType.id);
//        }
//
//        for (Quest quest : r.quest) {
//            if (quest.isAviable(r.user))
//                log.info("Q: " + quest.name + " Id: " + quest.id + " t: " + quest.hideOnClient + " isDaily: " + quest.isDailyQuestKindDaily());
//        }
        // Войска в секторе
//        Unit bunker = UnitUtility.FindInBunkerUnit(r.user);
//        if (bunker != null) {
//            for (Map.Entry<Integer, Integer> el : bunker.troopsPayload.troops.countByType.entrySet()) {
//                log.info("BTroop: " + el.getKey() + " Count: " + el.getValue());
//            }
//        }
//        for (Map.Entry<Integer, Integer> el : r.user.gameData.troopsData.troops.countByType.entrySet()) {
//            log.info("STroop: " + el.getKey() + " Count: " + el.getValue());
//        }
        // Список чертежей
//        for (GeoSceneObject type : r.user.gameData.drawingArchive.drawings) {
//            log.info("T: " + type.getName() + " id: " + type.type + " Complete: " + r.user.gameData.drawingArchive.hasCompleteDrawing(type.type));
//        }


        //log.info(getGson().toJson(r.user.gameData.worldData.junits));

//        SceneObject object = r.user.gameData.technologyCenter.getBestForUpgrade(r.user);
//        log.info("Tech for update: " + object.getName() + " id: " + object.type + " lvl: " + object.constructionInfo.level);

    }

    private static class ClientInfo {
        @Expose
        @SerializedName("i")
        public int platformId = 1;//flash/linux -1
        @Expose
        @SerializedName("v")
        public String platformVersion = "1.0";
    }

    public static class UserSignInCmdResult {
        @Expose
        @SerializedName("r")
        public String redirectionSegmentAddress = null;
        @Expose
        @SerializedName("c")
        public String locale = null;
        @Expose
        @SerializedName("i")
        public int segmentId;
        @Expose
        @SerializedName("t")
        public long serverLocale;
        @Expose
        @SerializedName("e")
        public int refreshTimeoutMs;
        @Expose
        @SerializedName("a")
        public String[] segmentServerList;
        @Expose
        @SerializedName("s")
        public String getStaticDataKey;
        @Expose
        @SerializedName("u")
        public User user = null;
        @Expose
        @SerializedName("k")
        public String sessionId = null;
        @Expose
        @SerializedName("q")
        public Quest[] quest = new Quest[]{};
    }
}
