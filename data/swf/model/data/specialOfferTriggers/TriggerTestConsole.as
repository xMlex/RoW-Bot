package model.data.specialOfferTriggers {
public class TriggerTestConsole {

    private static var _sentEventsTracer:String;

    private static var _tracer:String;

    public static var sentEventsTracerUpdateHandler:Function;

    public static var tracerUpdateHandler:Function;


    public function TriggerTestConsole() {
        super();
    }

    public static function addSentEventTrace(param1:String):void {
        if (_sentEventsTracer == null) {
            _sentEventsTracer = "";
        }
        _sentEventsTracer = "- Отправлен лог:  " + param1 + "\n" + _sentEventsTracer;
        if (sentEventsTracerUpdateHandler != null) {
            sentEventsTracerUpdateHandler.call(null, _sentEventsTracer);
        }
    }

    public static function trace(param1:String):void {
        if (_tracer == null) {
            _tracer = "";
        }
        _tracer = param1 + "\n" + _tracer;
        if (tracerUpdateHandler != null) {
            tracerUpdateHandler.call(null, _tracer);
        }
    }
}
}
