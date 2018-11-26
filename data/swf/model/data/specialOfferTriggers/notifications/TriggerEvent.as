package model.data.specialOfferTriggers.notifications {
import model.data.specialOfferTriggers.TriggerTestConsole;
import model.logic.commands.triggers.TriggerClientEventDto;

public class TriggerEvent {


    private var _onResult:Function;

    public function TriggerEvent() {
        super();
    }

    public function startVerification(param1:Function):void {
        var _loc2_:* = this.className + " start";
        TriggerTestConsole.trace(_loc2_);
        this._onResult = param1;
        this.verification();
    }

    public function get triggerEventDto():TriggerClientEventDto {
        return null;
    }

    protected function verification():void {
        this.respond(true);
    }

    protected function respond(param1:Boolean):void {
        var _loc2_:String = this.className + " respond: " + param1;
        TriggerTestConsole.trace(_loc2_);
        this._onResult.call(null, param1, this);
    }

    protected function get className():String {
        return "TriggerEvent";
    }
}
}
