package model.logic.skills.data {
import common.ArrayCustom;

import gameObjects.observableObject.ObservableObject;

import model.data.scenes.objects.info.ConstructionObjInfo;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.skills.SkillManager;

public class Skill extends ObservableObject {

    public static const CLASS_NAME:String = "Skill";

    public static const STATUS_UPDATED:String = CLASS_NAME + "StatusUpdated";


    public var dirtyNormalized:Boolean;

    public var improvementStatus:int = -1;

    public var typeId:int;

    public var constructionInfo:ConstructionObjInfo;

    private var _type:SkillType;

    public function Skill() {
        super();
    }

    public static function fromDto(param1:*):Skill {
        var _loc2_:Skill = new Skill();
        _loc2_.typeId = param1.t;
        _loc2_.constructionInfo = ConstructionObjInfo.fromDto(param1.c);
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

    public function get type():SkillType {
        if (this._type == null) {
            this._type = StaticDataManager.skillData.getSkillType(this.typeId);
        }
        return this._type;
    }

    public function getProgress():Number {
        return this.constructionInfo.progressPercentage;
    }

    public function dispatchEvents():void {
        if (!this.dirtyNormalized) {
            return;
        }
        this.dirtyNormalized = false;
        dispatchEvent(STATUS_UPDATED);
    }

    public function updateStatus():void {
        var _loc1_:int = SkillManager.getImproveStatus(UserManager.user, this.typeId);
        if (this.improvementStatus != _loc1_) {
            this.improvementStatus = _loc1_;
            this.dirtyNormalized = true;
        }
    }
}
}
