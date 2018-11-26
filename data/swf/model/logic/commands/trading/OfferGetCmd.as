package model.logic.commands.trading {
import common.ArrayCustom;

import model.data.users.UserNote;
import model.data.users.drawings.DrawingPart;
import model.data.users.trading.TradingOffer;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class OfferGetCmd extends BaseCmd {

    public static const FilterType_All:uint = 0;

    public static const FilterType_Uranium:uint = 1;

    public static const FilterType_Titanium:uint = 2;

    public static const FilterType_Money:uint = 3;

    public static const FilterType_Drawings:uint = 4;

    public static const FilterType_Resources:uint = 5;

    public static const FilterSubType_All:uint = 100;

    public static const FilterSubType_Acceptable:uint = 101;

    public static const FilterOwner_All:uint = 200;

    public static const FilterOwner_Friends:uint = 201;

    public static const FilterOwner_Ally:uint = 202;

    public static const FilterOwner_AllianceMate:uint = 203;

    public static const FilterOwner_Mine:uint = 401;

    public static const FilterRate_All:uint = 0;

    public static const FilterRate_EqualAmounts:uint = 301;

    public static const FilterOrder_None:uint = 0;

    public static const FilterOrder_ByDistance:uint = 1;

    public static const FilterOrder_ByProfitAndDistance:uint = 3;


    private var _dto;

    public function OfferGetCmd(param1:int, param2:Number, param3:int, param4:Array = null, param5:int = 0, param6:String = "", param7:String = "", param8:uint = 0, param9:uint = 0, param10:uint = 100, param11:uint = 200, param12:uint = 0, param13:uint = 0, param14:ArrayCustom = null, param15:ArrayCustom = null) {
        super();
        this._dto = {
            "i": param1,
            "c": param3,
            "a": param4,
            "p": param5,
            "m": param6,
            "r": param7,
            "f": param8,
            "t": param9,
            "s": param10,
            "o": param11,
            "n": param12,
            "x": param13,
            "d": (param14 == null ? null : DrawingPart.toDtos(param14)),
            "g": (param15 == null ? null : DrawingPart.toDtos(param15)),
            "z": param2
        };
    }

    override public function execute():void {
        new JsonCallCmd("TradingOffers.GetOffers", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = param1.c;
            var _loc3_:* = param1.o == null ? null : TradingOffer.fromDtos(param1.o);
            var _loc4_:* = param1.n == null ? null : UserNote.fromDtos(param1.n);
            var _loc5_:* = param1.l;
            var _loc6_:* = param1.g;
            UserNoteManager.update(_loc4_);
            _onResult(_loc3_, _loc2_, _loc5_, _loc6_);
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
