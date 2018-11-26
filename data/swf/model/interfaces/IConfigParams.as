package model.interfaces {
public interface IConfigParams {


    function get MAX_UNIT_COUNT():int;

    function get DELAY_LOADING_MILLISECONDS():uint;

    function get TILE_ROWS():int;

    function get TILE_COLUMNS():int;

    function get TILE_WIDTH():int;

    function get TILE_HEIGHT():int;

    function get contentServerAddressHTTP():String;

    function get contentServerAddressHTTPS():String;

    function get INTRO_DELEY_MSEC():Number;
}
}
