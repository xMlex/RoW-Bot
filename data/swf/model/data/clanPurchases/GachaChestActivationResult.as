package model.data.clanPurchases {
import model.data.UserPrize;
import model.logic.dtoSerializer.DtoDeserializer;

public class GachaChestActivationResult {


    public var openedChests:Array;

    public function GachaChestActivationResult() {
        super();
    }

    public static function fromDto(param1:*):GachaChestActivationResult {
        var _loc2_:GachaChestActivationResult = new GachaChestActivationResult();
        _loc2_.openedChests = DtoDeserializer.toArray(param1.r, GachaChestItem.fromDto);
        return _loc2_;
    }

    public function getTotalReward():UserPrize {
        var _loc2_:int = 0;
        var _loc1_:UserPrize = new UserPrize();
        if (this.openedChests != null) {
            _loc2_ = 0;
            while (_loc2_ < this.openedChests.length) {
                _loc1_.sourceMerge(this.openedChests[_loc2_].reward);
                _loc2_++;
            }
        }
        return _loc1_;
    }
}
}
