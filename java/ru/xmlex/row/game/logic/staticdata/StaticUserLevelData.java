package ru.xmlex.row.game.logic.staticdata;

import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.ratings.UserPrize;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by xMlex on 01.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class StaticUserLevelData {
    @SerializedName("g")
    public int goldMoneyForLevelUp;
    @SerializedName("s")
    public int goldMoneyForLevelUpBefore20Level;
    @SerializedName("p")
    public ArrayList<Integer> pointsForLevel;
    @SerializedName("t")
    public int technologyLearnedPoints;
    @SerializedName("td")
    public int technologyWithDrawingsLearnedPoints;
    @SerializedName("tu")
    public int technologyUpgradePoints;
    @SerializedName("bf")
    public int buildingFunctionalPoints;
    @SerializedName("bfu")
    public int buildingFunctionalUpgradePoints;
    @SerializedName("m")
    public Map<Integer, Integer> mobilizersForLevel;
    @SerializedName("i")
    public List<Integer> blackMarketItemsPrize = new ArrayList<>();
    @SerializedName("a")
    public Map<String, UserPrize> prizesForLevel;

    public int maxLevel;
}
