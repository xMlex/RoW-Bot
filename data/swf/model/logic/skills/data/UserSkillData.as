package model.logic.skills.data {
import common.ArrayCustom;

import gameObjects.observableObject.ObservableObject;

import model.data.scenes.objects.info.ConstructionObjInfo;
import model.logic.StaticDataManager;
import model.logic.skills.SkillManager;

public class UserSkillData extends ObservableObject {

    public static const CLASS_NAME:String = "UserSkillData";

    public static const DATA_CHANGED:String = CLASS_NAME + "Changed";


    public var dirty:Boolean;

    public var skills:ArrayCustom;

    public var skillPoints:int;

    public var pointDiscardsCount:int;

    public function UserSkillData() {
        super();
    }

    public static function fromDto(param1:*):UserSkillData {
        var _loc4_:SkillType = null;
        var _loc5_:Skill = null;
        var _loc2_:UserSkillData = new UserSkillData();
        _loc2_.skills = Skill.fromDtos(param1.s);
        _loc2_.skillPoints = param1.p;
        _loc2_.pointDiscardsCount = param1.d;
        var _loc3_:ArrayCustom = new ArrayCustom();
        for each(_loc4_ in StaticDataManager.skillData.skillTypes) {
            _loc5_ = SkillManager.getSkill(_loc2_, _loc4_.id);
            if (_loc5_ == null) {
                _loc5_ = new Skill();
                _loc5_.typeId = _loc4_.id;
                _loc5_.constructionInfo = new ConstructionObjInfo();
                _loc3_.addItem(_loc5_);
            }
        }
        _loc2_.skills.addAll(_loc3_);
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

    public function getSkill(param1:int):Skill {
        var _loc2_:Skill = null;
        for each(_loc2_ in this.skills) {
            if (_loc2_.typeId == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function getActiveSkill():Skill {
        var _loc1_:Skill = null;
        for each(_loc1_ in this.skills) {
            if (_loc1_.constructionInfo.constructionFinishTime) {
                return _loc1_;
            }
        }
        return null;
    }

    public function dispatchEvents():void {
        var _loc1_:Skill = null;
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(DATA_CHANGED);
        }
        for each(_loc1_ in this.skills) {
            _loc1_.dispatchEvents();
        }
    }

    public function updateStatus():void {
        var _loc1_:Skill = null;
        for each(_loc1_ in this.skills) {
            _loc1_.updateStatus();
        }
    }
}
}
