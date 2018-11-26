package model.interfaces {
import flash.display.DisplayObject;

import model.data.TileGrid;

public interface ISceneCanvas {


    function clearScene():void;

    function addChild(param1:DisplayObject):DisplayObject;

    function addChildAt(param1:DisplayObject, param2:int):DisplayObject;

    function set scaleX(param1:Number):void;

    function set scaleY(param1:Number):void;

    function get tileGrid():TileGrid;
}
}
