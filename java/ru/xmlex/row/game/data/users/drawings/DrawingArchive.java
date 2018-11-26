package ru.xmlex.row.game.data.users.drawings;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.scenes.objects.GeoSceneObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xMlex on 07.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class DrawingArchive {
    @Expose
    @SerializedName("d")
    public List<GeoSceneObject> drawings = new ArrayList<>();

    @Expose
    @SerializedName("c")
    public List<Object> clicksForUserIds;

    @Expose
    @SerializedName("o")
    public List<Object> clicksFromUserIds;

    @Expose
    @SerializedName("y")
    public Long lastClickDateByOtherUser;

    @Expose
    @SerializedName("x")
    public int currentClicksCount;

    public List<Object> addedDrawingPartsForClicks;

    public boolean clicksDirty = false;

    public boolean hasCompleteDrawing(int param1) {
        for (GeoSceneObject _loc2_ : this.drawings) {
            if (_loc2_.type == param1 && _loc2_.getLevel() == 1) {
                return true;
            }
        }
        return false;
    }
}
