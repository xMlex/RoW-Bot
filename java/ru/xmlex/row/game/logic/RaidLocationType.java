package ru.xmlex.row.game.logic;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.common.RowName;

/**
 * Created by xMlex on 18.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class RaidLocationType {
    @Expose
    @SerializedName("i")
    public int id;
    @Expose
    @SerializedName("n")
    public RowName name = new RowName();
    @Expose
    @SerializedName("d")
    public RowName description = new RowName();
    @Expose
    @SerializedName("k")
    public int kindId;
    @Expose
    @SerializedName("p")
    public String picture;
    @Expose
    @SerializedName("sx")
    public int locationSizeX = 100;
    @Expose
    @SerializedName("sy")
    public int locationSizeY = 100;
}
