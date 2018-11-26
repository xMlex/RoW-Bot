package model.data.users.misc {
import common.ArrayCustom;

import flash.events.Event;
import flash.events.EventDispatcher;

public class UserGameSettings {

    public static const ANIMATION_CHANGED:String = "UserGameSettings.ANIMATION_CHANGED";

    private static const events:EventDispatcher = new EventDispatcher();


    public var interactiveFullScreenMode:Boolean;

    private var _animationEnabled:Boolean;

    public var slidingSectorEnabled:Boolean;

    public var mapGridEnabled:Boolean;

    public var locale:String;

    public var zoomValue:Number;

    public var soundsEnabled:Boolean;

    public var musicEnabled:Boolean;

    public var sortOrder:int;

    public var pageNumber:int;

    public var soundNotificationEnabledForUserMessages:Boolean = true;

    public var soundNotificationEnabledForMilitaryMessages:Boolean = true;

    public var soundNotificationEnabledForTradeMessages:Boolean = true;

    public var soundNotificationEnabledForDiplomaticMessages:Boolean = true;

    public var soundNotificationEnabledForScientificMessages:Boolean = true;

    public function UserGameSettings() {
        super();
    }

    public static function fromDto(param1:*):UserGameSettings {
        var _loc2_:UserGameSettings = new UserGameSettings();
        _loc2_._animationEnabled = param1.a;
        _loc2_.soundsEnabled = param1.s;
        _loc2_.musicEnabled = param1.m;
        _loc2_.slidingSectorEnabled = param1.l;
        _loc2_.mapGridEnabled = param1.g;
        _loc2_.locale = param1.c;
        _loc2_.interactiveFullScreenMode = param1.f;
        _loc2_.sortOrder = param1.o;
        _loc2_.pageNumber = param1.p;
        if (param1.hasOwnProperty("z")) {
            _loc2_.zoomValue = param1.z;
        }
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
        var _loc3_:UserGameSettings = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public static function addEventHandler(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        events.addEventListener(param1, param2, param3, param4, param5);
    }

    public static function removeEventHandler(param1:String, param2:Function):void {
        events.removeEventListener(param1, param2);
    }

    public static function hasEventHandler(param1:String):Boolean {
        return events.hasEventListener(param1);
    }

    public function toDto():* {
        var _loc1_:* = {
            "a": this._animationEnabled,
            "s": this.soundsEnabled,
            "m": this.musicEnabled,
            "l": this.slidingSectorEnabled,
            "g": this.mapGridEnabled,
            "f": this.interactiveFullScreenMode,
            "c": this.locale,
            "o": this.sortOrder,
            "p": this.pageNumber
        };
        if (!isNaN(this.zoomValue)) {
            _loc1_.z = this.zoomValue;
        }
        return _loc1_;
    }

    public function get animationEnabled():Boolean {
        return this._animationEnabled;
    }

    public function set animationEnabled(param1:Boolean):void {
        if (this._animationEnabled != param1) {
            this._animationEnabled = param1;
            events.dispatchEvent(new Event(ANIMATION_CHANGED));
        }
    }
}
}
