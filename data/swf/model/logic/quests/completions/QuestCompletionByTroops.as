package model.logic.quests.completions {
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.TroopsTypeId;
import model.data.users.troops.Troops;
import model.logic.StaticDataManager;
import model.logic.UserManager;

public class QuestCompletionByTroops extends CompletionCompleter {


    public var troopsTypeId:int;

    public var troopsGroupId:int = -1;

    public var countRequired:int;

    public var countBuilt:int;

    public var strictTypeMatch:Boolean;

    public function QuestCompletionByTroops() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionByTroops {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionByTroops = new QuestCompletionByTroops();
        _loc2_.troopsTypeId = param1.i;
        _loc2_.countRequired = param1.r;
        _loc2_.countBuilt = param1.b;
        _loc2_.strictTypeMatch = param1.s;
        return _loc2_;
    }

    public static function tryComplete(param1:int, param2:int):void {
        var troopsTypeId:int = param1;
        var countBuilt:int = param2;
        tryCompleteQuestCompletions(function (param1:QuestCompletion):Boolean {
            var _loc4_:* = undefined;
            var _loc5_:GeoSceneObjectType = null;
            var _loc2_:QuestCompletionByTroops = param1.byTroops;
            if (_loc2_ == null || getUnifiedId(_loc2_.troopsTypeId, _loc2_.strictTypeMatch) != getUnifiedId(troopsTypeId, _loc2_.strictTypeMatch)) {
                return false;
            }
            var _loc3_:Troops = UserManager.user.gameData.troopsData.troops;
            if (_loc2_.troopsGroupId >= 0) {
                for (_loc4_ in _loc3_.countByType) {
                    _loc5_ = StaticDataManager.getObjectType(_loc4_);
                    if (_loc5_.troopsInfo != null && _loc5_.troopsInfo.groupId == _loc2_.troopsGroupId) {
                        return true;
                    }
                }
            }
            if (_loc2_.countBuilt < 0) {
                if (!_loc2_.strictTypeMatch) {
                    countBuilt = _loc3_.get(troopsTypeId);
                }
                else {
                    countBuilt = _loc3_.get(TroopsTypeId.ToRegular(troopsTypeId)) + _loc3_.get(TroopsTypeId.ToGold(troopsTypeId));
                }
            }
            else {
                _loc2_.countBuilt = _loc2_.countBuilt + countBuilt;
            }
            return countBuilt >= _loc2_.countRequired;
        });
    }

    private static function getUnifiedId(param1:int, param2:Boolean):int {
        return !!param2 ? int(param1) : int(TroopsTypeId.ToGold(param1));
    }

    public function isCompleted():Boolean {
        var _loc2_:* = undefined;
        var _loc3_:GeoSceneObjectType = null;
        var _loc4_:int = 0;
        var _loc1_:Troops = UserManager.user.gameData.troopsData.troops;
        if (this.troopsGroupId >= 0) {
            for (_loc2_ in _loc1_.countByType) {
                _loc3_ = StaticDataManager.getObjectType(_loc2_);
                if (_loc3_.troopsInfo != null && _loc3_.troopsInfo.groupId == this.troopsGroupId) {
                    return true;
                }
            }
        }
        if (this.countBuilt >= 0) {
            return this.countBuilt >= this.countRequired;
        }
        if (!this.strictTypeMatch) {
            _loc4_ = _loc1_.get(this.troopsTypeId);
        }
        else {
            _loc4_ = _loc1_.get(TroopsTypeId.ToRegular(this.troopsTypeId)) + _loc1_.get(TroopsTypeId.ToGold(this.troopsTypeId));
        }
        return _loc4_ >= this.countRequired;
    }

    public function equal(param1:QuestCompletionByTroops):Boolean {
        if (!param1) {
            return false;
        }
        if (param1.troopsTypeId != this.troopsTypeId) {
            return false;
        }
        if (param1.countRequired != this.countRequired) {
            return false;
        }
        if (param1.countBuilt != this.countBuilt) {
            return false;
        }
        if (param1.strictTypeMatch != this.strictTypeMatch) {
            return false;
        }
        return true;
    }
}
}
