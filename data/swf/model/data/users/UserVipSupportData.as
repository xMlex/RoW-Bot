package model.data.users {
import flash.events.Event;

import gameObjects.observableObject.ObservableObject;

public class UserVipSupportData extends ObservableObject {

    private static const CLASS_NAME:String = "UserVipSupportData";

    public static const DATA_CHANGED:String = CLASS_NAME + "Changed";


    public var joinedProgram:Boolean;

    public var lastVipChatMessageId:Number;

    public var dirty:Boolean;

    public var dirtyLastMessage:Boolean;

    public var hasVipSectorNamePanel:Boolean;

    public var lastVotedTime:Date;

    public function UserVipSupportData() {
        super();
    }

    public static function fromDto(param1:*):UserVipSupportData {
        var _loc2_:UserVipSupportData = new UserVipSupportData();
        _loc2_.joinedProgram = param1.j;
        if (param1.v) {
            _loc2_.lastVipChatMessageId = param1.v;
        }
        else {
            _loc2_.lastVipChatMessageId = -1;
        }
        _loc2_.hasVipSectorNamePanel = param1.s;
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            events.dispatchEvent(new Event(DATA_CHANGED, true));
        }
    }
}
}
