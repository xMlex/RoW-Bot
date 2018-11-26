package ru.xmlex.row.game.data.trading;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.units.payloads.TradingPayload;

/**
 * Created by mlex on 29.12.2016.
 */
public class TradingOffer {
    public static final int OFFERS_LIFE = 259200000;
    private static final int DAY_SIZE = 86400000;

    @Expose
    @SerializedName("i")
    public int id;
    @Expose
    @SerializedName("u")
    public int userId;
    @Expose
    @SerializedName("o")
    public TradingPayload offerInfo;
    @Expose
    @SerializedName("s")
    public TradingPayload searchInfo;
    @Expose
    @SerializedName("t")
    public long time;

    public double deliveryTime;

    public double sortTime;
    @Expose
    @SerializedName("p")
    public int profit = 0;
}
