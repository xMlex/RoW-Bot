package model.data.scenes.types.info {
public class GraphicsLevelInfo {


    public var url:String;

    public var previewUrl:String;

    public var previewSmallUrl:String;

    public var localizedUrl:String;

    public var offsetX:int;

    public var offsetY:int;

    public var offsetXRight:int;

    public var scale:Number;

    public var animationDuration:Number;

    public function GraphicsLevelInfo() {
        super();
    }

    public static function fromDto(param1:*):GraphicsLevelInfo {
        var _loc2_:GraphicsLevelInfo = new GraphicsLevelInfo();
        _loc2_.url = param1.u == null ? null : param1.u;
        _loc2_.previewUrl = param1.p == null ? null : param1.p;
        _loc2_.previewSmallUrl = param1.s == null ? null : param1.s;
        _loc2_.localizedUrl = param1.lu == null ? null : param1.lu.c;
        _loc2_.offsetX = param1.ox == null ? 0 : int(param1.ox);
        _loc2_.offsetY = param1.oy == null ? 0 : int(param1.oy);
        _loc2_.offsetXRight = param1.or == null ? 0 : int(param1.or);
        _loc2_.scale = param1.sc == null ? Number(0) : Number(param1.sc);
        _loc2_.animationDuration = param1.a == null ? Number(0) : Number(param1.a);
        return _loc2_;
    }
}
}
