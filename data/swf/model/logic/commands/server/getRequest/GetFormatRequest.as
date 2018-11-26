package model.logic.commands.server.getRequest {
public class GetFormatRequest {


    private var _parameters:Vector.<GetRequestParameter>;

    public function GetFormatRequest() {
        super();
        this._parameters = new Vector.<GetRequestParameter>();
    }

    public function addParameter(param1:String, param2:Object):void {
        var _loc3_:GetRequestParameter = new GetRequestParameter(param1, param2);
        this._parameters.push(_loc3_);
    }

    public function get count():int {
        return this._parameters.length;
    }

    public function toString():String {
        var _loc4_:GetRequestParameter = null;
        var _loc1_:String = "";
        var _loc2_:int = this._parameters.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc1_ = _loc1_ + (_loc3_ > 0 ? "&" : "?");
            _loc4_ = this._parameters[_loc3_];
            _loc1_ = _loc1_ + _loc4_.toString();
            _loc3_++;
        }
        return _loc1_;
    }
}
}
