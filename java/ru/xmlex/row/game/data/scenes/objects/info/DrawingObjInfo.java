package ru.xmlex.row.game.data.scenes.objects.info;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 07.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class DrawingObjInfo {
    @Expose
    @SerializedName("p")
    public int[] drawingParts;

    public int partsCollected() {
        int r = 0;
        for (int part : drawingParts) {
            if (part > 0)
                r++;
        }
        return r;
    }

    public boolean isCollected() {
        for (int part : drawingParts) {
            if (part <= 0)
                return false;
        }
        return true;
    }
}
