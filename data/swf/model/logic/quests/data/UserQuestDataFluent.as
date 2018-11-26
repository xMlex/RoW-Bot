package model.logic.quests.data {
import model.logic.StaticDataManager;

public class UserQuestDataFluent {


    private var _completedQuestIds:Array;

    private var _completedTutorialQuestCount:int;

    private var _exclusionTutorialQuestIds:Array;

    public function UserQuestDataFluent() {
        this._completedQuestIds = new Array();
        this._exclusionTutorialQuestIds = new Array(101, 162);
        super();
    }

    public static function fromDto(param1:*):UserQuestDataFluent {
        var _loc6_:int = 0;
        var _loc2_:UserQuestDataFluent = new UserQuestDataFluent();
        _loc2_._completedQuestIds = param1.c == null ? null : param1.c;
        _loc2_._completedTutorialQuestCount = 0;
        var _loc3_:int = StaticDataManager.questData.tutotialQuestMinPrototypeId;
        var _loc4_:int = StaticDataManager.questData.tutotialQuestMaxPrototypeId;
        var _loc5_:int = 0;
        while (_loc5_ < _loc2_._completedQuestIds.length) {
            _loc6_ = _loc2_._completedQuestIds[_loc5_];
            if (_loc6_ >= _loc3_ && _loc6_ < _loc4_ && _loc2_._exclusionTutorialQuestIds.indexOf(_loc6_) == -1) {
                _loc2_._completedTutorialQuestCount++;
            }
            _loc5_++;
        }
        return _loc2_;
    }

    public function get completedQuestIds():Array {
        return this._completedQuestIds;
    }

    public function get completedTutorialQuestCount():int {
        return this._completedTutorialQuestCount;
    }
}
}
