package model.data.alliances {
public class AllianceSearchItem {


    public var allianceId:Number;

    public var segmentId:int;

    public var vacanciesCount:int;

    public var academyEnabled:Boolean;

    public var academyVacanciesCount:int;

    public var academyMinUserLevel:int;

    public var language:int;

    public var ratingPosition:int;

    public var photoUrl:String;

    public function AllianceSearchItem() {
        super();
    }

    public static function fromDto(param1:*):AllianceSearchItem {
        var _loc2_:AllianceSearchItem = new AllianceSearchItem();
        _loc2_.allianceId = param1.i == null ? Number(0) : Number(param1.i);
        _loc2_.segmentId = param1.s == null ? -1 : int(param1.s);
        _loc2_.vacanciesCount = param1.f == null ? 0 : int(param1.f);
        _loc2_.academyEnabled = param1.e == null ? true : Boolean(param1.e);
        _loc2_.academyVacanciesCount = param1.v == null ? 0 : int(param1.v);
        _loc2_.academyMinUserLevel = param1.l == null ? int(AllianceAcademyData.MIN_USER_LEVEL) : int(param1.l);
        _loc2_.language = param1.a == null ? 0 : int(param1.a);
        _loc2_.ratingPosition = param1.r == null ? 0 : int(param1.r);
        _loc2_.photoUrl = param1.p == null ? "" : param1.p;
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
