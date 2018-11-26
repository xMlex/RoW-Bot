package model.data.stats {
public class GoldMoneyJournalRecord {


    public var source:GoldMoneySource;

    public var recordTime:Date;

    public var amount:Number;

    public var balance:Number;

    public function GoldMoneyJournalRecord() {
        super();
    }

    public static function fromDto(param1:Object):GoldMoneyJournalRecord {
        var _loc2_:GoldMoneyJournalRecord = new GoldMoneyJournalRecord();
        _loc2_.source = GoldMoneySource.fromDto(param1.s);
        _loc2_.recordTime = new Date(param1.t);
        _loc2_.amount = param1.a;
        _loc2_.balance = param1.b;
        return _loc2_;
    }

    public static function fromDtos(param1:Array):Array {
        var _loc2_:Array = [];
        var _loc3_:int = 0;
        while (_loc3_ < param1.length) {
            _loc2_.push(fromDto(param1[_loc3_]));
            _loc3_++;
        }
        return _loc2_;
    }
}
}
