package ru.xmlex.row.game.data.scenes.types.info;

import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class BuildingTypeInfo {
    public static final List<BuildingLevelInfo> EMPTY_LEVEL_INFO = new ArrayList<>(0);
    @SerializedName("lc")
    public List<BuildingLevelInfo> levelInfos;
    @SerializedName("g")
    public int groupId;
    @SerializedName("k")
    public int defensiveKind = -1;
    @SerializedName("h")
    public int height;
    @SerializedName("s")
    public int slotKindId;
    @SerializedName("t")
    public int decorType = 0;
    @SerializedName("b")
    public boolean canBeBroken;
    @SerializedName("d")
    public boolean canBeDeleted;
    @SerializedName("o")
    public boolean canRepairedByOwnerOnly;
    @SerializedName("l")
    public boolean notApplyBonusForBuilding;
    @SerializedName("n")
    public boolean boostIsNotAllowed;
    @SerializedName("c")
    public boolean cancelIsNotAllowed;

    public boolean isFunctional() {
        return BuildingGroupId.IsFunctional(this.groupId);
    }

    public BuildingLevelInfo getLevelInfo(int lvl) {
        return levelInfos.get(lvl - 1);
    }
}
