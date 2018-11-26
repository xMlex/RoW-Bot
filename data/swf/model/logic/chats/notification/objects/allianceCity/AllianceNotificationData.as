package model.logic.chats.notification.objects.allianceCity {
import model.data.map.MapPos;
import model.modules.allianceCity.data.resourceHistory.AllianceResources;

public class AllianceNotificationData {


    public var cityId:Number;

    public var enemyCityId:Number;

    public var techId:Number;

    public var startTime:Date;

    public var finishTime:Date;

    public var teleportationTime:Date;

    public var downgradeTime:Date;

    public var position:MapPos;

    public var allianceResources:AllianceResources;

    public var level:int;

    public function AllianceNotificationData() {
        super();
    }

    public static function fromDto(param1:*):AllianceNotificationData {
        var _loc2_:AllianceNotificationData = new AllianceNotificationData();
        _loc2_.cityId = param1.i == null ? Number(null) : Number(param1.i);
        _loc2_.enemyCityId = param1.e == null ? Number(null) : Number(param1.e);
        _loc2_.techId = param1.t == null ? Number(null) : Number(param1.t);
        _loc2_.startTime = param1.s == null ? null : new Date(param1.s);
        _loc2_.finishTime = param1.f == null ? null : new Date(param1.f);
        _loc2_.teleportationTime = param1.n == null ? null : new Date(param1.n);
        _loc2_.downgradeTime = param1.d == null ? null : new Date(param1.d);
        _loc2_.position = param1.p == null ? null : MapPos.fromDto(param1.p);
        _loc2_.allianceResources = param1.r == null ? null : AllianceResources.fromDto(param1.r);
        _loc2_.level = param1.l == null ? int(null) : int(param1.l);
        return _loc2_;
    }
}
}
