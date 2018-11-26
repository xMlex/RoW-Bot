package model.logic.googleAnalytics {
import com.google.analytics.GATracker;
import com.google.analytics.core.TrackerMode;

import flash.display.DisplayObject;

import model.logic.googleAnalytics.config.GAConfigAccount;
import model.logic.googleAnalytics.types.GAPageType;

public class GATrackerSingleton {

    private static var _instance:GATrackerSingleton;

    {
        if (_instance == null) {
            _instance = new GATrackerSingleton();
        }
    }

    private var _tracker:GATracker;

    public function GATrackerSingleton() {
        super();
        if (_instance != null) {
            throw new Error("Singleton can only be accessed through GATacker.instance");
        }
    }

    public static function get instance():GATrackerSingleton {
        return _instance;
    }

    public function initialize(param1:DisplayObject, param2:String, param3:Boolean):void {
        var gaDisplayObject:DisplayObject = param1;
        var gaAccount:String = param2;
        var googleAnalyticsEnabled:Boolean = param3;
        if (googleAnalyticsEnabled && gaAccount != GAConfigAccount.none) {
            try {
                this._tracker = new GATracker(gaDisplayObject, gaAccount, TrackerMode.AS3, false);
                this._tracker.trackPageview("/" + GAPageType.FORM_SECTOR_SHOWN);
                return;
            }
            catch (error:Error) {
                throw new Error("Google alalytics account code initialization error. " + error.message);
            }
        }
    }

    function getTracker():GATracker {
        return this._tracker;
    }
}
}
