package model.data.scenes.types.info.troops {
import model.data.scenes.types.info.TroopsKindId;

public class SupportItem {


    public var troopsTypeId:int;

    public var bonusAttack:Number = 0;

    public var bonusDefence:Number = 0;

    public var bonusIntelligence:Number = 0;

    public function SupportItem() {
        super();
    }

    public static function fromDto(param1:*, param2:int):SupportItem {
        var _loc3_:SupportItem = new SupportItem();
        _loc3_.troopsTypeId = param1.t;
        if (param2 == TroopsKindId.ATTACKING) {
            _loc3_.bonusAttack = param1.b;
        }
        else if (param2 == TroopsKindId.DEFENSIVE) {
            _loc3_.bonusDefence = param1.b;
        }
        else if (param2 == TroopsKindId.RECON) {
            _loc3_.bonusIntelligence = param1.b;
        }
        return _loc3_;
    }

    public static function fromDtos(param1:*, param2:int):Vector.<SupportItem> {
        var _loc3_:Vector.<SupportItem> = new Vector.<SupportItem>(param1.length, true);
        var _loc4_:int = 0;
        while (_loc4_ < param1.length) {
            _loc3_[_loc4_] = fromDto(param1[_loc4_], param2);
            _loc4_++;
        }
        return _loc3_;
    }

    public function get bonus():Number {
        return this.bonusAttack + this.bonusDefence + this.bonusIntelligence;
    }
}
}
