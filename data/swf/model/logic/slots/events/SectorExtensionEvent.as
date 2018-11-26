package model.logic.slots.events {
import flash.events.Event;
import flash.geom.Point;

import model.logic.slots.SectorSlotExtensionPack;

public class SectorExtensionEvent extends Event {

    private static const CLASS_NAME:String = "SectorExtensionEvent";

    public static const MENU_SHOW:String = CLASS_NAME + "MenuShow";

    public static const MENU_HIDE:String = CLASS_NAME + "MenuHide";

    public static const UPDATE_SECTOR:String = CLASS_NAME + "UpdateSector";


    private var _pack:SectorSlotExtensionPack;

    private var _slotId:int;

    private var _position:Point;

    public function SectorExtensionEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:int = -1, param5:Point = null, param6:SectorSlotExtensionPack = null) {
        super(param1, param2, param3);
        this._slotId = param4;
        this._position = param5;
        this._pack = param6;
    }

    override public function clone():Event {
        return new SectorExtensionEvent(type, bubbles, cancelable, this._slotId, this._position, this._pack);
    }

    public function get pack():SectorSlotExtensionPack {
        return this._pack;
    }

    public function get slotId():int {
        return this._slotId;
    }

    public function get position():Point {
        return this._position;
    }
}
}
