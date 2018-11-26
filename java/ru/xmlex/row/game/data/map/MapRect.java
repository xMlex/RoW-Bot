package ru.xmlex.row.game.data.map;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 4/10/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class MapRect {
    @Expose
    @SerializedName("x")
    public int x1;
    @Expose
    @SerializedName("y")
    public int y1;
    @Expose
    @SerializedName("v")
    public int x2;
    @Expose
    @SerializedName("u")
    public int y2;

    public MapRect(int x1, int y1, int x2, int y2) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
    }
}
