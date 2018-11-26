package model.logic.character {
import common.GameType;

import configs.Global;

import flash.events.Event;
import flash.events.EventDispatcher;

import model.logic.UserDemoManager;

public class UserNoteCharacterData {

    private static const CLASS_NAME:String = "UserNoteCharacterData";

    public static const DATA_CHANGED:String = CLASS_NAME + "Changed";


    public var typeId:int;

    public var characterRace:int;

    public var dirty:Boolean;

    private var events:EventDispatcher;

    public function UserNoteCharacterData(param1:int = 1) {
        this.events = new EventDispatcher();
        super();
        this.typeId = param1;
        this.characterRace = getCharacterRace(param1);
    }

    public static function fromDto(param1:*):UserNoteCharacterData {
        var _loc2_:UserNoteCharacterData = null;
        if (param1.i == UserDemoManager.DemoUserId && GameType.isNords) {
            _loc2_ = new UserNoteCharacterData();
        }
        else if (param1.rt && Global.INVENTORY_SETTING_ENABLED) {
            _loc2_ = new UserNoteCharacterData(param1.rt);
        }
        return _loc2_;
    }

    private static function getCharacterRace(param1:int):int {
        var _loc2_:CharacterInfo = StaticCharacterData.getCharacterInfo(param1);
        return _loc2_.characterRace;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            this.events.dispatchEvent(new Event(DATA_CHANGED, true));
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
