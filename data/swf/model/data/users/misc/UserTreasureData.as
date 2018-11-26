package model.data.users.misc {
import common.ArrayCustom;

import flash.utils.Dictionary;

import gameObjects.observableObject.ObservableObject;

import model.data.Resources;

public class UserTreasureData extends ObservableObject {

    public static const CLASS_NAME:String = "UserTreasureData";

    public static const BOXES_CHANGED:String = CLASS_NAME + "BoxesChanged";


    public var lastBoxId:Number;

    public var userBoxesQuantity:Resources;

    public var friendsBoxesQuantity:Resources;

    public var boxesValues:Resources;

    public var boxesByUsers:Dictionary;

    public var dirty:Boolean = false;

    public function UserTreasureData() {
        super();
    }

    public static function fromDto(param1:*):UserTreasureData {
        var _loc3_:* = undefined;
        var _loc2_:UserTreasureData = new UserTreasureData();
        _loc2_.lastBoxId = param1.i == null ? Number(-1) : Number(param1.i);
        _loc2_.userBoxesQuantity = Resources.fromDto(param1.u);
        _loc2_.friendsBoxesQuantity = Resources.fromDto(param1.f);
        _loc2_.boxesValues = Resources.fromDto(param1.v);
        _loc2_.boxesByUsers = new Dictionary();
        for (_loc3_ in param1.p) {
            _loc2_.boxesByUsers[_loc3_] = param1.p[_loc3_];
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
        var _loc3_:UserTreasureData = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty == true) {
            this.dirty = false;
            dispatchEvent(BOXES_CHANGED);
        }
    }

    public function toDto():* {
        var _loc2_:* = undefined;
        var _loc1_:* = {
            "u": (this.userBoxesQuantity == null ? null : this.userBoxesQuantity.toDto()),
            "f": (this.friendsBoxesQuantity == null ? null : this.friendsBoxesQuantity.toDto()),
            "v": (this.boxesValues == null ? null : this.boxesValues.toDto()),
            "p": {}
        };
        for (_loc2_ in this.boxesByUsers) {
            _loc1_.p[_loc2_] = this.boxesByUsers[_loc2_];
        }
        return _loc1_;
    }
}
}
