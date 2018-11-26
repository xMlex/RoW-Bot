package ru.xmlex.row.game.logic.skills.data;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xMlex on 18.04.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserSkillData {
    @Expose
    @SerializedName("s")
    public List<Skill> skills = new ArrayList<>();
    @Expose
    @SerializedName("p")
    public int skillPoints;
    @Expose
    @SerializedName("d")
    public int pointDiscardsCount;

    public UserSkillData() {

    }

    public Skill getSkill(int typeId) {
        for (Skill el : skills)
            if (el.typeId == typeId)
                return el;
        return null;
    }

    public Skill getActiveSkill() {
        for (Skill el : skills)
            if (el.constructionInfo.isInProgress())
                return el;
        return null;
    }
}
