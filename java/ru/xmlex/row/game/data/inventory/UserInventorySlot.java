package ru.xmlex.row.game.data.inventory;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by mlex on 27.12.16.
 */
public class UserInventorySlot {
    @Expose
    @SerializedName("i")
    public int id;
    @Expose
    @SerializedName("t")
    public int typeId;
    @Expose
    @SerializedName("u")
    public boolean locked;
}
