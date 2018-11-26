package model.logic.character {
import flash.events.Event;
import flash.events.EventDispatcher;

import model.logic.dtoSerializer.DtoDeserializer;

public class UserCharacterData {

    private static const CLASS_NAME:String = "UserCharacterData";

    public static const DATA_CHANGED:String = CLASS_NAME + "Changed";


    public var characterName:String;

    public var typeId:int;

    public var allowedExtraCharacters:Array;

    public var dirty:Boolean;

    private var _events:EventDispatcher;

    public function UserCharacterData() {
        this._events = new EventDispatcher();
        super();
    }

    public static function fromDto(param1:*):UserCharacterData {
        var _loc2_:UserCharacterData = null;
        if (param1) {
            _loc2_ = new UserCharacterData();
            _loc2_.characterName = param1.n;
            _loc2_.typeId = param1.r;
            _loc2_.allowedExtraCharacters = DtoDeserializer.toArray(param1.h);
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            this._events.dispatchEvent(new Event(DATA_CHANGED, true));
        }
    }

    public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        this._events.addEventListener(param1, param2, param3, param4, param5);
    }

    public function removeEventListener(param1:String, param2:Function):void {
        this._events.removeEventListener(param1, param2);
    }
}
}
