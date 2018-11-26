package model.data.locations.mines {
import common.ArrayCustom;
import common.localization.LocaleUtil;

import model.data.ResourceTypeId;

public class MineType {

    private static var probabilityOfArtifacts:ArrayCustom = new ArrayCustom([LocaleUtil.getText("model-data_locations_mines_mineType_serial"), LocaleUtil.getText("model-data_locations_mines_mineType_special"), LocaleUtil.getText("model-data_locations_mines_mineType_elite"), LocaleUtil.getText("model-data_locations_mines_mineType_experienced"), LocaleUtil.getText("model-data_locations_mines_mineType_unique")]);


    public var typeId:int;

    public var typeName:String;

    public var resourceTypeId:int;

    public var url:String;

    public var smallUrl:String;

    public function MineType() {
        super();
    }

    public static function fromDto(param1:*):MineType {
        var _loc2_:MineType = new MineType();
        _loc2_.typeId = param1.i;
        _loc2_.typeName = param1.n.c;
        _loc2_.resourceTypeId = param1.r == null ? -1 : int(param1.r);
        _loc2_.url = param1.u;
        _loc2_.smallUrl = param1.s;
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

    public static function getProbabilityOfArtifactsArray(param1:Number):ArrayCustom {
        var _loc2_:ArrayCustom = new ArrayCustom();
        if (param1 <= 200000) {
            _loc2_.addItem(probabilityOfArtifacts.getItemAt(0));
            return _loc2_;
        }
        if (param1 > 200000 && param1 <= 500000) {
            _loc2_.addItem(probabilityOfArtifacts.getItemAt(1));
            _loc2_.addItem(probabilityOfArtifacts.getItemAt(0));
            return _loc2_;
        }
        if (param1 > 500000 && param1 <= 750000) {
            _loc2_.addItem(probabilityOfArtifacts.getItemAt(2));
            _loc2_.addItem(probabilityOfArtifacts.getItemAt(1));
            _loc2_.addItem(probabilityOfArtifacts.getItemAt(0));
            return _loc2_;
        }
        if (param1 > 750000 && param1 <= 1000000) {
            _loc2_.addItem(probabilityOfArtifacts.getItemAt(3));
            _loc2_.addItem(probabilityOfArtifacts.getItemAt(2));
            _loc2_.addItem(probabilityOfArtifacts.getItemAt(1));
            _loc2_.addItem(probabilityOfArtifacts.getItemAt(0));
            return _loc2_;
        }
        if (param1 > 1000000) {
            _loc2_.addItem(probabilityOfArtifacts.getItemAt(4));
            _loc2_.addItem(probabilityOfArtifacts.getItemAt(3));
            _loc2_.addItem(probabilityOfArtifacts.getItemAt(2));
            _loc2_.addItem(probabilityOfArtifacts.getItemAt(1));
            _loc2_.addItem(probabilityOfArtifacts.getItemAt(0));
            return _loc2_;
        }
        return _loc2_;
    }

    public static function getProbabilityOfArtifactsString(param1:Number):String {
        var _loc2_:ArrayCustom = getProbabilityOfArtifactsArray(param1);
        var _loc3_:String = "";
        if (!_loc2_) {
            return _loc3_;
        }
        var _loc4_:int = 0;
        while (_loc4_ < _loc2_.length) {
            if (_loc4_ < _loc2_.length - 1) {
                _loc3_ = _loc3_ + (_loc2_[_loc4_] + ", ");
            }
            else {
                _loc3_ = _loc3_ + _loc2_[_loc4_];
            }
            _loc4_++;
        }
        return _loc3_;
    }

    public function get kind():int {
        if (this.resourceTypeId == -1) {
            return MineKindId.ARTIFACT;
        }
        switch (this.resourceTypeId) {
            case ResourceTypeId.URANIUM:
                return MineKindId.URANIUM;
            case ResourceTypeId.TITANITE:
                return MineKindId.TITANITE;
            case ResourceTypeId.MONEY:
                return MineKindId.MONEY;
            case ResourceTypeId.GOLD_MONEY:
                return MineKindId.GOLD_MONEY;
            case ResourceTypeId.BIOCHIPS:
                return MineKindId.BIOCHIPS;
            case ResourceTypeId.AVP_MONEY:
                return MineKindId.AVP_MONEY;
            default:
                throw new Error("Unknown mine type kind. ResourceTypeId = " + this.resourceTypeId + " is not found");
        }
    }
}
}
