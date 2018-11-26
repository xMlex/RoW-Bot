package model.data.users.troops {
import common.ArrayCustom;

import model.data.Resources;

public class RobberyResult {


    public var status:int;

    public var resources:Resources;

    public var bonusResources:Resources;

    public function RobberyResult() {
        super();
    }

    public static function fromDto(param1:*):RobberyResult {
        var _loc2_:RobberyResult = new RobberyResult();
        _loc2_.status = param1.s;
        _loc2_.resources = param1.r == null ? null : Resources.fromDto(param1.r);
        _loc2_.bonusResources = param1.b == null ? null : Resources.fromDto(param1.b);
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
        var _loc3_:RobberyResult = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function get totalResources():Resources {
        if (this.resources == null) {
            return null;
        }
        var _loc1_:Resources = this.resources.clone();
        if (this.bonusResources != null) {
            _loc1_.add(this.bonusResources);
        }
        return _loc1_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "s": this.status,
            "r": (this.resources == null ? null : this.resources.toDto()),
            "b": (this.bonusResources == null ? null : this.bonusResources.toDto())
        };
        return _loc1_;
    }
}
}
