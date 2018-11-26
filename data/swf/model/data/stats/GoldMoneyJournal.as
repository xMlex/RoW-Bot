package model.data.stats {
import flash.events.EventDispatcher;

public class GoldMoneyJournal {

    public static var event:EventDispatcher = new EventDispatcher();


    public var incomeRecords:Array;

    public var spendingRecords:Array;

    public function GoldMoneyJournal() {
        this.incomeRecords = new Array();
        this.spendingRecords = new Array();
        super();
    }

    public static function fromDto(param1:Object):GoldMoneyJournal {
        var _loc2_:GoldMoneyJournal = new GoldMoneyJournal();
        if (param1.i) {
            _loc2_.incomeRecords = GoldMoneyJournalRecord.fromDtos(param1.i);
        }
        if (param1.s) {
            _loc2_.spendingRecords = GoldMoneyJournalRecord.fromDtos(param1.s);
        }
        return _loc2_;
    }
}
}
