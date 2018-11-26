package model.logic.journal {
public interface IJournalRecord {


    function get clientRecordId():Number;

    function set clientRecordId(param1:Number):void;

    function get eventTypeId():int;

    function set eventTypeId(param1:int):void;

    function get eventData():*;

    function set eventData(param1:*):void;

    function get revision():*;

    function set revision(param1:*):void;
}
}
