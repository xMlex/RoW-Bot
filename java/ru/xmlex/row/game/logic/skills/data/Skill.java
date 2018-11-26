package ru.xmlex.row.game.logic.skills.data;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.scenes.objects.info.ConstructionObjInfo;
import ru.xmlex.row.game.logic.StaticDataManager;

/**
 * Created by xMlex on 18.04.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class Skill {
    public boolean dirtyNormalized = false;
    public int improvementStatus = -1;

    @Expose
    @SerializedName("t")
    public int typeId;
    @Expose
    @SerializedName("c")
    public ConstructionObjInfo constructionInfo;

    private SkillType skillType = null;

    public SkillType getSkillType() {
        if (skillType == null) {
            for (SkillType el : StaticDataManager.getInstance().skillData.skillTypes) {
                if (el.id == typeId) {
                    skillType = el;
                    return skillType;
                }
            }
        }
        return null;
    }
}
