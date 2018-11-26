package model.data.scenes.types.info.troops {
public class BattleBehaviour {


    public var absoluteLosses:Boolean;

    public var civilUnit:Boolean;

    public function BattleBehaviour() {
        super();
    }

    public static function fromDto(param1:*):BattleBehaviour {
        if (param1 == null) {
            return null;
        }
        var _loc2_:BattleBehaviour = new BattleBehaviour();
        _loc2_.absoluteLosses = param1.d;
        _loc2_.civilUnit = param1.c;
        return _loc2_;
    }
}
}
