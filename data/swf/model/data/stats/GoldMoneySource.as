package model.data.stats {
public class GoldMoneySource {


    public var type:Number;

    public var countBySourceId:Object;

    public var id:int;

    public function GoldMoneySource() {
        super();
    }

    public static function fromDto(param1:Object):GoldMoneySource {
        var _loc2_:GoldMoneySource = new GoldMoneySource();
        _loc2_.type = param1.t;
        _loc2_.countBySourceId = param1.s;
        _loc2_.id = param1.i;
        return _loc2_;
    }
}
}
