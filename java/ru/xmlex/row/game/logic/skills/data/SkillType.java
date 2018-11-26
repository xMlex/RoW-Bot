package ru.xmlex.row.game.logic.skills.data;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.common.RowName;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xMlex on 13.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class SkillType {
    @Expose
    @SerializedName("i")
    public int id;
    @Expose
    @SerializedName("n")
    public RowName name = new RowName();
    @Expose
    @SerializedName("u")
    public String iconUrl = "";
    @Expose
    @SerializedName("x")
    public int x;
    @Expose
    @SerializedName("y")
    public int y;
    @Expose
    @SerializedName("r")
    public List<RequiredSkill> requiredSkills = new ArrayList<>();
    @Expose
    @SerializedName("e")
    public int effectTypeId;
    @Expose
    @SerializedName("l")
    public List<SkillLevelInfo> levelInfos;
    @Expose
    @SerializedName("t")
    public List<String> affectedTypes = new ArrayList<>();
}
