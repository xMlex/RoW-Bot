package model.logic.blackMarketModel.applyBehaviours.contexts {
public class DistributeUpgradePointsApplyContext extends ApplyContext {


    public var tierId:int;

    public var attackBonus:int;

    public var defenceBonus:int;

    public var speedBonus:int;

    public var capacityBonus:int;

    public var useBlackMarketItem:Boolean;

    public function DistributeUpgradePointsApplyContext() {
        super();
    }

    public function toDto():Object {
        var _loc1_:Object = {
            "t": this.tierId,
            "b": this.useBlackMarketItem,
            "a": this.attackBonus,
            "d": this.defenceBonus,
            "s": this.speedBonus,
            "p": this.capacityBonus
        };
        return _loc1_;
    }
}
}
