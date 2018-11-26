package model.data.users.messages {
import model.modules.allianceCity.data.resourceHistory.AllianceResources;

public class AllianceCityMessageInfo {


    public var userInitiator:Number;

    public var cityLevel:int;

    public var allianceResources:AllianceResources;

    public var technologyId:int;

    public var technologyLevel:int;

    public function AllianceCityMessageInfo() {
        super();
    }

    public static function fromDto(param1:*):AllianceCityMessageInfo {
        var _loc2_:AllianceCityMessageInfo = new AllianceCityMessageInfo();
        _loc2_.userInitiator = param1.i;
        _loc2_.cityLevel = param1.l;
        _loc2_.allianceResources = param1.r == null ? null : AllianceResources.fromDto(param1.r);
        _loc2_.technologyId = param1.t;
        _loc2_.technologyLevel = param1.a;
        return _loc2_;
    }
}
}
