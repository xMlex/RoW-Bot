package model.data.users.blackMarket {
public class UserBmiData {


    public var typeId:uint;

    public var expireDate:Date;

    public function UserBmiData() {
        super();
    }

    public static function fromDto(param1:*):UserBmiData {
        var _loc2_:UserBmiData = new UserBmiData();
        _loc2_.typeId = param1.i;
        _loc2_.expireDate = new Date(param1.t);
        return _loc2_;
    }

    public function toDto():Object {
        return {
            "i": this.typeId,
            "t": this.expireDate.time
        };
    }
}
}
