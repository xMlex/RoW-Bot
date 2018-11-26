package ru.xmlex.row.game.data.users.misc;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class FavouriteUser {

    public static final int NONE = 0;
    public static final int ROBBERY = 1;
    public static final int OCCUPATION = 2;
    public static final int INTELLIGENCE = 3;
    public static final int CLAN = 4;
    public static final int HELP = 5;
    public static final int REVENGE = 6;
    public static final int COOPERATION = 7;
    public static final int INFO = 8;
    public static final int ATTACK = 9;
    public static final int REMOVED = -1;

    @Expose
    @SerializedName("u")
    public int userId;
    @Expose
    @SerializedName("t")
    public int typeId;
    @Expose
    @SerializedName("c")
    public String comment;
    @Expose
    @SerializedName("d")
    public long addDate;
}
