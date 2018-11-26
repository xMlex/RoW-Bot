package model.data.users.achievements {
import common.ArrayCustom;

import flash.utils.Dictionary;

import model.data.Resources;
import model.data.users.troops.Troops;

public class AchievementTypeLevelInfo {


    public var value:Number;

    public var goldMoneyPrize:Number;

    public var troopsPrize:Troops;

    public var resourcesPrize:Resources;

    public var skillsPrize:int;

    public var constructionBlockPrize:int;

    public var blackMarketItemsPrize:Dictionary;

    public var vipPoints:int;

    public var robbery:int;

    public function AchievementTypeLevelInfo() {
        super();
    }

    public static function fromDto(param1:*):AchievementTypeLevelInfo {
        var _loc3_:* = undefined;
        var _loc2_:AchievementTypeLevelInfo = new AchievementTypeLevelInfo();
        _loc2_.value = param1.v;
        _loc2_.goldMoneyPrize = param1.p;
        _loc2_.troopsPrize = !!param1.t ? Troops.fromDto(param1.t) : null;
        _loc2_.resourcesPrize = Resources.fromDto(param1.r);
        _loc2_.skillsPrize = param1.e;
        _loc2_.constructionBlockPrize = param1.c;
        _loc2_.blackMarketItemsPrize = new Dictionary();
        if (param1.b) {
            for (_loc3_ in param1.b) {
                _loc2_.blackMarketItemsPrize[_loc3_] = param1.b[_loc3_];
            }
        }
        _loc2_.vipPoints = param1.z;
        _loc2_.robbery = param1.x;
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
        var _loc3_:AchievementTypeLevelInfo = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "v": this.value,
            "p": this.goldMoneyPrize,
            "t": this.troopsPrize,
            "r": this.resourcesPrize,
            "e": this.skillsPrize
        };
        return _loc1_;
    }
}
}
