package model.data.scenes.objects.info {
public class GemObjInfo {


    public var slotId:int;

    public function GemObjInfo() {
        super();
    }

    public static function fromDto(param1:*):GemObjInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:GemObjInfo = new GemObjInfo();
        _loc2_.slotId = param1.s == null ? -1 : int(param1.s);
        return _loc2_;
    }
}
}
