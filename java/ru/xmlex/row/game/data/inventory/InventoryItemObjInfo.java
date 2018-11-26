package ru.xmlex.row.game.data.inventory;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.logic.StaticDataManager;

/**
 * Created by xMlex on 07.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class InventoryItemObjInfo {
    @Expose
    @SerializedName("i")
    public long issueTime;
    @Expose
    @SerializedName("s")
    public int slotId = -1;
    @Expose
    @SerializedName("e")
    public boolean sealed;
    @Expose
    @SerializedName("m")
    public int minUserLevel;
    @Expose
    @SerializedName("a")
    public int baseAttackBonus;
    @Expose
    @SerializedName("d")
    public int baseDefenseBonus;

    public InventorySlotInfo getSlotInfo() {
        return StaticDataManager.getInstance().InventoryData.getSlotById(slotId);
    }
}
