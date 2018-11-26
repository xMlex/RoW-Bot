package ru.xmlex.row.game.data.inventory;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by mlex on 23.12.16.
 */
public class InventoryItemLevelInfo {
    @Expose
    @SerializedName("a")
    public float attackBonus;
    @Expose
    @SerializedName("d")
    public float defenseBonus;
    @Expose
    @SerializedName("sb")
    public float powderDustAmount;
}
