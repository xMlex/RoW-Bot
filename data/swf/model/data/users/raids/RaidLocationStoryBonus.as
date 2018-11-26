package model.data.users.raids {
import model.data.Resources;
import model.data.users.troops.Troops;

public class RaidLocationStoryBonus {


    public var resources:Resources;

    public var troops:Troops;

    public var skillPoints:int;

    public function RaidLocationStoryBonus() {
        super();
    }

    public static function fromDto(param1:*):RaidLocationStoryBonus {
        var _loc2_:RaidLocationStoryBonus = new RaidLocationStoryBonus();
        _loc2_.resources = Resources.fromDto(param1.r);
        _loc2_.troops = param1.t == null ? null : Troops.fromDto(param1.t);
        _loc2_.skillPoints = !!isNaN(param1.s) ? 0 : int(param1.s);
        return _loc2_;
    }
}
}
