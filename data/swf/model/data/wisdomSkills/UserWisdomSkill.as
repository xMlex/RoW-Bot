package model.data.wisdomSkills {
import common.IEquatable;

public class UserWisdomSkill implements IEquatable {


    public var id:int;

    public function UserWisdomSkill() {
        super();
    }

    public static function fromDto(param1:*):UserWisdomSkill {
        var _loc2_:UserWisdomSkill = new UserWisdomSkill();
        _loc2_.id = param1.i;
        return _loc2_;
    }

    public static function fromId(param1:int):UserWisdomSkill {
        var _loc2_:UserWisdomSkill = new UserWisdomSkill();
        _loc2_.id = param1;
        return _loc2_;
    }

    public function isEqual(param1:*):Boolean {
        if (param1 == null) {
            return false;
        }
        return this.id == param1.id;
    }
}
}
