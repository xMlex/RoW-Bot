package ru.xmlex.row.game.data.users.troops;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;

/**
 * Created by xMlex on 18.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class RobberyResult {
    @Expose
    @SerializedName("s")
    public int status;

    @Expose
    @SerializedName("r")
    public Resources resources;
}
