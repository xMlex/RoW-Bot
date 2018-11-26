package ru.xmlex.row.game.objects;

import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class SceneObjectType {
    @SerializedName("i")
    public int id = 0;
    @SerializedName("n")
    public SotValue name = new SotValue();
    @SerializedName("d")
    public SotValue description = new SotValue();

    public int width = 0;

    public int height = 0;

    public int offsetX = 0;

    public int offsetXRight = 0;

    public int offsetY = 0;

    public static class SotValue {
        @SerializedName("c")
        public String value = "";

        @Override
        public String toString() {
            return value;
        }
    }
}
