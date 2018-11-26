package ru.xmlex.row.game.data.users.drawings;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 05.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class DrawingPart {
    @Expose
    @SerializedName("t")
    public int typeId;

    @Expose
    @SerializedName("p")
    public int part;

    public int count = -1;
}
