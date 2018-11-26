package model.logic.quests.completions {
import model.logic.UserManager;

public class QuestCompletionByBuilding extends CompletionCompleter {


    public var sotId:int;

    public var level:int;

    public var countRequired:int;

    public var countBuilt:int;

    public function QuestCompletionByBuilding() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionByBuilding {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionByBuilding = new QuestCompletionByBuilding();
        _loc2_.sotId = param1.i;
        _loc2_.level = param1.l;
        _loc2_.countRequired = param1.r;
        _loc2_.countBuilt = param1.b;
        return _loc2_;
    }

    public static function tryComplete(param1:int, param2:int):void {
        var sotId:int = param1;
        var level:int = param2;
        tryCompleteQuestCompletions(function (param1:QuestCompletion):Boolean {
            var _loc3_:int = 0;
            var _loc2_:QuestCompletionByBuilding = param1.byBuilding;
            if (_loc2_ == null || _loc2_.sotId != sotId || _loc2_.level > level) {
                return false;
            }
            if (_loc2_.countBuilt < 0) {
                _loc3_ = UserManager.user.gameData.sector.getBuildingsCount(sotId, level);
            }
            else {
                _loc3_ = ++_loc2_.countBuilt;
            }
            return _loc3_ >= _loc2_.countRequired;
        });
    }

    public function isCompleted():Boolean {
        var _loc1_:int = 0;
        if (this.countBuilt >= 0) {
            return this.countBuilt >= this.countRequired;
        }
        _loc1_ = UserManager.user.gameData.sector.getBuildingsCount(this.sotId, this.level);
        return _loc1_ >= this.countRequired;
    }

    public function equal(param1:QuestCompletionByBuilding):Boolean {
        if (!param1) {
            return false;
        }
        if (param1.sotId != this.sotId) {
            return false;
        }
        if (param1.level != this.level) {
            return false;
        }
        if (param1.countRequired != this.countRequired) {
            return false;
        }
        if (param1.countBuilt != this.countBuilt) {
            return false;
        }
        return true;
    }
}
}
