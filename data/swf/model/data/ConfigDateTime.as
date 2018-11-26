package model.data {
public class ConfigDateTime {


    public var year:Number;

    public var month:Number;

    public var day:Number;

    public var hour:Number;

    public var minute:Number;

    public var second:Number;

    public function ConfigDateTime(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) {
        super();
        this.year = param1;
        this.month = param2;
        this.day = param3;
        this.hour = param4;
        this.minute = param5;
        this.second = param6;
    }

    public static function fromDto(param1:*):ConfigDateTime {
        if (param1 == null) {
            return null;
        }
        var _loc2_:Number = param1.Year;
        var _loc3_:Number = param1.Month - 1;
        var _loc4_:Number = param1.Day;
        var _loc5_:Number = param1.Hour;
        var _loc6_:Number = param1.Minute;
        var _loc7_:Number = param1.Second;
        return new ConfigDateTime(_loc2_, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_);
    }

    public function toDate():Date {
        var _loc1_:Date = new Date(this.year, this.month, this.day, this.hour, this.minute, this.second);
        _loc1_.setUTCFullYear(this.year);
        _loc1_.setUTCMonth(this.month);
        _loc1_.setUTCDate(this.day);
        _loc1_.setUTCHours(this.hour);
        _loc1_.setUTCMinutes(this.minute);
        _loc1_.setUTCSeconds(this.second);
        return _loc1_;
    }
}
}
