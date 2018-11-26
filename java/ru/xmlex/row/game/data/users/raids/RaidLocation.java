package ru.xmlex.row.game.data.users.raids;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.map.MapPos;
import ru.xmlex.row.game.logic.RaidLocationKindId;
import ru.xmlex.row.game.logic.RaidLocationType;
import ru.xmlex.row.game.logic.StaticDataManager;

/**
 * Created by xMlex on 18.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class RaidLocation {
    @Expose
    @SerializedName("i")
    public int id;
    @Expose
    @SerializedName("t")
    public int typeId;
    @Expose
    @SerializedName("a")
    public long timeAdded;
    @Expose
    @SerializedName("f")
    public boolean closed;
    @Expose
    @SerializedName("l")
    public int level;
    @Expose
    @SerializedName("m")
    public MapPos mapPos;
    @Expose
    @SerializedName("s")
    public int strength;
    @Expose
    @SerializedName("r")
    public RaidLocationStoryInfo storyInfo = null;

    public RaidLocationType getType() {
        return StaticDataManager.getInstance().getRaidLocationTypeById(typeId);
    }

    public boolean isAttacking() {
        return getType().kindId == RaidLocationKindId.Attacking;
    }

    public boolean isDefensive() {
        return getType().kindId == RaidLocationKindId.Defensive;
    }
}
