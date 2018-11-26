package ru.xmlex.row.game.data.inventory;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;

/**
 * Created by mlex on 23.12.16.
 */
public class InventorySlotInfo {
    @Expose
    @SerializedName("i")
    public int id;
    @Expose
    @SerializedName("k")
    public int inventorySlotKind;
    @Expose
    @SerializedName("p")
    public Resources price;
    @Expose
    @SerializedName("g")
    public int[] inventoryItemGroups;
}
