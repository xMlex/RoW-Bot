package ru.xmlex.row.game.data.units.payloads;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;
import ru.xmlex.row.game.data.users.troops.Troops;

import java.util.List;

/**
 * Created by xMlex on 05.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class TroopsPayload {
    @Expose
    @SerializedName("o")
    public int order;
    @Expose
    @SerializedName("si")
    public Number slotId = null;

    @Expose
    @SerializedName("t")
    public Troops troops = null;

    @Expose
    @SerializedName("s")
    public List<SupportTroops> supportTroops = null;

    @Expose
    @SerializedName("r")
    public Resources resources = null;
    @Expose
    @SerializedName("w")
    public boolean isFromAttackWindow = false;

}
