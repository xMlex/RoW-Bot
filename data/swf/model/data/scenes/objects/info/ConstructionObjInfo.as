package model.data.scenes.objects.info {
import common.ArrayCustom;
import common.IEquatable;

import model.logic.dtoSerializer.DtoDeserializer;

public class ConstructionObjInfo implements IEquatable {


    public var constructionStartTime:Date;

    public var constructionFinishTime:Date;

    public var instantFinish:Boolean;

    public var isDestruction:Boolean;

    public var constructionBonusPowerByEffectTypeId:Object;

    public var progressPercentage:Number = 0;

    public var canceling:Boolean = false;

    private var _level:int;

    public function ConstructionObjInfo() {
        this.constructionBonusPowerByEffectTypeId = {};
        super();
    }

    public static function fromDto(param1:*):ConstructionObjInfo {
        var _loc2_:ConstructionObjInfo = new ConstructionObjInfo();
        _loc2_._level = param1.l;
        _loc2_.constructionStartTime = param1.s == null ? null : new Date(param1.s);
        _loc2_.constructionFinishTime = param1.f == null ? null : new Date(param1.f);
        _loc2_.isDestruction = !!param1.d ? Boolean(param1.d) : false;
        _loc2_.constructionBonusPowerByEffectTypeId = param1.e == null ? {} : DtoDeserializer.toObject(param1.e);
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

    public function get level():int {
        return this._level;
    }

    public function set level(param1:int):void {
        this._level = param1;
    }

    public function updatePercentage(param1:Date):void {
        if (this.constructionFinishTime == null) {
            this.progressPercentage = 0;
            return;
        }
        this.progressPercentage = (param1.time - this.constructionStartTime.time) / (this.constructionFinishTime.time - this.constructionStartTime.time) * 100;
    }

    public function toDto():* {
        var _loc1_:* = {
            "l": this._level,
            "s": (this.constructionStartTime == null ? null : this.constructionStartTime.time),
            "f": (this.constructionFinishTime == null ? null : this.constructionFinishTime.time),
            "d": (this.isDestruction == false ? false : this.isDestruction)
        };
        return _loc1_;
    }

    public function clone():ConstructionObjInfo {
        var _loc1_:ConstructionObjInfo = new ConstructionObjInfo();
        _loc1_._level = this._level;
        _loc1_.constructionStartTime = this.constructionStartTime;
        _loc1_.constructionFinishTime = this.constructionFinishTime;
        _loc1_.isDestruction = this.isDestruction;
        _loc1_.constructionBonusPowerByEffectTypeId = this.constructionBonusPowerByEffectTypeId;
        return _loc1_;
    }

    public function isEqual(param1:*):Boolean {
        var _loc2_:ConstructionObjInfo = param1 as ConstructionObjInfo;
        if (_loc2_ == null) {
            return false;
        }
        return this._level == _loc2_.level && (this.constructionStartTime == null && _loc2_.constructionStartTime == null) || this.constructionStartTime != null && _loc2_.constructionStartTime != null && this.constructionStartTime.time == _loc2_.constructionStartTime.time;
    }
}
}
