package ru.xmlex.row.game.data.users.misc;

import com.google.gson.JsonElement;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;

/**
 * Created by xMlex on 19.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserTreasureData {
    @Expose
    @SerializedName("i")
    public int lastBoxId = -1;
    @Expose
    @SerializedName("u")
    public Resources userBoxesQuantity;
    @Expose
    @SerializedName("f")
    public Resources friendsBoxesQuantity;
    @Expose
    @SerializedName("v")
    public Resources boxesValues;
    @Expose
    @SerializedName("p")
    public JsonElement boxesByUsers;

    public boolean dirty = false;
}
