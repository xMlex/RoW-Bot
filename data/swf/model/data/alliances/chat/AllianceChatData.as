package model.data.alliances.chat {
import gameObjects.observableObject.ObservableObject;

public class AllianceChatData extends ObservableObject {

    public static const CLASS_NAME:String = "AllianceChatData";

    public static const ALLIANCE_PERMISSION_DATA_CHANGED:String = CLASS_NAME + "DataChanged";


    public var dirty:Boolean = false;

    public var rooms:Array;

    public function AllianceChatData() {
        this.rooms = new Array();
        super();
    }

    public static function fromDto(param1:*):AllianceChatData {
        var _loc3_:* = undefined;
        var _loc2_:AllianceChatData = new AllianceChatData();
        if (param1.r) {
            _loc2_.rooms = new Array();
            for (_loc3_ in param1.r) {
                _loc2_.rooms[_loc3_] = param1.r[_loc3_] == null ? new AllianceChatRoomData() : AllianceChatRoomData.fromDto(param1.r[_loc3_]);
            }
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(ALLIANCE_PERMISSION_DATA_CHANGED);
        }
    }
}
}
