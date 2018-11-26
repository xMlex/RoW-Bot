package model.logic.dtoSerializer {
import flash.utils.Dictionary;

public class DictionaryDeserializer {


    private var _dto;

    private var _itemDeserializer:Function;

    private var _keyDeserializer:Function;

    public function DictionaryDeserializer(param1:*, param2:Function = null, param3:Function = null) {
        super();
        this._dto = param1;
        this._itemDeserializer = param3;
        this._keyDeserializer = param2;
    }

    public function deserialize():Dictionary {
        var _loc2_:* = undefined;
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        if (this._dto == null) {
            return null;
        }
        var _loc1_:Dictionary = new Dictionary();
        for (_loc2_ in this._dto) {
            _loc3_ = this._keyDeserializer == null ? _loc2_ : this._keyDeserializer(_loc2_);
            _loc4_ = this._itemDeserializer == null ? this._dto[_loc2_] : this._itemDeserializer(this._dto[_loc2_]);
            _loc1_[_loc3_] = _loc4_;
        }
        return _loc1_;
    }
}
}
