package model.data.alliances.city {
public class AllianceCityBattleInfo {


    public var cityId:Number;

    public var downgraded:Boolean;

    public var newLevel:int;

    public function AllianceCityBattleInfo() {
        super();
    }

    public static function fromDto(param1:*):AllianceCityBattleInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:AllianceCityBattleInfo = new AllianceCityBattleInfo();
        _loc2_.cityId = param1.i;
        _loc2_.downgraded = param1.d;
        _loc2_.newLevel = param1.l;
        return _loc2_;
    }
}
}
