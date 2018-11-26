package model.logic.commands.server {
public class FaultDto {


    public var code:int;

    public var message:String;

    public var methodName:String;

    public var url:String;

    public var request:String;

    public var response:String;

    public var socialId:String;

    public var date:Date;

    public var httpStatus:int;

    public function FaultDto(param1:int = 0, param2:String = "") {
        super();
        this.code = param1;
        this.message = param2;
    }

    public static function fromJson(param1:*):FaultDto {
        var _loc2_:FaultDto = new FaultDto();
        _loc2_.code = param1.c;
        _loc2_.message = param1.m;
        return _loc2_;
    }

    public function toString():String {
        var _loc1_:* = "segmentServerAddress: " + this.url + " \n";
        _loc1_ = _loc1_ + ("geotopiaLogicExceptionCode: " + this.code + " \n");
        _loc1_ = _loc1_ + ("methodName: " + this.methodName + " \n");
        _loc1_ = _loc1_ + ("socialId: " + this.socialId + " \n");
        _loc1_ = _loc1_ + ("requestDto: " + this.request + " \n");
        _loc1_ = _loc1_ + ("responseDto: " + this.response + " \n");
        _loc1_ = _loc1_ + ("httpStatus: " + this.httpStatus + " \n");
        if (this.date != null) {
            _loc1_ = _loc1_ + ("date: " + this.date.toUTCString() + " \n");
        }
        return _loc1_;
    }

    public function setAdditionalProperty(param1:String, param2:String, param3:String, param4:String, param5:Date, param6:int, param7:String = null):void {
        this.methodName = param1;
        this.url = param2;
        this.request = param3;
        this.response = param7;
        this.socialId = param4;
        this.date = param5;
        this.httpStatus = param6;
    }
}
}
