package ru.xmlex.row.game.logic.skills.data;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;

import java.util.List;

/**
 * Created by xMlex on 13.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class StaticSkillData {
    @Expose
    @SerializedName("s")
    public List<SkillType> skillTypes;
    @Expose
    @SerializedName("d")
    public List<Resources> pointsDiscardPriceByAttempt;

//    @Expose
//    @SerializedName("p")
//    public Array skillPointsPerLevel;
}
