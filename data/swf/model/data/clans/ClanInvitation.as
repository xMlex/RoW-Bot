package model.data.clans {
import common.ArrayCustom;

public class ClanInvitation {


    public var inviterUserId:Number;

    public var time:Date;

    public function ClanInvitation() {
        super();
    }

    public static function fromDto(param1:*):ClanInvitation {
        var _loc2_:ClanInvitation = new ClanInvitation();
        _loc2_.inviterUserId = param1.u;
        _loc2_.time = new Date(param1.t);
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
}
}
