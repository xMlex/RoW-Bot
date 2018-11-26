package model.logic.journal {
public class JournalRecord implements IJournalRecord {


    private var _clientId:Number;

    private var _eventTypeId:int;

    private var _eventData;

    private var _revision:Number;

    public function JournalRecord() {
        super();
    }

    public static function fromDto(param1:*):IJournalRecord {
        var _loc2_:IJournalRecord = new JournalRecord();
        _loc2_.clientRecordId = param1.c;
        _loc2_.eventTypeId = param1.t;
        _loc2_.eventData = param1.e;
        _loc2_.revision = param1.r;
        return _loc2_;
    }

    public function get clientRecordId():Number {
        return this._clientId;
    }

    public function set clientRecordId(param1:Number):void {
        this._clientId = param1;
    }

    public function get eventTypeId():int {
        return this._eventTypeId;
    }

    public function set eventTypeId(param1:int):void {
        this._eventTypeId = param1;
    }

    public function get eventData():* {
        return this._eventData;
    }

    public function set eventData(param1:*):void {
        this._eventData = param1;
    }

    public function get revision():* {
        return this._revision;
    }

    public function set revision(param1:*):void {
        this._revision = param1;
    }
}
}
