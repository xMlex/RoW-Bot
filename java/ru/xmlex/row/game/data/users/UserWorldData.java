package ru.xmlex.row.game.data.users;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;
import ru.xmlex.row.game.data.units.Unit;
import ru.xmlex.row.game.data.users.misc.UserResourceFlow;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xMlex on 28.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserWorldData {
    @Expose
    @SerializedName("u")
    public List<Unit> units = new ArrayList<>();
    @Expose
    @SerializedName("r")
    public int robberyCounter;
    @Expose
    @SerializedName("d")
    public long nextAvailableRobberyDate;
    @Expose
    @SerializedName("s")
    public int missileStrikesCounter;
    @Expose
    @SerializedName("k")
    public long nextAvailableMissileStrikeDate;
    @Expose
    @SerializedName("x")
    public int drawingCaravansSentToday;
    @Expose
    @SerializedName("y")
    public int resourceCaravansSentToday;
    @Expose
    @SerializedName("f")
    public UserResourceFlow[] resourcesFlow = new UserResourceFlow[]{};
    @Expose
    @SerializedName("g")
    public Resources incomingResourcesToday;

    public boolean dirtyUnitListChanged = false;

    public boolean dirtyUnitsMoved = false;

    public boolean dirtyRobberyCounter = false;

    public boolean dirtyMissileStrikeCounter = false;
    @Expose
    @SerializedName("h")
    public long lastMissileStrikeDate;
    @Expose
    @SerializedName("q")
    public int resourcesRobbed;
    @Expose
    @SerializedName("v")
    public long lastResourcesRobbedDate;

    public Unit getUnitById(int unitId, int userId) {
        for (Unit unit : units) {
            if (unit.UnitId == unitId && unit.OwnerUserId == userId)
                return unit;
        }
        return null;
    }
}
