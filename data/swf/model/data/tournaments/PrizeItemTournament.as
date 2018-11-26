package model.data.tournaments {
public class PrizeItemTournament {


    public var count:int;

    public var currentStep:int;

    public var inAllCountSteps:int;

    public var pointsGathered:Number;

    public var neededPoints:Number;

    public var isActive:Boolean;

    public var type:String;

    public var id:int;

    public var isSingleBonus:Boolean;

    public var bonusesId:int;

    public var troopsKindId:int = -1;

    public var alphaNextReward:Number;

    public var needCutItem:Boolean;

    public var isCurrentReward:Boolean;

    public var blackMarketItemTypeId:int;

    public var isAvpTournament:Boolean;

    public function PrizeItemTournament() {
        super();
    }
}
}
