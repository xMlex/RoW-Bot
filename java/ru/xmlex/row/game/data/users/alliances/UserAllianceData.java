package ru.xmlex.row.game.data.users.alliances;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.alliances.AllianceMemberRankId;

/**
 * Created by xMlex on 11.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserAllianceData {
    @Expose
    @SerializedName("i")
    public int allianceId = -1;
    @Expose
    @SerializedName("r")
    public int rankId = -1;

    public boolean isInAlliance() {
        return this.allianceId != -1 && this.rankId < AllianceMemberRankId.INVITED;
    }
}
