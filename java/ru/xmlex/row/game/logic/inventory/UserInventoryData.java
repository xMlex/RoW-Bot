package ru.xmlex.row.game.logic.inventory;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import io.gsonfire.annotations.PostDeserialize;
import ru.xmlex.row.game.data.User;
import ru.xmlex.row.game.data.commands.BaseCommand;
import ru.xmlex.row.game.data.inventory.InventorySlotInfo;
import ru.xmlex.row.game.data.inventory.InventorySlotType;
import ru.xmlex.row.game.data.inventory.UserInventorySlot;
import ru.xmlex.row.game.data.scenes.objects.GeoSceneObject;
import ru.xmlex.row.game.logic.commands.inventory.PowderInventoryItemCmd;

import java.util.ArrayList;
import java.util.Map;
import java.util.logging.Logger;

/**
 * Created by xMlex on 07.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserInventoryData {
    protected static final Logger log = Logger.getLogger(UserInventoryData.class.getName());

    @Expose
    @SerializedName("r")
    public JsonObject inventoryItemsObject = new JsonObject();
    @Expose
    @SerializedName("s")
    public JsonObject sealedItemsObject = new JsonObject();
    @Expose
    @SerializedName("a")
    public JsonObject slotInfoObject = new JsonObject();

    public ArrayList<GeoSceneObject> inventoryItems = new ArrayList<>();
    public ArrayList<SealedInventoryType> sealedItems = new ArrayList<>();
    public ArrayList<UserInventorySlot> slotInfo = new ArrayList<>();

    @Expose
    @SerializedName("d")
    public int dustAmount = 0;
    @Expose
    @SerializedName("n")
    public int nextInventoryItemId = -1;
    @Expose
    @SerializedName("t")
    public long time = -1;

    public void processUser(User user) {

        log.fine("Наемник");
        for (GeoSceneObject item : inventoryItems) {
            if (item.constructionInfo.isInProgress()) {
                log.fine("Наемник: В процессе продажи: " + item.objectType().name);
                return;
            }
        }

        InventorySlotInfo info;

        for (GeoSceneObject item : inventoryItems) {
            info = item.inventoryItemInfo.getSlotInfo();
            if (info.inventorySlotKind == InventorySlotType.STORAGE
                    && !item.inventoryItemInfo.sealed
                    && item.objectType().inventoryItemInfo.inventoryItemRareness <= 0
            ) {
                user.getClient().logAction("Наёмник: Продаем: " + item.objectType().name, item.type);
                user.getClient().executeCmd(new PowderInventoryItemCmd(item));
                return;
            }
        }

    }

    public GeoSceneObject getItemBySlotId(int slotId) {
        for (GeoSceneObject item : inventoryItems) {
            if (item.inventoryItemInfo.slotId == slotId)
                return item;
        }
        return null;
    }

    @PostDeserialize
    public void postDeserialize() {
        for (Map.Entry<String, JsonElement> entry : inventoryItemsObject.entrySet()) {
            GeoSceneObject el = BaseCommand.getGsonWithoutExpose().fromJson(entry.getValue(), GeoSceneObject.class);
            if (el.type != 0)
                inventoryItems.add(el);
        }

        for (Map.Entry<String, JsonElement> entry : sealedItemsObject.entrySet()) {
            SealedInventoryType el = BaseCommand.getGsonWithoutExpose().fromJson(entry.getValue(), SealedInventoryType.class);
            sealedItems.add(el);
        }

        for (Map.Entry<String, JsonElement> entry : slotInfoObject.entrySet()) {
            UserInventorySlot el = BaseCommand.getGsonWithoutExpose().fromJson(entry.getValue(), UserInventorySlot.class);
            slotInfo.add(el);
        }
    }
}
