package model.data.scenes.types.info {
import common.ArrayCustom;

import flash.utils.Dictionary;

public class GraphicsTypeInfo {


    public var url:String;

    public var previewUrl:String;

    public var previewSmallUrl:String;

    public var x:int;

    public var y:int;

    public var sizeX:int;

    public var sizeY:int;

    public var offsetX:int;

    public var offsetY:int;

    public var offsetXRight:int;

    public var animationDuration:Number;

    public var clientSortOrder:int;

    public var newUntil:Date;

    public var levelInfos:Dictionary;

    public function GraphicsTypeInfo() {
        super();
    }

    public static function fromDto(param1:*):GraphicsTypeInfo {
        var _loc3_:* = undefined;
        var _loc2_:GraphicsTypeInfo = new GraphicsTypeInfo();
        _loc2_.url = param1.lu != null ? param1.lu.c : param1.u;
        _loc2_.previewUrl = param1.p == null ? null : param1.p;
        _loc2_.previewSmallUrl = param1.s == null ? null : param1.s;
        _loc2_.x = param1.x;
        _loc2_.y = param1.y;
        _loc2_.sizeX = param1.sx;
        _loc2_.sizeY = param1.sy;
        _loc2_.offsetX = param1.ox;
        _loc2_.offsetY = param1.oy;
        _loc2_.animationDuration = param1.a;
        _loc2_.clientSortOrder = param1.n == null ? 0 : int(param1.n);
        _loc2_.newUntil = param1.l == null ? null : new Date(param1.l);
        _loc2_.levelInfos = new Dictionary();
        if (param1.li != null) {
            for (_loc3_ in param1.li) {
                _loc2_.levelInfos[_loc3_] = GraphicsLevelInfo.fromDto(param1.li[_loc3_]);
            }
        }
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
