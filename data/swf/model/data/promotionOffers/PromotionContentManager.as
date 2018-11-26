package model.data.promotionOffers {
import common.StringUtil;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.utils.Dictionary;

public class PromotionContentManager {

    public static const CLASS_NAME:String = "DiscountPricePackManager";

    public static const CONTENT_ADDED:String = CLASS_NAME + "_PackAdded";

    private static var _localizations:Dictionary = new Dictionary();

    private static var _images:Dictionary = new Dictionary();

    private static var _eventDispatcher:IEventDispatcher = new EventDispatcher();


    public function PromotionContentManager() {
        super();
    }

    public static function get eventDispatcher():IEventDispatcher {
        return _eventDispatcher;
    }

    public static function getLocalizationById(param1:int):String {
        return _localizations[param1];
    }

    public static function getImageUrlById(param1:int):String {
        return _images[param1];
    }

    public static function hasLocalizationById(param1:int):Boolean {
        return _localizations[param1] != undefined;
    }

    public static function hasImageUrlById(param1:int):Boolean {
        return _images[param1] != undefined;
    }

    public static function addContent(param1:*):void {
        var _loc2_:* = undefined;
        var _loc3_:int = 0;
        var _loc4_:String = null;
        var _loc5_:* = undefined;
        var _loc6_:int = 0;
        var _loc7_:String = null;
        if (param1 == null) {
            return;
        }
        if (param1.l != null) {
            for each(_loc2_ in param1.l) {
                _loc3_ = _loc2_.i;
                _loc4_ = _loc2_.t;
                addLocalization(_loc3_, _loc4_);
            }
        }
        if (param1.i != null) {
            for each(_loc5_ in param1.i) {
                _loc6_ = _loc5_.i;
                _loc7_ = _loc5_.u;
                addImageUrl(_loc6_, _loc7_);
            }
        }
        _eventDispatcher.dispatchEvent(new Event(PromotionContentManager.CONTENT_ADDED));
    }

    private static function addLocalization(param1:int, param2:String):void {
        _localizations[param1] = validateText(param2);
    }

    private static function addImageUrl(param1:int, param2:String):void {
        _images[param1] = param2;
    }

    private static function validateText(param1:String):String {
        var _loc2_:String = "\\n";
        return param1.replace(_loc2_, StringUtil.NEW_LINE);
    }
}
}
