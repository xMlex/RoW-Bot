package ru.xmlex.row.game.data.scenes.types.info;

import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.logic.StaticDataManager;
import xmlex.vk.row.model.data.scenes.types.GeoSceneObjectType;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class RequiredObject {
    @SerializedName("r")
    public int requiredType;
    @SerializedName("t")
    public int typeId;
    @SerializedName("l")
    public int level;
    @SerializedName("c")
    public int count;
    @SerializedName("a")
    public int abTestGroupId = -1;

    private GeoSceneObjectType type;

    public GeoSceneObjectType getType() {
        if (type == null) {
            type = StaticDataManager.getInstance().findSceneObjectById(typeId);
        }
        return type;
    }
}
