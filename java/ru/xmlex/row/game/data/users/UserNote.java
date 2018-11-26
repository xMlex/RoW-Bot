package ru.xmlex.row.game.data.users;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;
import ru.xmlex.common.dbcp.BaseDatabaseFactory;
import ru.xmlex.row.game.data.User;
import ru.xmlex.row.game.data.map.MapPos;
import ru.xmlex.row.game.logic.UserManager;

import java.sql.SQLException;
import java.util.concurrent.TimeUnit;

/**
 * Created by xMlex on 30.04.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
@DatabaseTable(tableName = "row_user_notes")
public class UserNote {
    public static final String STATUS_THIS_USER = "statusThisUser";

    public static final String STATUS_DEMO_USER = "statusDemoUser";

    public static final String STATUS_ALLY = "statusAlly";

    public static final String STATUS_HELPER = "statusHelper";

    public static final String STATUS_ENEMY = "statusEnemy";

    public static final String STATUS_FOE = "statusFoe";

    public static final String STATUS_FRIEND = "statusFriend";

    public static final String STATUS_NEW_USER = "statusNewUser";

    public static final String STATUS_UNKNOWN_USER = "statusUnknownUser";

    @Expose
    @SerializedName("i")
    @DatabaseField(generatedId = false, index = true, id = true)
    public int id;
    @Expose
    @SerializedName("g")
    @DatabaseField(index = true)
    public int segmentId;
    @Expose
    @SerializedName("s")
    @DatabaseField()
    public String socialId;
    @Expose
    @SerializedName("f")
    @DatabaseField()
    public String profileUrl = "";
    @Expose
    @SerializedName("p")
    @DatabaseField()
    public String photoUrl = "";
    @Expose
    @SerializedName("r")
    @DatabaseField()
    public long registrationTime;
    @Expose
    @SerializedName("l")
    @DatabaseField()
    public int level;
    @Expose
    @SerializedName("m")
    public MapPos mapPos;
    @Expose
    @SerializedName("a")
    public String sectorName = "";
    @Expose
    @SerializedName("n")
    @DatabaseField
    public String userName = "";

    @Expose
    @SerializedName("ms")
    public int mapStateId = 0;
    @Expose
    @SerializedName("c")
    public double caravanSpeed;
    @Expose
    @SerializedName("o")
    @DatabaseField
    public int occupantUserId = -1;
    @Expose
    @SerializedName("x")
    @DatabaseField
    public int allianceId = -1;
    @Expose
    @SerializedName("y")
    public int allianceRankId = -1;
    @Expose
    @SerializedName("mc")
    public int mobilizersCount = 0;
    @Expose
    @SerializedName("si")
    public int sectorSkinTypeId = -1;
    @Expose
    @SerializedName("b")
    public long lastMissileStrikeDate = -1;
    @Expose
    @SerializedName("lr")
    @DatabaseField
    public long lastReturnDate = -1;
    @Expose
    @SerializedName("e")
    public String hashedId = "";
    @Expose
    @SerializedName("av")
    @DatabaseField
    public int activeVipLevel;

    // public Rectangle mapElementRect;

    public String mapImageSource;

    public boolean mapTooltipEnabled;

    //public UserNoteCharacterData characterData;

    //public ArrayCustom effectItems;

    public int shieldTypeId;

    // DB
    @DatabaseField(index = true)
    public int x;
    @DatabaseField(index = true)
    public int y;

    public UserNote() {
        this(null);
    }

    public UserNote(User user) {
        if (user != null) {
            this.id = user.id;
            this.segmentId = user.userManager.segmentId;
//            this.socialId = !!user.socialData.socialId?user.socialData.socialId:"";
//            this.profileUrl = !!user.socialData.profileUrl?user.socialData.profileUrl:"";
//            this.fullName = !!user.socialData.fullName?user.socialData.fullName:"";
//            this._photoUrl = user.socialData.photoUrlString;
            this.registrationTime = user.gameData.commonData.registrationTime;
            this.level = user.gameData.account.level;
            this.sectorName = user.gameData.sector.name;
            this.mapPos = user.gameData.mapPos;
            this.x = mapPos.x;
            this.y = mapPos.y;
            this.caravanSpeed = user.gameData.constructionData.caravanSpeed;
            this.occupantUserId = UserManager.getOccupantUserId(user);
//            this.activeVipLevel = !!VipManager.getActiveState()?Integer.valueOf(user.gameData.vipData.vipLevel):0;
//            if(user.gameData.allianceData != null)
//            {
//                this.allianceId = user.gameData.allianceData.allianceId;
//                this.allianceRankId = user.gameData.allianceData.rankId;
//                this.mobilizersCount = user.gameData.allianceData.mobilizersCount;
//            }
//            this.effectItems = user.gameData.effectData.getLightEffectsList();
//            this.shieldTypeId = getShieldType(this.effectItems);
//            this.sectorSkinTypeId = !!user.gameData.sectorSkinsData?Integer.valueOf(UserManager.user.gameData.sectorSkinsData.currentSkinTypeId):Integer.valueOf(SectorSkinType.SectorSkinTypeId_Default);
            this.lastReturnDate = user.gameData.commonData.lastReturnDate;
        }
    }

    public boolean isIncognito() {
        return userName == null && photoUrl.equals("") && profileUrl.equals("");
    }

    public String getName() {
        return userName.equals("") ? ("User:" + mapPos.x + "," + mapPos.y) : userName;
    }

    public boolean isInactive() {
        return lastReturnDate != -1;
    }

    public boolean isOccupied() {
        return occupantUserId != -1;
    }

    public String inactivePeriod() {
        if (!isInactive())
            return "Сегодня";
        final long period = System.currentTimeMillis() - lastReturnDate;
        final long days = TimeUnit.MILLISECONDS.toDays(period);
        final long hr = TimeUnit.MILLISECONDS.toHours(period);
        final long min = TimeUnit.MILLISECONDS.toMinutes(period - TimeUnit.HOURS.toMillis(hr) - TimeUnit.DAYS.toMillis(days));
        final long sec = TimeUnit.MILLISECONDS.toSeconds(period - TimeUnit.HOURS.toMillis(hr) - TimeUnit.DAYS.toMillis(days) - TimeUnit.MINUTES.toMillis(min));
        final long ms = TimeUnit.MILLISECONDS.toMillis(period - TimeUnit.HOURS.toMillis(hr) - TimeUnit.DAYS.toMillis(days) - TimeUnit.MINUTES.toMillis(min) - TimeUnit.SECONDS.toMillis(sec));
        return String.format("%02d d %02d h %02d m %02d s %03d", days, hr, min, sec, ms);
    }

    public int inactiveDays() {
        if (!isInactive())
            return 0;
        return (int) TimeUnit.MILLISECONDS.toDays(System.currentTimeMillis() - lastReturnDate);
    }

    @Override
    public String toString() {
        return "UserNote{" +
                "id=" + id +
                ", socialId='" + socialId + '\'' +
                ", level=" + level +
                ", mapPos=" + mapPos +
                ", sectorName='" + sectorName + '\'' +
                ", userName='" + userName + '\'' +
                ", occupantUserId=" + occupantUserId +
                ", allianceId=" + allianceId +
                ", x=" + x +
                ", y=" + y +
                '}';
    }

    private static Dao<UserNote, Integer> dao;

    public static Dao<UserNote, Integer> getDao() {
        if (dao == null) {
            try {
                dao = DaoManager.createDao(BaseDatabaseFactory.getInstance().getConnectionSource(), UserNote.class);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return dao;
    }
}
