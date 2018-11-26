package model.data.temporarySkins {
import flash.utils.Dictionary;

public class TemporarySkinBox {


    public var skin:TemporarySkin;

    public var count:int;

    public function TemporarySkinBox() {
        super();
    }

    public static function fromDto(param1:*):TemporarySkinBox {
        var _loc2_:TemporarySkinBox = new TemporarySkinBox();
        _loc2_.skin = param1.s != null ? TemporarySkin.fromDto(param1.s) : null;
        _loc2_.count = param1.c;
        return _loc2_;
    }

    public static function fromDtos(param1:*):Dictionary {
        var _loc3_:* = undefined;
        if (param1 == null) {
            return new Dictionary();
        }
        var _loc2_:Dictionary = new Dictionary();
        for (_loc3_ in param1) {
            _loc2_[_loc3_] = fromDto(param1[_loc3_]);
        }
        return _loc2_;
    }

    public function clone():TemporarySkinBox {
        var _loc1_:TemporarySkinBox = new TemporarySkinBox();
        _loc1_.count = this.count;
        _loc1_.skin = this.skin.clone();
        return _loc1_;
    }
}
}
