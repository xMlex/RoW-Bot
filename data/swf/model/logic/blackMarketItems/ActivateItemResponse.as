package model.logic.blackMarketItems {
import model.data.UserPrize;
import model.data.clanPurchases.GachaChestActivationResult;

public class ActivateItemResponse {


    public var chestActivationResult:ChestActivationResult;

    public var boostActivationResult:MininBoostActivationResult;

    public var staticBonusPackActivationResult:UserPrize;

    public var gachaChestActivationResult:GachaChestActivationResult;

    public function ActivateItemResponse() {
        super();
    }

    public static function fromDto(param1:*):ActivateItemResponse {
        var _loc2_:ActivateItemResponse = new ActivateItemResponse();
        _loc2_.chestActivationResult = param1.c == null ? null : ChestActivationResult.fromDto(param1.c);
        _loc2_.boostActivationResult = param1.b == null ? null : MininBoostActivationResult.fromDto(param1.b);
        _loc2_.staticBonusPackActivationResult = param1.f == null ? null : UserPrize.fromDto(param1.f);
        _loc2_.gachaChestActivationResult = param1.g == null ? null : GachaChestActivationResult.fromDto(param1.g);
        return _loc2_;
    }
}
}
