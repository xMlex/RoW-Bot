package ru.xmlex.row.game.data.scenes.objects.info;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;

/**
 * Created by xMlex on 4/6/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class BuildingObjInfo {
    @Expose(serialize = false)
    @SerializedName("b")
    public boolean canBeBroken = false;

    public boolean broken;
    @Expose(serialize = false)
    @SerializedName("s")
    public Resources localStorage;
    @Expose(serialize = false)
    @SerializedName("c")
    public long lastTimeCollected;

    public boolean isBroken() {
        return canBeBroken;
    }
}
