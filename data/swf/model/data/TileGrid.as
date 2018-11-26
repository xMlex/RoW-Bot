package model.data {
import flash.geom.Point;

public class TileGrid {

    public static const CENTER_ROWS:int = 3;


    private var _width:int;

    private var _height:int;

    private var _tileWidth:Number;

    private var _tileHeight:Number;

    public function TileGrid(param1:int, param2:int) {
        super();
        this._width = param1;
        this._height = param2;
        this.init();
    }

    public function get tileWidth():int {
        return this._tileWidth;
    }

    private function init():void {
        this._tileHeight = this._height / VisualBattleConfig.TILE_ROWS;
        this._tileWidth = this._width / VisualBattleConfig.TILE_COLUMNS;
    }

    public function getCenter(param1:int, param2:int):Point {
        return new Point(param1 * this._tileWidth + this._tileWidth / 2, param2 * this._tileHeight + this._tileHeight / 2);
    }

    public function set height(param1:int):void {
        this._height = param1;
    }

    public function set width(param1:int):void {
        this._width = param1;
    }
}
}
