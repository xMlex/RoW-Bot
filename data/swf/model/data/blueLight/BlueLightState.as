package model.data.blueLight {
import integration.SocialNetworkIdentifier;

public class BlueLightState {


    public var eventId:int;

    public var stepId:int;

    public var points:Number;

    public var pointsRequired:Number;

    private var endTime:Date;

    public var stepsPoints:Array;

    public var bonusId:int;

    public var obtainedBonusIds:Array;

    public var state:int;

    public var previousPoints:Number;

    public function BlueLightState() {
        super();
    }

    public static function fromDto(param1:*):BlueLightState {
        var _loc2_:BlueLightState = new BlueLightState();
        _loc2_.eventId = param1.i;
        _loc2_.stepId = param1.si;
        _loc2_.points = param1.pc;
        _loc2_.pointsRequired = param1.pr;
        _loc2_.endTime = new Date(param1.et);
        _loc2_.stepsPoints = param1.sp;
        _loc2_.bonusId = param1.bi;
        _loc2_.obtainedBonusIds = param1.ob == null ? new Array() : param1.ob;
        _loc2_.state = param1.bs;
        _loc2_.previousPoints = param1.pc;
        return _loc2_;
    }

    private function get TIME_SHIFT():Number {
        if (SocialNetworkIdentifier.isPP) {
            return 30 * 60 * 1000;
        }
        return 0;
    }

    public function get endTimeShifted():Date {
        if (!this.endTime.time) {
            return null;
        }
        return new Date(this.endTime.time - this.TIME_SHIFT);
    }
}
}
