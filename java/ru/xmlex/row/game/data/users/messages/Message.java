package ru.xmlex.row.game.data.users.messages;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;
import ru.xmlex.row.game.data.map.MapPos;
import ru.xmlex.row.game.data.users.drawings.DrawingPart;
import ru.xmlex.row.game.data.users.troops.BattleResult;
import ru.xmlex.row.game.data.users.troops.Troops;

/**
 * Created by xMlex on 18.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class Message {
    @Expose
    @SerializedName("h")
    public MessageHeader header;
    @Expose
    @SerializedName("b")
    public MessageBody body;

    public static class MessageBody {
        @Expose
        @SerializedName("t")
        public int typeId;
        @Expose
        @SerializedName("a")
        public long time;
        @Expose
        @SerializedName("f")
        public int userIdFrom;
        @Expose
        @SerializedName("u")
        public int userIdTo;
        @Expose
        @SerializedName("x")
        public String text;
        @Expose
        @SerializedName("b")
        public BattleResult battleResult;
        @Expose
        @SerializedName("o")
        public Troops troops;
        @Expose
        @SerializedName("s")
        public Resources resources;
        @Expose
        @SerializedName("h")
        public int technologyId;
        @Expose
        @SerializedName("l")
        public int technologyLevel;
        @Expose
        @SerializedName("d")
        public DrawingPart drawingPart;
        @Expose
        @SerializedName("aa")
        public boolean drawingPartForFriends;
        @Expose
        @SerializedName("i")
        public int artifactTypeId = -1;
        //        @Expose
//        @SerializedName("ii")
//        public Vector.<model.data.users.messages.MessageInventoryItemData>messageInventoryItemDataVector;
        @Expose
        @SerializedName("c")
        public int allianceId = 0;
        @Expose
        @SerializedName("k")
        public int knownAllianceType;
        @Expose
        @SerializedName("p")
        public int ownerAllianceId = 0;
        @Expose
        @SerializedName("r")
        public int allianceRankId;
        @Expose
        @SerializedName("y")
        public int allianceAchievementtypeId;
        @Expose
        @SerializedName("v")
        public int allianceAchievementLevel;
        @Expose
        @SerializedName("m")
        public int changedUserId;
        @Expose
        @SerializedName("n")
        public int raidLocationId;
        //        @Expose
//        @SerializedName("z")
//        public RatingWinners ratingWinners;
        @Expose
        @SerializedName("g")
        public int globalMissionPrototypeId;
        //        @Expose
//        @SerializedName("j")
//        public AllianceEventsStatistics allianceEventStatistics;
//        @Expose
//        @SerializedName("e")
//        public Dictionary blackMarketItems;
        @Expose
        @SerializedName("w")
        public int vipPoints;
        @Expose
        @SerializedName("sp")
        public MapPos fromMapPos;
        @Expose
        @SerializedName("dp")
        public MapPos toMapPos;
        //        @Expose
//        @SerializedName("ti")
//        public     TournamentMessageInfo  tournamentInfo ;
        @Expose
        @SerializedName("ui")
        public int unitId;
    }

    public static class MessageHeader {
        @Expose
        @SerializedName("i")
        public int id;
        @Expose
        @SerializedName("v")
        public int revision;
        @Expose
        @SerializedName("u")
        public int refUserId;
        @Expose
        @SerializedName("r")
        public boolean isRead;

        public boolean addedByClient = false;
    }
}
