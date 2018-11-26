package ru.xmlex.row.game.data;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 08.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserInvitationData {
    @Expose
    @SerializedName("c")
    public int constructionBlockCount;
}
