package ru.xmlex.row.game.data.map.unitMoving;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class MapTrackingBlock {
    @Expose
    @SerializedName("i")
    public int id;
    @Expose
    @SerializedName("m")
    public int mapHash = 0;
    @Expose
    @SerializedName("u")
    public int unitsHash = 0;

    public MapTrackingBlock(int id) {
        this.id = id;
    }
}
