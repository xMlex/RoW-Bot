package model.logic.dtoSerializer {
public class ObjectDeserializer {


    private var _dto;

    private var _itemDeserializer:Function;

    public function ObjectDeserializer(param1:*, param2:Function = null) {
        super();
        this._dto = param1;
        this._itemDeserializer = param2;
    }

    public function deserialize():Object {
        if (this._dto == null) {
            return null;
        }
        var _loc1_:Object = {};
        if (this._itemDeserializer == null) {
            _loc1_ = this.deserializeSimpleObject();
        }
        else {
            _loc1_ = this.deserializeCustomObject();
        }
        return _loc1_;
    }

    private function deserializeSimpleObject():Object {
        var _loc2_:* = undefined;
        var _loc1_:Object = {};
        for (_loc2_ in this._dto) {
            _loc1_[_loc2_] = this._dto[_loc2_];
        }
        return _loc1_;
    }

    private function deserializeCustomObject():Object {
        var _loc2_:* = undefined;
        var _loc1_:Object = {};
        for (_loc2_ in this._dto) {
            _loc1_[_loc2_] = this._itemDeserializer(this._dto[_loc2_]);
        }
        return _loc1_;
    }
}
}
