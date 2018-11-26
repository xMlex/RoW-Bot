package model.logic.quests.completions {
public class QuestCompletionByBattle {


    public var attack:Boolean;

    public var orderId:int;

    public var successfulOnly:Boolean;

    public var targetResources:Number;

    public var gotResources:Number;

    public var minDemandedUserLevel:int;

    public var maxDemandedUserLevel:int;

    public var robberyCount:int;

    public var maxRobberyCount:int;

    public var isSuccess:Boolean;

    public var freeOccupation:Boolean;

    public var leftPowerPoints:Number;

    public var targetPowerPoints:Number;

    public function QuestCompletionByBattle() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionByBattle {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionByBattle = new QuestCompletionByBattle();
        _loc2_.attack = param1.a;
        _loc2_.orderId = param1.o;
        _loc2_.successfulOnly = param1.s;
        _loc2_.targetResources = param1.r;
        _loc2_.minDemandedUserLevel = param1.n;
        _loc2_.maxDemandedUserLevel = param1.x;
        _loc2_.robberyCount = param1.c;
        _loc2_.maxRobberyCount = param1.i;
        _loc2_.isSuccess = param1.u;
        _loc2_.gotResources = param1.p;
        _loc2_.freeOccupation = param1.f;
        _loc2_.leftPowerPoints = param1.l;
        _loc2_.targetPowerPoints = param1.t;
        return _loc2_;
    }

    public function equal(param1:QuestCompletionByBattle):Boolean {
        if (!param1) {
            return false;
        }
        if (param1.attack != this.attack) {
            return false;
        }
        if (param1.orderId != this.orderId) {
            return false;
        }
        if (param1.successfulOnly != this.successfulOnly) {
            return false;
        }
        if (param1.targetResources != this.targetResources) {
            return false;
        }
        if (param1.gotResources != this.gotResources) {
            return false;
        }
        if (param1.minDemandedUserLevel != this.minDemandedUserLevel) {
            return false;
        }
        if (param1.maxDemandedUserLevel != this.maxDemandedUserLevel) {
            return false;
        }
        if (param1.robberyCount != this.robberyCount) {
            return false;
        }
        if (param1.maxRobberyCount != this.maxRobberyCount) {
            return false;
        }
        if (param1.isSuccess != this.isSuccess) {
            return false;
        }
        if (param1.freeOccupation != this.freeOccupation) {
            return false;
        }
        if (param1.leftPowerPoints != this.leftPowerPoints) {
            return false;
        }
        if (param1.targetPowerPoints != this.targetPowerPoints) {
            return false;
        }
        return true;
    }
}
}
