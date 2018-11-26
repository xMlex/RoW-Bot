package model.logic.dtoSerializer {
public class ArrayDeserializer {


    private var _dto;

    private var _itemDeserializer:Function;

    public function ArrayDeserializer(param1:*, param2:Function = null) {
        super();
        this._dto = param1;
        this._itemDeserializer = param2;
    }

    public function deserialize():Array {
        if (this._dto == null) {
            return null;
        }
        var _loc1_:Array = [];
        if (this._itemDeserializer == null) {
            _loc1_ = this.deserializeSimpleObject();
        }
        else {
            _loc1_ = this.deserializeCustomObject();
        }
        return _loc1_;
    }

    private function deserializeSimpleObject():Array {
        var _loc2_:* = undefined;
        var _loc1_:Array = [];
        for each(_loc2_ in this._dto) {
            _loc1_.push(_loc2_);
        }
        return _loc1_;
    }

    private function deserializeCustomObject():Array {
        var _loc2_:* = undefined;
        var _loc3_:* = undefined;
        var _loc1_:Array = [];
        for each(_loc2_ in this._dto) {
            _loc3_ = this._itemDeserializer(_loc2_);
            if (_loc3_ != null) {
                _loc1_.push(_loc3_);
            }
        }
        return _loc1_;
    }
}
}
