package model.data.users.achievements {
import common.ArrayCustom;

import flash.utils.Dictionary;

import model.data.Resources;
import model.data.users.troops.Troops;

public class Achievement {


    public var typeId:int;

    public var level:int;

    public var isRead:Boolean;

    public var isPrizeAvailable:Boolean;

    public var goldMoneyPrize:Number;

    public var troops:Troops;

    public var resources:Resources;

    public var skillPoints:int;

    public var constructionBlockPrize:int;

    public var blackMarketItemsPrize:Dictionary;

    public var vipPoints:int;

    public var robberyLimit:int;

    public function Achievement() {
        super();
    }

    public static function fromDto(param1:*):Achievement {
        var _loc3_:* = undefined;
        var _loc2_:Achievement = new Achievement();
        _loc2_.typeId = param1.i;
        _loc2_.level = param1.l;
        _loc2_.isRead = param1.r;
        _loc2_.isPrizeAvailable = param1.a;
        _loc2_.goldMoneyPrize = param1.p;
        _loc2_.troops = param1.t == null ? null : Troops.fromDto(param1.t);
        _loc2_.resources = Resources.fromDto(param1.s);
        _loc2_.skillPoints = param1.e;
        _loc2_.constructionBlockPrize = param1.c;
        _loc2_.blackMarketItemsPrize = new Dictionary();
        if (param1.b) {
            for (_loc3_ in param1.b) {
                _loc2_.blackMarketItemsPrize[_loc3_] = param1.b[_loc3_];
            }
        }
        _loc2_.vipPoints = param1.z;
        _loc2_.robberyLimit = param1.x;
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function toDtos(param1:ArrayCustom):Array {
        var _loc3_:Achievement = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.typeId,
            "l": this.level,
            "r": this.isRead,
            "p": this.goldMoneyPrize
        };
        return _loc1_;
    }
}
}
