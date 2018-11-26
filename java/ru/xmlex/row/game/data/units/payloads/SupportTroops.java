package ru.xmlex.row.game.data.units.payloads;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.users.troops.Troops;

/**
 * Created by xMlex on 05.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class SupportTroops {
    @Expose
    @SerializedName("o")
    public int ownerUserId;
    @Expose
    @SerializedName("t")
    public Troops troops;
}
