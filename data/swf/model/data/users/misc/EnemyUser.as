package model.data.users.misc {
import common.ArrayCustom;

public class EnemyUser {


    public var userId:Number;

    public var dateAddToEnemy:Date;

    public function EnemyUser() {
        super();
    }

    public static function fromDto(param1:*):EnemyUser {
        var _loc2_:EnemyUser = new EnemyUser();
        _loc2_.userId = param1.u;
        _loc2_.dateAddToEnemy = new Date(param1.t);
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
