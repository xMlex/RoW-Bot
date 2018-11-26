package model.logic.blackMarketItems {
import model.logic.ServerTimeManager;

public class BlackMarketItemExpirationData {


    public var concreteItemId:int;

    public var timeAdded:Date;

    public var expireDate:Date;

    public function BlackMarketItemExpirationData(param1:int, param2:Date) {
        super();
        this.concreteItemId = param1;
        this.timeAdded = param2;
    }

    public function isExpired():Boolean {
        return this.expireDate != null && this.expireDate.time < ServerTimeManager.serverTimeNow.time;
    }
}
}
