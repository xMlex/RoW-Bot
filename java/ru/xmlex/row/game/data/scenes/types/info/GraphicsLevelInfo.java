package ru.xmlex.row.game.data.scenes.types.info;

import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class GraphicsLevelInfo {
    @SerializedName("u")
    public String url;
    @SerializedName("p")
    public String previewUrl;
    @SerializedName("s")
    public String previewSmallUrl;

    public String localizedUrl;
    @SerializedName("ox")
    public int offsetX = 0;
    @SerializedName("oy")
    public int offsetY = 0;
    @SerializedName("or")
    public int offsetXRight = 0;
    @SerializedName("sc")
    public int scale = 0;
    @SerializedName("a")
    public int animationDuration = 0;
}
