package model.logic.skills.data {
import common.ArrayCustom;

public class SkillType {


    public var id:int;

    public var name:String;

    public var iconUrl:String;

    public var x:int;

    public var y:int;

    public var requiredSkills:ArrayCustom;

    public var effectTypeId:int;

    public var levelInfos:ArrayCustom;

    public var affectedTypes:ArrayCustom;

    public function SkillType() {
        super();
    }

    public static function fromDto(param1:*):SkillType {
        var _loc2_:SkillType = new SkillType();
        _loc2_.id = param1.i;
        _loc2_.name = param1.n == null ? null : param1.n.c;
        _loc2_.iconUrl = param1.u;
        _loc2_.x = param1.x;
        _loc2_.y = param1.y;
        _loc2_.requiredSkills = param1.r == null ? new ArrayCustom() : RequiredSkill.fromDtos(param1.r);
        _loc2_.effectTypeId = param1.e;
        _loc2_.levelInfos = SkillLevelInfo.fromDtos(param1.l);
        _loc2_.affectedTypes = param1.t == null ? new ArrayCustom() : new ArrayCustom(param1.t);
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

    public function getLevelInfo(param1:int):SkillLevelInfo {
        return this.levelInfos[param1] as SkillLevelInfo;
    }
}
}
