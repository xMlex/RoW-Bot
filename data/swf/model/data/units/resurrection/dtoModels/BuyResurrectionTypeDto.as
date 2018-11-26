package model.data.units.resurrection.dtoModels {
import model.data.users.troops.Troops;

public class BuyResurrectionTypeDto {


    public var troops:Troops;

    public var useDiscount:Boolean;

    public var lossesType:int;

    public function BuyResurrectionTypeDto() {
        super();
    }

    public function toDto():* {
        var _loc1_:* = {
            "t": this.troops.toDto(),
            "d": this.useDiscount,
            "l": this.lossesType
        };
        return _loc1_;
    }
}
}
