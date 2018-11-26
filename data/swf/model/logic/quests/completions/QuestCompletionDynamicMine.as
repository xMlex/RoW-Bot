package model.logic.quests.completions {
import flash.utils.Dictionary;

public class QuestCompletionDynamicMine {

    public static const ACTION_CAPTURE_AND_DEFEND:int = 1;

    public static const ACTION_CAPTURE_AND_COLLECT:int = 2;

    public static const ACTION_FIGHT_OFF:int = 3;


    public var actionType:int;

    public var resourceTypeId:int;

    public var level:int;

    public var minutesToDefend:Number;

    public var defendingStartTimeByLocationId:Dictionary;

    public var resourcesToCollect:Number;

    public var resourcesCollected:Number;

    public function QuestCompletionDynamicMine() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionDynamicMine {
        var _loc3_:* = undefined;
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionDynamicMine = new QuestCompletionDynamicMine();
        _loc2_.actionType = param1.a;
        _loc2_.resourceTypeId = param1.r;
        _loc2_.level = param1.l;
        _loc2_.minutesToDefend = param1.m;
        if (param1.s != null) {
            _loc2_.defendingStartTimeByLocationId = new Dictionary();
            for (_loc3_ in param1.s) {
                _loc2_.defendingStartTimeByLocationId[_loc3_] = new Date(param1.s[_loc3_]);
            }
        }
        _loc2_.resourcesToCollect = param1.c;
        _loc2_.resourcesCollected = param1.f;
        return _loc2_;
    }
}
}
