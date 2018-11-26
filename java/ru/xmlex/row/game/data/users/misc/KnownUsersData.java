package ru.xmlex.row.game.data.users.misc;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;
import java.util.List;

public class KnownUsersData {
    @Expose
    @SerializedName("u")
    public int[] friendUserIds;
    @Expose
    @SerializedName("f")
    public int[] mateUserIds;
    @Expose
    @SerializedName("b")
    public int[] enemyUserIds;
//    @Expose
//    @SerializedName("b")
//    public int[] allianceEnemyUserIds;

    @Expose
    @SerializedName("k")
    public List<FavouriteUser> favouriteUsers = new ArrayList<FavouriteUser>(0);

    @Expose
    @SerializedName("a")
    public int extraFavoriteUsersCount;

//    public var enemyUserIdsWithTime:ArrayCustom;
//
//    public var robberyLimit:Number = 0;
//
//    public var knownTowers:ArrayCustom;
//
//    public var dirty:Boolean = false;
//
//    public var favouritesDirty:Boolean = false;

}
