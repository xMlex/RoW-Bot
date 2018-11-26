package model.data.users.acceleration.enums {
public class BoostSource {

    public static const BlackMarketItem:int = 1;

    public static const GiftPointsProgram:int = 2;

    public static const All:int = BlackMarketItem | GiftPointsProgram;


    public function BoostSource() {
        super();
    }
}
}
