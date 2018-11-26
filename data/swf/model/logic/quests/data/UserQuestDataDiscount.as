package model.logic.quests.data {
import flash.utils.Dictionary;

public class UserQuestDataDiscount {


    public var discountsLeftByPrototypeId:Dictionary;

    public function UserQuestDataDiscount() {
        super();
    }

    public static function fromDto(param1:*):UserQuestDataDiscount {
        var _loc3_:* = undefined;
        var _loc2_:UserQuestDataDiscount = new UserQuestDataDiscount();
        _loc2_.discountsLeftByPrototypeId = new Dictionary();
        if (param1.d != null) {
            for (_loc3_ in param1.d) {
                _loc2_.discountsLeftByPrototypeId[_loc3_] = param1.d[_loc3_];
            }
        }
        return _loc2_;
    }
}
}
