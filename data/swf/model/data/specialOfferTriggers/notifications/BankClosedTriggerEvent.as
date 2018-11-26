package model.data.specialOfferTriggers.notifications {
import flash.events.Event;

import model.data.specialOfferTriggers.TriggerEventTypeEnum;
import model.data.specialOfferTriggers.TriggerTestConsole;
import model.logic.ServerTimeManager;
import model.logic.TimerManager;
import model.logic.UserManager;
import model.logic.commands.triggers.TriggerClientEventDto;

public class BankClosedTriggerEvent extends TriggerEvent {

    private static const NAME:String = "BankClosedTriggerEvent";

    private static const SECONDS:int = 300;

    private static const HALF_MINUTE:int = 30;


    private var _timer:int;

    private var _openedBankTime:Date;

    public function BankClosedTriggerEvent() {
        super();
    }

    override public function get triggerEventDto():TriggerClientEventDto {
        var _loc1_:TriggerClientEventDto = new TriggerClientEventDto(TriggerEventTypeEnum.NO_PURCHASES_BANK_VISIT);
        _loc1_.g = UserManager.user.gameData.account.resources.goldMoney;
        _loc1_.w = UserManager.user.gameData.constructionData.constructionWorkersCount;
        return _loc1_;
    }

    public function close():void {
        if (this._openedBankTime != null) {
            this.timerStart();
        }
    }

    override protected function verification():void {
        this._openedBankTime = ServerTimeManager.serverTimeNow;
    }

    private function timerStart():void {
        TimerManager.addTickListener(this.timerTick_eventHandler);
        this._timer = SECONDS;
    }

    private function timerStop():void {
        TimerManager.removeTickListener(this.timerTick_eventHandler);
    }

    private function timerTick():void {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        var _loc3_:* = null;
        var _loc4_:* = false;
        var _loc5_:Date = null;
        if (this._timer % HALF_MINUTE == 0) {
            _loc1_ = this._timer / 60;
            _loc2_ = this._timer - _loc1_ * 60;
            _loc3_ = _loc1_ + "m. " + _loc2_ + "s.";
            TriggerTestConsole.trace(this.className + " timer: " + _loc3_);
        }
        if (--this._timer <= 0) {
            this.timerStop();
            _loc5_ = UserManager.user.gameData.statsData.lastDepositDate;
            if (_loc5_ != null) {
                _loc4_ = _loc5_ > this._openedBankTime;
            }
            respond(!_loc4_);
        }
    }

    private function timerTick_eventHandler(param1:Event = null):void {
        this.timerTick();
    }

    override protected function get className():String {
        return NAME;
    }
}
}
