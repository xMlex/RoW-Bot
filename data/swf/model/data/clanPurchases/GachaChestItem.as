package model.data.clanPurchases {
import model.data.UserPrize;

public class GachaChestItem {


    public var id:int;

    public var gachaChestId:int;

    public var reward:UserPrize;

    public function GachaChestItem() {
        super();
    }

    public static function fromDto(param1:*):GachaChestItem {
        var _loc2_:GachaChestItem = new GachaChestItem();
        _loc2_.id = param1.n;
        _loc2_.gachaChestId = param1.a;
        _loc2_.reward = param1.p == null ? null : UserPrize.fromDto(param1.p);
        return _loc2_;
    }
}
}
