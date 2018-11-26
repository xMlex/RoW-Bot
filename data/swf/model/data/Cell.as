package model.data {
import flash.geom.Point;

import model.ui.UnitUI;

public class Cell {


    private var _position:Point;

    private var _tileX:int;

    private var _tileY:int;

    private var _unitUI:UnitUI;

    public function Cell(param1:int, param2:int) {
        super();
        this._tileX = param1;
        this._tileY = param2;
        this._position = new Point(param1, param2);
    }

    public function clear():void {
        this._unitUI = null;
    }

    public function get unitUI():UnitUI {
        return this._unitUI;
    }

    public function get position():Point {
        return this._position;
    }

    public function get isEmpty():Boolean {
        return this._unitUI == null;
    }

    public function set unitUI(param1:UnitUI):void {
        this._unitUI = param1;
    }
}
}
