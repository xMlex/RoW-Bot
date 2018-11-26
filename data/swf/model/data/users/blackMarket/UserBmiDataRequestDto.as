package model.data.users.blackMarket {
public class UserBmiDataRequestDto {


    public var count:int;

    public var value:UserBmiData;

    public function UserBmiDataRequestDto() {
        super();
    }

    public static function fromDto(param1:*):UserBmiDataRequestDto {
        var _loc2_:UserBmiDataRequestDto = new UserBmiDataRequestDto();
        _loc2_.count = param1.c;
        _loc2_.value = UserBmiData.fromDto(param1.b);
        return _loc2_;
    }

    public function toDto():Object {
        return {
            "c": this.count,
            "b": this.value.toDto()
        };
    }
}
}
