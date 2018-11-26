package ru.xmlex.row.game.logic;

import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.inventory.InventorySlotInfo;

import java.util.ArrayList;

/**
 * Created by mlex on 27.12.16.
 */
public class StaticInventoryData {
    @SerializedName("is")
    public ArrayList<InventorySlotInfo> inventorySlotInfos = new ArrayList<>();

    public InventorySlotInfo getSlotById(int id) {
        for (InventorySlotInfo info : inventorySlotInfos) {
            if (info.id == id)
                return info;
        }
        return null;
    }
}
