package ru.xmlex.row.game.data.users.raids;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;
import ru.xmlex.row.game.data.users.troops.Troops;

/**
 * Created by xMlex on 18.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class RaidResult {
    @Expose
    @SerializedName("s")
    public int locationStrengthLeft;
    @Expose
    @SerializedName("e")
    public Resources resourcesFound;
    @Expose
    @SerializedName("r")
    public Resources resourcesTaken;
    @Expose
    @SerializedName("f")
    public Troops troops;
    @Expose
    @SerializedName("g")
    public int questBonus;
    @Expose
    @SerializedName("q")
    public int questPrototypeId;
    @Expose
    @SerializedName("p")
    public int skillPoints;
}
