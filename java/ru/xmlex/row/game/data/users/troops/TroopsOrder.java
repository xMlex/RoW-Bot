package ru.xmlex.row.game.data.users.troops;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.scenes.objects.info.ConstructionObjInfo;

/**
 * Created by xMlex on 22.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class TroopsOrder {
    @Expose
    @SerializedName("i")
    public int id;
    @Expose
    @SerializedName("k")
    public int typeId;
    @Expose
    @SerializedName("t")
    public int totalCount;
    @Expose
    @SerializedName("p")
    public int pendingCount;
    @Expose
    @SerializedName("c")
    public ConstructionObjInfo constructionInfo;
    @Expose
    @SerializedName("f")
    public boolean finishAll;
}
