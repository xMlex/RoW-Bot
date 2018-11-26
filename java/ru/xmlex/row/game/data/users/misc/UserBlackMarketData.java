package ru.xmlex.row.game.data.users.misc;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.users.misc.blackMarket.UserBmiData;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by xMlex on 08.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserBlackMarketData {
    @Expose
    @SerializedName("sc")
    public int strategyTroopsPurchasesCount;
    @Expose
    @SerializedName("tc")
    public int troopsPurchasesCount;
    @Expose
    @SerializedName("dc")
    public int drawingsPurchasesCount;
    @Expose
    @SerializedName("bc")
    public int buildingsPurchasesCount;
    @Expose
    @SerializedName("a")
    public Map<Integer, Integer> boughtCountBySceneObjectTypeId = new HashMap<>();
    @Expose
    @SerializedName("pt")
    public Map<Integer, Integer> boughtCountByItemPackId;
    //
//    private Dictionary _boughtItems;
//
//    private Dictionary _boughtSeparatedItems;
//
//    public Dictionary boughtActivatorsByTime;
    @Expose
    @SerializedName("c")
    public Map<Integer, Integer> purchaseCountById;

    @Expose
    @SerializedName("bmi")
    public Map<Integer, UserBmiData> items = new HashMap<>();

}
