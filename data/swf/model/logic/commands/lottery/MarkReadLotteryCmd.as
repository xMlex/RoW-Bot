package model.logic.commands.lottery {
import flash.events.Event;

import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.lotteries.LotteryManager;

public class MarkReadLotteryCmd extends BaseCmd {


    private var _requestDto;

    private var _lotteryIds:Array;

    public function MarkReadLotteryCmd(param1:Array) {
        super();
        this._lotteryIds = param1;
        this._requestDto = UserRefreshCmd.makeRequestDto(param1);
    }

    override public function execute():void {
        new JsonCallCmd("Lottery.MarkRead", this._requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            LotteryManager.deleteLotteriesByIds(_lotteryIds);
            if (!UserRefreshCmd.updateUserByResultDto(param1, _requestDto)) {
                _loc3_ = UserManager.user.gameData.lotteryData.lostLotteries;
                if (_loc3_ != null) {
                    _loc4_ = 0;
                    while (_loc4_ < _lotteryIds.length) {
                        _loc5_ = 0;
                        while (_loc5_ < _loc3_.length) {
                            if (_loc3_[_loc5_].id == _lotteryIds[_loc4_]) {
                                _loc3_.splice(_loc5_, 1);
                                _loc2_ = true;
                                break;
                            }
                            _loc5_++;
                        }
                        _loc4_++;
                    }
                }
                if (_loc2_) {
                    UserManager.user.gameData.lotteryData.dirty = true;
                    UserManager.user.gameData.lotteryData.dispatchEvents();
                }
                else {
                    LotteryManager.events.dispatchEvent(new Event(LotteryManager.LOTTERIES_DATA_CHANGED));
                }
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
