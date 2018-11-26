package ru.xmlex.row.game.data.scenes.objects.info;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class ConstructionObjInfo {
    @Expose
    @SerializedName("l")
    public int level = 0;
    @Expose
    @SerializedName("s")
    public Long constructionStartTime = null;
    @Expose
    @SerializedName("f")
    public Long constructionFinishTime = null;
    @Expose
    @SerializedName("d")
    public boolean isDestruction;

    /**
     * @return строиться ли в данный момент
     */
    public boolean isInProgress() {
        if (constructionFinishTime == null)
            return false;
        return (constructionFinishTime - constructionStartTime) > 0;
    }
}
