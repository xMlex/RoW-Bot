package model.logic.googleAnalytics {
public class GoogleAnalyticsPageTracker extends GATrackerBase {


    private var _pageName:String;

    public function GoogleAnalyticsPageTracker(param1:String) {
        super();
        this._pageName = param1;
    }

    override public function track():void {
        if (checkConditions) {
            this.trackPage();
        }
    }

    private function trackPage():void {
        gaTracker = GATrackerSingleton.instance.getTracker();
        if (gaTracker != null && gaTracker.isReady()) {
            gaTracker.trackPageview("/" + this._pageName);
        }
    }
}
}
