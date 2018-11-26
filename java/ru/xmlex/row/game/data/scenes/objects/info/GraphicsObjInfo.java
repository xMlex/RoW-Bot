package ru.xmlex.row.game.data.scenes.objects.info;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class GraphicsObjInfo {
    @Expose
    @SerializedName("x")
    public int x = 0;
    @Expose
    @SerializedName("y")
    public int y = 0;
    @Expose
    @SerializedName("m")
    public boolean isMirrored = false;
    @Expose
    @SerializedName("s")
    public int slotId = 0;
}
