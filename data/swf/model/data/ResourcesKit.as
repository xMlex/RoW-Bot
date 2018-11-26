package model.data {
import common.ArrayCustom;

public class ResourcesKit {


    public var id:int;

    public var fromLevel:int;

    public var toLevel:int;

    public var price:Resources;

    public var resources:Resources;

    public var img:String;

    public function ResourcesKit() {
        super();
    }

    public static function fromDto(param1:*):ResourcesKit {
        var _loc2_:ResourcesKit = new ResourcesKit();
        _loc2_.id = param1.i;
        _loc2_.fromLevel = param1.l;
        _loc2_.toLevel = param1.t;
        _loc2_.price = Resources.fromDto(param1.p);
        _loc2_.resources = Resources.fromDto(param1.r);
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
        var _loc3_:ResourcesKit = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.id,
            "l": this.fromLevel,
            "t": this.toLevel,
            "p": (this.price == null ? null : this.price.toDto()),
            "r": (this.resources == null ? null : this.resources.toDto())
        };
        return _loc1_;
    }
}
}
