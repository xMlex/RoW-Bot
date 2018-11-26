package ru.xmlex.row.game.data.scenes.types.info;

import com.google.gson.annotations.SerializedName;

import java.util.Map;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class GraphicsTypeInfo {
    @SerializedName("u")
    public String url;
    @SerializedName("p")
    public String previewUrl;
    @SerializedName("s")
    public String previewSmallUrl;
    @SerializedName("x")
    public int x;
    @SerializedName("y")
    public int y;
    @SerializedName("sx")
    public int sizeX;
    @SerializedName("sy")
    public int sizeY;
    @SerializedName("ox")
    public int offsetX;
    @SerializedName("oy")
    public int offsetY;

    public int offsetXRight;
    @SerializedName("a")
    public int animationDuration;
    @SerializedName("n")
    public int clientSortOrder = 0;
    @SerializedName("l")
    public long newUntil = 0;
    @SerializedName("li")
    public Map<String, GraphicsLevelInfo> levelInfos;
}
