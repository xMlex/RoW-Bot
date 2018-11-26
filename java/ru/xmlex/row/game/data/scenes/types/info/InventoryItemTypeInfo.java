package ru.xmlex.row.game.data.scenes.types.info;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.inventory.InventoryItemLevelInfo;

import java.util.ArrayList;

/**
 * Created by xMlex on 08.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class InventoryItemTypeInfo {
    @Expose
    @SerializedName("li")
    public ArrayList<InventoryItemLevelInfo> levelInfos = new ArrayList<>();

    @Expose
    @SerializedName("r")
    public int inventoryItemRareness;
    @Expose
    @SerializedName("g")
    public int inventoryItemGroup;
    @Expose
    @SerializedName("f")
    public int[] affectedGroupIds;
    //    @Expose
//    @SerializedName("i")
    public int[] affectedTypeIds;
    @Expose
    @SerializedName("rs")
    public int requiredTechnologyTypeId;
    @Expose
    @SerializedName("m")
    public int requiredRaidLocationMinLevel;
    @Expose
    @SerializedName("ma")
    public float minBaseAttackBonus;
    @Expose
    @SerializedName("mx")
    public float maxBaseAttackBonus;
    @Expose
    @SerializedName("md")
    public float minBaseDefenseBonus;
    @Expose
    @SerializedName("xd")
    public float maxBaseDefenseBonus;
}
