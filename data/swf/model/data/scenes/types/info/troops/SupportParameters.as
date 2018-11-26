package model.data.scenes.types.info.troops {
import common.ArrayCustom;

import flash.utils.Dictionary;

import model.data.scenes.types.info.TroopsGroupId;
import model.data.scenes.types.info.TroopsKindId;
import model.data.scenes.types.info.TroopsTypeId;

public class SupportParameters {


    public var capacity:Number;

    public var attack:Vector.<SupportItem>;

    public var intelligence:Vector.<SupportItem>;

    public var defense:Vector.<SupportItem>;

    public var supportGroups:ArrayCustom;

    public var supportUnitsCount:int;

    public var maxAttack:Number;

    public var maxIntelligence:Number;

    public var maxDefense:Number;

    public function SupportParameters() {
        super();
    }

    public static function fromDto(param1:*):SupportParameters {
        var _loc2_:SupportParameters = new SupportParameters();
        _loc2_.capacity = param1.c;
        _loc2_.attack = param1.a == null ? null : SupportItem.fromDtos(param1.a, TroopsKindId.ATTACKING);
        _loc2_.maxAttack = getMax(_loc2_.attack) * _loc2_.capacity;
        _loc2_.intelligence = param1.i == null ? null : SupportItem.fromDtos(param1.i, TroopsKindId.RECON);
        _loc2_.maxIntelligence = getMax(_loc2_.intelligence) * _loc2_.capacity;
        _loc2_.defense = param1.d == null ? null : SupportItem.fromDtos(param1.d, TroopsKindId.DEFENSIVE);
        _loc2_.maxDefense = getMax(_loc2_.defense) * _loc2_.capacity;
        _loc2_.supportGroups = getSupportGroups(_loc2_.attack, _loc2_.defense, _loc2_.intelligence);
        _loc2_.supportUnitsCount = getSupportUnitsCount(_loc2_.attack, _loc2_.defense, _loc2_.intelligence);
        return _loc2_;
    }

    private static function getSupportUnitsCount(param1:Vector.<SupportItem>, param2:Vector.<SupportItem>, param3:Vector.<SupportItem>):int {
        var _loc4_:int = 0;
        if (param1) {
            _loc4_ = _loc4_ + param1.length;
        }
        if (param2) {
            _loc4_ = _loc4_ + param2.length;
        }
        if (param3) {
            _loc4_ = _loc4_ + param3.length;
        }
        return _loc4_;
    }

    private static function getSupportGroups(param1:Vector.<SupportItem>, param2:Vector.<SupportItem>, param3:Vector.<SupportItem>):ArrayCustom {
        var _loc5_:int = 0;
        var _loc6_:SupportItem = null;
        var _loc7_:SupportItem = null;
        var _loc8_:SupportItem = null;
        var _loc4_:ArrayCustom = new ArrayCustom();
        if (param3) {
            _loc4_.addItem(TroopsGroupId.GetGroupByTypeId(param3[0].troopsTypeId));
            for each(_loc6_ in param3) {
                _loc5_ = TroopsGroupId.GetGroupByTypeId(_loc6_.troopsTypeId);
                if (!_loc4_.contains(_loc5_)) {
                    _loc4_.addItem(_loc5_);
                }
            }
        }
        if (param1) {
            _loc4_.addItem(TroopsGroupId.GetGroupByTypeId(param1[0].troopsTypeId));
            for each(_loc7_ in param1) {
                _loc5_ = TroopsGroupId.GetGroupByTypeId(_loc7_.troopsTypeId);
                if (!_loc4_.contains(_loc5_)) {
                    _loc4_.addItem(_loc5_);
                }
            }
        }
        if (param2) {
            _loc4_.addItem(TroopsGroupId.GetGroupByTypeId(param2[0].troopsTypeId));
            for each(_loc8_ in param2) {
                _loc5_ = TroopsGroupId.GetGroupByTypeId(_loc8_.troopsTypeId);
                if (!_loc4_.contains(_loc5_)) {
                    _loc4_.addItem(_loc5_);
                }
            }
        }
        return _loc4_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    private static function getMax(param1:Vector.<SupportItem>):Number {
        var _loc3_:SupportItem = null;
        var _loc2_:Number = 0;
        for each(_loc3_ in param1) {
            if (_loc3_.bonus > _loc2_) {
                _loc2_ = _loc3_.bonus;
            }
        }
        return _loc2_;
    }

    public function unitsId(param1:Boolean = false):Vector.<SupportItem> {
        var _loc4_:SupportItem = null;
        var _loc5_:* = null;
        var _loc2_:Vector.<SupportItem> = new Vector.<SupportItem>();
        var _loc3_:Dictionary = new Dictionary();
        for each(_loc4_ in this.intelligence) {
            if (_loc3_[_loc4_.troopsTypeId] == null) {
                _loc3_[_loc4_.troopsTypeId] = _loc4_;
            }
            else {
                _loc3_[_loc4_.troopsTypeId].bonusIntelligence = _loc4_.bonusIntelligence;
            }
        }
        for each(_loc4_ in this.attack) {
            if (!(param1 && TroopsTypeId.isExclusiveUnitByType(_loc4_.troopsTypeId))) {
                if (_loc3_[_loc4_.troopsTypeId] == null) {
                    _loc3_[_loc4_.troopsTypeId] = _loc4_;
                }
                else {
                    _loc3_[_loc4_.troopsTypeId].bonusAttack = _loc4_.bonusAttack;
                }
            }
        }
        for each(_loc4_ in this.defense) {
            if (!(param1 && TroopsTypeId.isExclusiveUnitByType(_loc4_.troopsTypeId))) {
                if (_loc3_[_loc4_.troopsTypeId] == null) {
                    _loc3_[_loc4_.troopsTypeId] = _loc4_;
                }
                else {
                    _loc3_[_loc4_.troopsTypeId].bonusDefence = _loc4_.bonusDefence;
                }
            }
        }
        for (_loc5_ in _loc3_) {
            _loc2_.push(_loc3_[_loc5_]);
        }
        return _loc2_;
    }

    public function supports(param1:int):Boolean {
        var _loc2_:SupportItem = null;
        for each(_loc2_ in this.attack) {
            if (_loc2_.troopsTypeId == param1) {
                return true;
            }
        }
        for each(_loc2_ in this.defense) {
            if (_loc2_.troopsTypeId == param1) {
                return true;
            }
        }
        for each(_loc2_ in this.intelligence) {
            if (_loc2_.troopsTypeId == param1) {
                return true;
            }
        }
        return false;
    }
}
}
