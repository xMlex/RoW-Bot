package ru.xmlex.row.game.data.trading;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;

import java.util.ArrayList;

/**
 * Created by mlex on 29.12.2016.
 */
public class TradingCenter {
    public static final int RESOURCES_PER_CARAVAN = 1000;

    public static final int OUTDATED_OFFER_HOURS = 72;
    @Expose
    @SerializedName("o")
    public ArrayList<TradingOffer> offers = new ArrayList<>();

    public Resources maxResourcesTransfer = new Resources(0, 5000, 5000, 5000);
}
