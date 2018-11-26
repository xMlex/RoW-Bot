package model.logic.misc {
public final class CustomCmd {


    public var name:String;

    public var type:int;

    public var token:String;

    public var timeout:int = 0;

    public var parameters:Array;

    public var resultUrl:String = "";

    public function CustomCmd() {
        super();
    }

    public static function fromDto(param1:Object):CustomCmd {
        var _loc2_:CustomCmd = new CustomCmd();
        if (param1.hasOwnProperty("t")) {
            _loc2_.type = param1.t;
        }
        if (param1.hasOwnProperty("o")) {
            _loc2_.token = param1.o;
        }
        if (param1.hasOwnProperty("p")) {
            _loc2_.parameters = param1.p;
        }
        if (param1.hasOwnProperty("m")) {
            _loc2_.timeout = param1.m;
        }
        if (_loc2_.parameters != null && _loc2_.parameters.length > 0) {
            _loc2_.name = _loc2_.parameters[0];
        }
        return _loc2_;
    }
}
}
