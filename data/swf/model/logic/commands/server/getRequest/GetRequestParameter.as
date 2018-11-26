package model.logic.commands.server.getRequest {
public class GetRequestParameter {


    private var _letter:String;

    private var _data:Object;

    public function GetRequestParameter(param1:String, param2:Object) {
        super();
        this._letter = param1;
        this._data = param2;
    }

    public function toString():String {
        var _loc1_:String = null;
        var _loc2_:* = this._data.toString();
        if (this._data is Array) {
            _loc2_ = "[" + this._data.toString() + "]";
        }
        _loc1_ = this._letter + "=" + _loc2_;
        return _loc1_;
    }
}
}
