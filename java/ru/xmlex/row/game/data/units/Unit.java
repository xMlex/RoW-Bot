package ru.xmlex.row.game.data.units;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.units.payloads.TradingOfferPayload;
import ru.xmlex.row.game.data.units.payloads.TradingPayload;
import ru.xmlex.row.game.data.units.payloads.TroopsPayload;
import ru.xmlex.row.game.data.units.states.UnitStateInSector;
import ru.xmlex.row.game.data.units.states.UnitStatePendingDepartureBack;

/**
 * Created by xMlex on 28.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class Unit {
    @Expose
    @SerializedName("i")
    public int UnitId;

    @Expose
    @SerializedName("o")
    public int OwnerUserId;

    @Expose
    @SerializedName("t")
    public int TargetUserId;

    @Expose
    @SerializedName("u")
    public int TargetTypeId;

    //    @Expose
//    @SerializedName("sf")
//    public UnitStateMoving StateMovingForward = null;
//
//    @Expose
//    @SerializedName("sb")
//    public UnitStateMoving StateMovingBack = null;
//
    @Expose
    @SerializedName("ss")
    public UnitStateInSector StateInTargetSector = null;

//    @Expose
//    @SerializedName("sp")
//    public UnitStatePendingArrival StatePendingArrival=null;

    @Expose
    @SerializedName("sr")
    public UnitStatePendingDepartureBack StatePendingDepartureBack = null;
//
//    @Expose
//    @SerializedName("sc")
//    public Unit StateCanceling
//    StateCanceling=null;
//
//    @Expose
//    @SerializedName("sa")
//    public Unit StateCancelationFailed
//    StateCancelationFailed=null;

    @Expose
    @SerializedName("pd")
    public TradingPayload tradingPayload = null;

    @Expose
    @SerializedName("po")
    public TradingOfferPayload tradingOfferPayload = null;

    /**
     * Войска вне сектора
     */
    @Expose
    @SerializedName("pt")
    public TroopsPayload troopsPayload = null;

}
