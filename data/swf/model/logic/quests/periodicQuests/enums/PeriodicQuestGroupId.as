package model.logic.quests.periodicQuests.enums {
public class PeriodicQuestGroupId {

    public static const DAILY:int = 1;

    public static const WEEKLY:int = 2;

    public static const MONTHLY:int = 3;


    public function PeriodicQuestGroupId() {
        super();
    }

    public static function toObject():Object {
        var _loc1_:Object = {};
        _loc1_[DAILY] = null;
        _loc1_[WEEKLY] = null;
        _loc1_[MONTHLY] = null;
        return _loc1_;
    }
}
}
