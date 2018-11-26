package ru.xmlex.row.game.logic.inventory;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by mlex on 23.12.16.
 */
public class SealedInventoryType {
    @Expose
    @SerializedName("r")
    public int inventoryItemRareness = -1;
    @Expose
    @SerializedName("g")
    public int[] affectedGroupIds;
}
