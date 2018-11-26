package model.logic.googleAnalytics {
public class GoogleAnalyticsEventTracker extends GATrackerBase {


    private var _category:String;

    private var _action:String;

    private var _label:String;

    private var _amount:Number;

    public function GoogleAnalyticsEventTracker(param1:String, param2:String, param3:String = "", param4:Number = 0) {
        super();
        this._category = param1;
        this._action = param2;
        this._label = param3;
        this._amount = param4;
    }

    override public function track():void {
        if (checkConditions) {
            this.trackEvent(this._category, this._action, this._label, this._amount);
        }
    }

    private function trackEvent(param1:String, param2:String, param3:String = null, param4:Number = 0):void {
        gaTracker = GATrackerSingleton.instance.getTracker();
        if (gaTracker != null && gaTracker.isReady()) {
            gaTracker.trackEvent(param1, param2, param3, param4);
        }
    }
}
}
