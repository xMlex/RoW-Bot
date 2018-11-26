package ru.xmlex.row.game.logic;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.common.ConfigSystem;
import ru.xmlex.common.Util;
import ru.xmlex.row.game.GameClient;
import ru.xmlex.row.game.RowSignature;
import ru.xmlex.row.game.common.gson.AdapterBooleanRow;
import ru.xmlex.row.game.data.commands.StaticDataGetCmd;
import ru.xmlex.row.game.logic.skills.data.StaticSkillData;
import ru.xmlex.row.game.logic.staticdata.StaticUserLevelData;
import ru.xmlex.row.game.logic.units.StaticDailyQuestData;
import xmlex.vk.row.model.data.scenes.types.GeoSceneObjectType;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.locks.ReentrantLock;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Created by xMlex on 01.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class StaticDataManager {

    private static final Logger log = Logger.getLogger(StaticDataManager.class.getName());
    private static StaticDataManager instance;
    private static ReentrantLock lock = new ReentrantLock();
    private static boolean instance_init = false;

    @SerializedName("sot")
    public List<GeoSceneObjectType> geoSceneObjectTypeList;
    @SerializedName("ft")
    public int freeTroopsMaxOrderSize = 100;
    @SerializedName("ld")
    public StaticUserLevelData levelData;
    @SerializedName("sa")
    public StaticSkillData skillData;
    @SerializedName("dd")
    public StaticDailyQuestData dailyQuestData = new StaticDailyQuestData();
    @SerializedName("sul")
    public static int skilledUserLevel = 0;
    @SerializedName("sud")
    public static int skilledUserDays = 0;
    @SerializedName("bw")
    public static double bankAndWarehousePriceAndTimeCoef = 1;
    @SerializedName("rd")
    public StaticRaidData raidData;
    @SerializedName("id")
    public StaticInventoryData InventoryData;

    public GeoSceneObjectType findSceneObjectById(int id) {
        for (GeoSceneObjectType el : geoSceneObjectTypeList) {
            if (el.id == id)
                return el;
        }
        return null;
    }

    public GeoSceneObjectType getObjectType(int id) {
        return findSceneObjectById(id);
    }

    public List<GeoSceneObjectType> getTroops() {
        List<GeoSceneObjectType> list = new ArrayList<>();
        for (GeoSceneObjectType el : geoSceneObjectTypeList) {
            if (el.isTroops())
                list.add(el);
        }
        return list;
    }

    public RaidLocationType getRaidLocationTypeById(int id) {
        for (RaidLocationType type : raidData.raidLocationTypes) {
            if (type.id == id)
                return type;
        }
        return null;
    }

    public static StaticDataManager getInstance() {
        lock.lock();
        if (instance == null)
            instance = new StaticDataManager();
        lock.unlock();
        return instance;
    }

    public static void initialize(GameClient client, String key) {
        lock.lock();
        try {
            if (instance_init)
                return;
            log.info("StaticDataLoad: Begin");
            File file = new File("./data-v." + ConfigSystem.getInt("row_client_version", 505) + ".json");
            if (!file.exists()) {
                client.executeCmdCurrent(new StaticDataGetCmd(key));
            } else {
                loadSelf();
            }
            log.info("StaticDataLoad: End");
        } finally {
            lock.unlock();
        }
    }

    public static boolean initializeFromCache() {
        lock.lock();
        try {
            return loadSelf();
        } finally {
            lock.unlock();
        }
    }

    private static boolean loadSelf() {
        File file = new File("./data/row/data-v" + ConfigSystem.getInt("row_client_version", 505) + ".json");
        if (!file.exists()) {
            RowSignature signature = new RowSignature();
            signature.setUrl("https://pvvk2s01.plrm.zone/GeoVk2/Segment01/segment.ashx");
            try {
                String str = signature.JsonCallCmd(
                        "Client.GetStaticData",
                        ConfigSystem.get("row_static_load_key", "\"dGVd/B0/tINf31e3QPxoqQ==\""),
                        "GET"
                );
                Util.writeFile(str, file.getAbsolutePath());
            } catch (Exception e) {
                log.log(Level.SEVERE, "Не удалось загрузить статику с сайта", e);
            }
        }

        if (file.exists()) {
            String staticStr = Util.readFile(file.getAbsolutePath());
            AdapterBooleanRow booleanRow = new AdapterBooleanRow();
            Gson gson = new GsonBuilder()
                    .registerTypeAdapter(Boolean.class, booleanRow)
                    .registerTypeAdapter(boolean.class, booleanRow)
                    .create();
            instance = gson.fromJson(staticStr, StaticDataManager.class);
            instance_init = true;
            log.info("Static data initialized.");
            return true;
        } else {
            log.severe("Row static file not found: " + file.getAbsolutePath());
        }
        return false;
    }
}
