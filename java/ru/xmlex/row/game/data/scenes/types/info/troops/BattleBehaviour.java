package ru.xmlex.row.game.data.scenes.types.info.troops;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 08.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class BattleBehaviour {
    @Expose
    @SerializedName("d")
    public boolean absoluteLosses;
    @Expose
    @SerializedName("c")
    public boolean civilUnit;
}
