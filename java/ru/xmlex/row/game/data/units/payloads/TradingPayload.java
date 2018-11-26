package ru.xmlex.row.game.data.units.payloads;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;
import ru.xmlex.row.game.data.users.drawings.DrawingPart;

/**
 * Created by xMlex on 05.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class TradingPayload {
    @Expose
    @SerializedName("c")
    public int numberOfCaravans;

    @Expose
    @SerializedName("s")
    public double caravanSpeed = 0;

    @Expose
    @SerializedName("r")
    public Resources resources = null;

    @Expose
    @SerializedName("d")
    public DrawingPart drawingPart = null;
}
