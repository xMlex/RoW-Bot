package model.data.temporarySkins {
import common.IEquatable;

import flash.utils.Dictionary;

public class TemporarySectorSkinData implements IEquatable {


    public var skinBoxes:Dictionary;

    public var prevActiveOrdinarySkinId:int;

    public var lastActivationTime:Date;

    public var currentActiveSkin:TemporarySkin;

    public function TemporarySectorSkinData() {
        super();
    }

    public static function fromDto(param1:*):TemporarySectorSkinData {
        var _loc2_:TemporarySectorSkinData = new TemporarySectorSkinData();
        _loc2_.prevActiveOrdinarySkinId = param1.o;
        _loc2_.lastActivationTime = !!param1.a ? new Date(param1.a) : null;
        _loc2_.currentActiveSkin = TemporarySkin.fromDto(param1.c);
        _loc2_.skinBoxes = TemporarySkinBox.fromDtos(param1.s);
        return _loc2_;
    }

    public function getCurrentSkinExpirationDate():Date {
        var _loc1_:Number = NaN;
        var _loc2_:Date = null;
        if (this.currentActiveSkin != null) {
            _loc1_ = this.currentActiveSkin.skinEffectInfo.timeSeconds;
            _loc2_ = new Date(this.lastActivationTime.time + _loc1_ * 1000);
            return _loc2_;
        }
        return null;
    }

    public function addSkinToUser(param1:TemporarySkin):void {
        if (this.skinBoxes == null) {
            this.skinBoxes = new Dictionary();
        }
        var _loc2_:TemporarySkinBox = this.skinBoxes[param1.skinTemplateId] as TemporarySkinBox;
        if (_loc2_ == null) {
            _loc2_ = new TemporarySkinBox();
            _loc2_.skin = param1;
            _loc2_.count = 1;
            this.skinBoxes[param1.skinTemplateId] = _loc2_;
        }
        else {
            _loc2_.count++;
        }
    }

    public function deleteSkinFromUser(param1:int):void {
        var _loc2_:TemporarySkinBox = this.skinBoxes[param1] as TemporarySkinBox;
        if (_loc2_ != null) {
            if (_loc2_.count > 1) {
                _loc2_.count--;
            }
            else {
                delete this.skinBoxes[param1];
            }
        }
    }

    public function isEqual(param1:*):Boolean {
        var _loc2_:TemporarySectorSkinData = param1 as TemporarySectorSkinData;
        if (_loc2_ == null) {
            return false;
        }
        return this.skinBoxes == _loc2_.skinBoxes && this.prevActiveOrdinarySkinId == _loc2_.prevActiveOrdinarySkinId && this.lastActivationTime == _loc2_.lastActivationTime && this.currentActiveSkin == _loc2_.currentActiveSkin;
    }
}
}
