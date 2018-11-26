package model.data.ratings.epicBattles {
import common.ArrayCustom;

import flash.events.Event;
import flash.events.EventDispatcher;

public class UserEpicBattlesData {

    public static const CLASS_NAME:String = "UserEpicBattlesData";

    public static const EPIC_BATTLE_DATA_CHANGED:String = CLASS_NAME + "Changed";


    public var battlesLiked:Array;

    public var hasUnreadBattles:Boolean;

    public var dirty:Boolean;

    private var events:EventDispatcher;

    public function UserEpicBattlesData() {
        this.events = new EventDispatcher();
        super();
    }

    public static function fromDto(param1:*):UserEpicBattlesData {
        var _loc2_:UserEpicBattlesData = new UserEpicBattlesData();
        if (param1) {
            _loc2_.battlesLiked = !!param1.l ? new ArrayCustom(param1.l) : [];
            _loc2_.hasUnreadBattles = param1.f;
        }
        else {
            _loc2_.battlesLiked = [];
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            this.events.dispatchEvent(new Event(EPIC_BATTLE_DATA_CHANGED, true));
        }
    }

    public function addEventListener(param1:String, param2:Function):void {
        this.events.addEventListener(param1, param2);
    }

    public function removeEventListener(param1:String, param2:Function):void {
        this.events.removeEventListener(param1, param2);
    }
}
}
