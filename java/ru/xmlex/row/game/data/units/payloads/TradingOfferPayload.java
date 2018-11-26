package ru.xmlex.row.game.data.units.payloads;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 05.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class TradingOfferPayload {
    @Expose
    @SerializedName("i")
    public int offerOwnerId;

    @Expose
    @SerializedName("o")
    public int offerId;
}
