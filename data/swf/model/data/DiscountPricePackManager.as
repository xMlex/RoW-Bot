package model.data {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.utils.Dictionary;

import model.logic.quests.data.QuestDepositDiscount;

public class DiscountPricePackManager {

    public static const CLASS_NAME:String = "DiscountPricePackManager";

    public static const PACKS_ADDED:String = CLASS_NAME + "_PackAdded";

    private static var _packs:Dictionary = new Dictionary();

    private static var _eventDispatcher:IEventDispatcher = new EventDispatcher();


    public function DiscountPricePackManager() {
        super();
    }

    public static function get eventDispatcher():IEventDispatcher {
        return _eventDispatcher;
    }

    public static function addPacksDto(param1:*):void {
        var _loc2_:* = undefined;
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:* = undefined;
        var _loc7_:QuestDepositDiscount = null;
        if (param1 == null) {
            return;
        }
        for each(_loc2_ in param1) {
            if (_loc2_ != null) {
                _loc3_ = _loc2_.id;
                _loc4_ = _loc2_.rid;
                _loc5_ = _loc2_.dpt;
                if (_loc2_.packs != null) {
                    for each(_loc6_ in _loc2_.packs) {
                        _loc7_ = new QuestDepositDiscount();
                        _loc7_.priceId = _loc3_;
                        _loc7_.priceRefId = _loc4_;
                        _loc7_.currency = _loc6_.d;
                        _loc7_.type = _loc6_.dt;
                        _loc7_.amountNew = _loc6_.p;
                        _loc7_.amountOld = _loc6_.op == null ? Number(0) : Number(_loc6_.op);
                        _loc7_.discountPercent = _loc5_;
                        _loc7_.goldMoney = _loc6_.g;
                        _loc7_.goldMoneyBonus = _loc6_.b;
                        addPricePack(_loc7_);
                    }
                }
            }
        }
        _eventDispatcher.dispatchEvent(new Event(DiscountPricePackManager.PACKS_ADDED));
    }

    public static function getDiscountPricePack(param1:int, param2:String):QuestDepositDiscount {
        var _loc3_:QuestDepositDiscount = null;
        var _loc4_:Dictionary = _packs[param1];
        if (_loc4_ != null) {
            _loc3_ = _loc4_[param2];
        }
        return _loc3_;
    }

    public static function getPricePackDictionary(param1:int):Dictionary {
        return _packs[param1];
    }

    public static function hasPricePack(param1:int):Boolean {
        return _packs[param1] != null;
    }

    public static function addPricePack(param1:QuestDepositDiscount):void {
        var _loc2_:int = param1.priceId;
        var _loc3_:String = param1.currency;
        var _loc4_:Dictionary = _packs[_loc2_];
        if (_loc4_ == null) {
            _loc4_ = addNewPricePacksDictionary(_loc2_);
        }
        _loc4_[_loc3_] = param1;
    }

    private static function addNewPricePacksDictionary(param1:int):Dictionary {
        var _loc2_:Dictionary = new Dictionary();
        _packs[param1] = _loc2_;
        return _loc2_;
    }
}
}
