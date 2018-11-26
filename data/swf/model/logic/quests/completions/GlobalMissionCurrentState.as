package model.logic.quests.completions {
import model.logic.UserManager;

public class GlobalMissionCurrentState {

    public static var globalMissionWonQuestPrototypeIds:Array = [];

    public static var globalMissionLostQuestPrototypeIds:Array = [];


    public var state:int;

    public var userBonus:Number;

    public var userLeague:Number;

    public var totalBonusCurrent:Number;

    public var totalBonusRequired:Number;

    public function GlobalMissionCurrentState() {
        super();
    }

    public static function getMissionStateById(param1:int):int {
        var _loc2_:int = 0;
        for each(_loc2_ in globalMissionWonQuestPrototypeIds) {
            if (_loc2_ == param1) {
                return GlobalMissionStateTypeId.WON;
            }
        }
        for each(_loc2_ in globalMissionLostQuestPrototypeIds) {
            if (_loc2_ == param1) {
                return GlobalMissionStateTypeId.LOST;
            }
        }
        if (UserManager.user.gameData.questData.hasOpenedQuest(param1)) {
            return GlobalMissionStateTypeId.IN_PROGRESS;
        }
        return GlobalMissionStateTypeId.NONE;
    }

    public static function fromDto(param1:*):GlobalMissionCurrentState {
        if (param1 == null) {
            return null;
        }
        var _loc2_:GlobalMissionCurrentState = new GlobalMissionCurrentState();
        _loc2_.userBonus = param1.b;
        _loc2_.userLeague = param1.l;
        _loc2_.state = param1.s;
        _loc2_.totalBonusCurrent = param1.c;
        _loc2_.totalBonusRequired = param1.n;
        return _loc2_;
    }
}
}
