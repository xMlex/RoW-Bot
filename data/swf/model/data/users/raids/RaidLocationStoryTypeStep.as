package model.data.users.raids {
import common.ArrayCustom;

public class RaidLocationStoryTypeStep {


    public var stepId:int;

    public var storyId:int;

    public var name:String;

    public var pictureUrl:String;

    public var intro:String;

    public var raidLocationTypeIdAttacking:int;

    public var raidLocationTypeIdDefensive:int;

    public var attackingLocationBonus:RaidLocationStoryBonus;

    public var defensiveLocationBonus:RaidLocationStoryBonus;

    public var raidLocationLevel:int;

    public var startLevel:int;

    public var startLevelB:int;

    public var startDate:Date;

    public function RaidLocationStoryTypeStep() {
        super();
    }

    public static function fromDto(param1:*):RaidLocationStoryTypeStep {
        var _loc2_:RaidLocationStoryTypeStep = new RaidLocationStoryTypeStep();
        _loc2_.stepId = param1.i;
        _loc2_.storyId = param1.e;
        _loc2_.name = param1.n.c;
        _loc2_.pictureUrl = param1.p;
        _loc2_.intro = param1.r.c;
        _loc2_.raidLocationTypeIdAttacking = !!isNaN(param1.a) ? 0 : int(param1.a);
        _loc2_.raidLocationTypeIdDefensive = !!isNaN(param1.d) ? 0 : int(param1.d);
        _loc2_.raidLocationLevel = param1.v;
        _loc2_.startLevel = param1.l;
        _loc2_.startLevelB = param1.lb;
        _loc2_.attackingLocationBonus = RaidLocationStoryBonus.fromDto(param1.ab);
        _loc2_.defensiveLocationBonus = RaidLocationStoryBonus.fromDto(param1.db);
        _loc2_.startDate = param1.dg == null ? null : new Date(param1.dg);
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
