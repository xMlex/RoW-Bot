package model.data.giftData {
import model.data.UserPrize;

public class PostGiftInfo {


    public var prizePostGift:UserPrize;

    public function PostGiftInfo() {
        super();
    }

    public static function fromDto(param1:Object):PostGiftInfo {
        var _loc2_:PostGiftInfo = new PostGiftInfo();
        _loc2_.prizePostGift = param1.up != null ? UserPrize.fromDto(param1.up) : null;
        return _loc2_.prizePostGift != null ? _loc2_ : null;
    }
}
}
