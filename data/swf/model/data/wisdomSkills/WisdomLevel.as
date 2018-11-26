package model.data.wisdomSkills {
import configs.Global;

import model.data.Resources;

public class WisdomLevel {


    public var wisdomPointsToAchieve:int;

    public var price:Resources;

    public var level:int;

    public var previousLevel:WisdomLevel;

    private var _skills:Array;

    public function WisdomLevel() {
        super();
    }

    public static function fromDto(param1:*):WisdomLevel {
        var _loc2_:WisdomLevel = new WisdomLevel();
        _loc2_.wisdomPointsToAchieve = param1.p;
        _loc2_.price = param1.r != null ? Resources.fromDto(param1.r) : new Resources();
        _loc2_.setSkills(param1);
        return _loc2_;
    }

    public function get hasAnySkills():Boolean {
        return this._skills != null && this._skills.length > 0;
    }

    public function get hasMultipleSkills():Boolean {
        return this._skills.length > 1;
    }

    public function get firstSkill():WisdomSkill {
        return this._skills[0];
    }

    public function get secondSkill():WisdomSkill {
        return this._skills[1];
    }

    public function priceWithDiscount():Resources {
        var _loc1_:Resources = null;
        if (Global.WISDOM_SKILLS_DISCOUNT == 0) {
            _loc1_ = this.price;
        }
        else {
            _loc1_ = Resources.scale(this.price, Number(100 - Global.WISDOM_SKILLS_DISCOUNT) / 100).roundAll();
        }
        return _loc1_;
    }

    private function setSkills(param1:*):void {
        var _loc2_:WisdomSkill = null;
        var _loc3_:WisdomSkill = null;
        var _loc4_:* = undefined;
        if (param1.w == null) {
            return;
        }
        this._skills = [];
        for each(_loc4_ in param1.w) {
            _loc3_ = WisdomSkill.fromDto(_loc4_);
            _loc3_.parentLevel = this;
            this._skills.push(_loc3_);
            if (_loc2_ == null) {
                _loc2_ = _loc3_;
            }
            else {
                _loc2_.dependedSkillId = _loc3_.id;
                _loc3_.dependedSkillId = _loc2_.id;
            }
        }
    }
}
}
