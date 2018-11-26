package model.data.users.raids {
import common.ArrayCustom;

import flash.utils.Dictionary;

import gameObjects.observableObject.ObservableObject;

import model.data.map.MapRect;
import model.logic.RaidLocationKindId;
import model.logic.RaidLocationType;
import model.logic.StaticDataManager;

public class UserRaidData extends ObservableObject {

    public static const CLASS_NAME:String = "UserRaidData";

    public static const DATA_CHANGED:String = CLASS_NAME + "Changed";


    public var dirty:Boolean;

    public var nextLocationId:Number;

    public var locations:ArrayCustom;

    public var stats:UserRaidStats;

    public var maxWonLevel:int;

    public var storyData:UserRaidStoryData;

    public var todayBonusRefreshesCount:int;

    public function UserRaidData() {
        this.locations = new ArrayCustom();
        super();
    }

    public static function fromDto(param1:*):UserRaidData {
        var _loc2_:UserRaidData = new UserRaidData();
        _loc2_.nextLocationId = param1.i;
        _loc2_.locations = RaidLocation.fromDtos(param1.l);
        _loc2_.maxWonLevel = param1.m;
        _loc2_.todayBonusRefreshesCount = param1.b;
        _loc2_.storyData = !!param1.s ? UserRaidStoryData.fromDto(param1.s) : null;
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

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(DATA_CHANGED);
        }
    }

    public function getRaidLocationById(param1:int):RaidLocation {
        var _loc2_:RaidLocation = null;
        for each(_loc2_ in this.locations) {
            if (_loc2_.id == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function getRaidLocationByRect(param1:MapRect):ArrayCustom {
        var _loc3_:RaidLocation = null;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in this.locations) {
            if (!_loc3_.closed) {
                if (_loc3_.mapPos.x >= param1.x1 && _loc3_.mapPos.x <= param1.x2 && _loc3_.mapPos.y >= param1.y1 && _loc3_.mapPos.y <= param1.y2) {
                    _loc2_.addItem(_loc3_);
                }
            }
        }
        return _loc2_;
    }

    public function getRaidLocationsByStoryInfo(param1:RaidLocationStoryInfo):ArrayCustom {
        var _loc3_:RaidLocation = null;
        var _loc2_:ArrayCustom = new ArrayCustom();
        if (!param1) {
            return _loc2_;
        }
        for each(_loc3_ in this.locations) {
            if (!(_loc3_.closed || _loc3_.storyInfo == null)) {
                if (_loc3_.storyInfo.storyId == param1.storyId && _loc3_.storyInfo.stepId == param1.stepId) {
                    _loc2_.addItem(_loc3_);
                    if (_loc2_.length == 2) {
                        break;
                    }
                }
            }
        }
        return _loc2_;
    }

    public function getOpenRaidLocationStoryInfos():ArrayCustom {
        var _loc3_:String = null;
        var _loc4_:RaidLocation = null;
        var _loc1_:ArrayCustom = new ArrayCustom();
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc4_ in this.locations) {
            if (!(_loc4_.closed || _loc4_.storyInfo == null)) {
                _loc3_ = _loc4_.storyInfo.storyId.toString() + "_" + _loc4_.storyInfo.stepId.toString();
                if (_loc2_.getItemIndex(_loc3_) < 0) {
                    _loc1_.addItem(_loc4_.storyInfo);
                    _loc2_.addItem(_loc3_);
                }
            }
        }
        return _loc1_;
    }

    public function getAllDefenceStoryLocationsByStoryId(param1:int):Dictionary {
        var _loc3_:RaidLocation = null;
        var _loc4_:RaidLocationType = null;
        var _loc2_:Dictionary = new Dictionary();
        for each(_loc3_ in this.locations) {
            _loc4_ = StaticDataManager.getRaidLocationTypeById(_loc3_.typeId);
            if (!(_loc3_.closed || _loc3_.storyInfo == null || _loc3_.storyInfo.storyId != param1 || _loc4_.kindId != RaidLocationKindId.Defensive)) {
                if (!_loc2_[_loc3_.storyInfo.stepId]) {
                    _loc2_[_loc3_.storyInfo.stepId] = _loc3_;
                }
            }
        }
        return _loc2_;
    }

    public function getAllOffenceStoryLocationsByStoryId(param1:int):Dictionary {
        var _loc3_:RaidLocation = null;
        var _loc4_:RaidLocationType = null;
        var _loc2_:Dictionary = new Dictionary();
        for each(_loc3_ in this.locations) {
            _loc4_ = StaticDataManager.getRaidLocationTypeById(_loc3_.typeId);
            if (!(_loc3_.closed || _loc3_.storyInfo == null || _loc3_.storyInfo.storyId != param1 || _loc4_.kindId != RaidLocationKindId.Attacking)) {
                if (!_loc2_[_loc3_.storyInfo.stepId]) {
                    _loc2_[_loc3_.storyInfo.stepId] = _loc3_;
                }
            }
        }
        return _loc2_;
    }

    public function getStoryLocationsByStoryId(param1:int, param2:int):ArrayCustom {
        var _loc4_:RaidLocation = null;
        var _loc3_:ArrayCustom = new ArrayCustom();
        for each(_loc4_ in this.locations) {
            if (_loc4_.storyInfo) {
                trace("storyId: " + _loc4_.storyInfo.storyId + " stepId" + _loc4_.storyInfo.stepId);
            }
            if (!(_loc4_.closed || _loc4_.storyInfo == null || _loc4_.storyInfo.storyId != param1 || _loc4_.storyInfo.stepId != param2)) {
                _loc3_.addItem(_loc4_);
                if (_loc3_.length == 2) {
                    break;
                }
            }
        }
        return _loc3_;
    }

    public function getMaxLevelOpenStoryRaidLocation():int {
        var _loc2_:RaidLocation = null;
        var _loc1_:int = 0;
        for each(_loc2_ in this.locations) {
            if (!(_loc2_.closed || _loc2_.storyInfo == null)) {
                if (_loc2_.level > _loc1_) {
                    _loc1_ = _loc2_.level;
                }
            }
        }
        return _loc1_;
    }
}
}
