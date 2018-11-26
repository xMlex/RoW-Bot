package ru.xmlex.row.game.data.map;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class MapPos {
    @Expose
    @SerializedName("x")
    public int x;
    @Expose
    @SerializedName("y")
    public int y;

    public MapPos(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public MapPos() {
        this(0, 0);
    }

    @Override
    public String toString() {
        return "x: " + x + " y: " + y;
    }
}
