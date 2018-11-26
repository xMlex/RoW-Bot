package ru.xmlex.row.game.data.users.globalmessages;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 11.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class GlobalMessageUserData {
    @Expose
    @SerializedName("l")
    public int lastKnownMessageId;
}
