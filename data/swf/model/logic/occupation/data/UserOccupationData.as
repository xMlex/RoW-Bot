package model.logic.occupation.data {
import common.ArrayCustom;

import gameObjects.observableObject.ObservableObject;

public class UserOccupationData extends ObservableObject {

    public static const CLASS_NAME:String = "UserOccupationData";

    public static const DATA_CHANGED:String = CLASS_NAME + "Changed";


    public var dirty:Boolean;

    public var userOccupationInfos:ArrayCustom;

    public var ownOccupationInfo:UserOccupationInfo;

    public function UserOccupationData() {
        this.userOccupationInfos = new ArrayCustom();
        super();
    }

    public static function fromDto(param1:*):UserOccupationData {
        var _loc2_:UserOccupationData = new UserOccupationData();
        _loc2_.userOccupationInfos = param1 == null || param1.u == null ? new ArrayCustom() : UserOccupationInfo.fromDtos(param1.u);
        _loc2_.ownOccupationInfo = param1 == null || param1.o == null ? null : UserOccupationInfo.fromDto(param1.o);
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
        var _loc3_:UserOccupationData = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        var _loc1_:UserOccupationInfo = null;
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(DATA_CHANGED);
        }
        if (this.ownOccupationInfo != null) {
            this.ownOccupationInfo.dispatchEvents();
        }
        for each(_loc1_ in this.userOccupationInfos) {
            _loc1_.dispatchEvents();
        }
    }

    public function toDto():* {
        var _loc1_:* = {
            "u": (this.userOccupationInfos == null ? null : UserOccupationInfo.toDtos(this.userOccupationInfos)),
            "o": (this.ownOccupationInfo == null ? null : this.ownOccupationInfo.toDto())
        };
        return _loc1_;
    }

    public function getUserInfo(param1:Number):UserOccupationInfo {
        var _loc2_:UserOccupationInfo = null;
        for each(_loc2_ in this.userOccupationInfos) {
            if (_loc2_.userId == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function removeUserInfo(param1:Number):Boolean {
        var _loc2_:int = 0;
        while (_loc2_ < this.userOccupationInfos.length) {
            if (this.userOccupationInfos[_loc2_].userId == param1) {
                this.userOccupationInfos.removeItemAt(_loc2_);
                return true;
            }
            _loc2_++;
        }
        return false;
    }
}
}
