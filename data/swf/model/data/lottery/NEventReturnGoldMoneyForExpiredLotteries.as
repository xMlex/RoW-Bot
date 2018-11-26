package model.data.lottery {
import model.data.Resources;
import model.data.User;
import model.data.normalization.NEventUser;
import model.logic.UserManager;
import model.logic.lotteries.LotteryManager;

public class NEventReturnGoldMoneyForExpiredLotteries extends NEventUser {


    private var _expiredLotteriesIds:Array;

    public function NEventReturnGoldMoneyForExpiredLotteries(param1:Array, param2:Date) {
        this._expiredLotteriesIds = param1;
        super(param2);
    }

    override protected function postProcess(param1:User, param2:Date):void {
        var _loc4_:Array = null;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc7_:TicketCount = null;
        var _loc8_:TicketTypeInfo = null;
        var _loc3_:UserLotteryData = param1.gameData.lotteryData;
        for each(_loc6_ in this._expiredLotteriesIds) {
            if (_loc3_.contributedTicketTypesCountByLotteryId != null && _loc3_.contributedTicketTypesCountByLotteryId[_loc6_] != undefined) {
                _loc4_ = _loc3_.contributedTicketTypesCountByLotteryId[_loc6_];
                for each(_loc7_ in _loc4_) {
                    _loc8_ = LotteryManager.getTicketInfoByTicketId(_loc7_.ticketTypeId);
                    if (_loc7_.freeCount > 0) {
                        if (_loc3_.freeTicketsCountByTypeId == null) {
                            _loc3_.freeTicketsCountByTypeId = {};
                        }
                        _loc3_.freeTicketsCountByTypeId[_loc7_.ticketTypeId] = _loc3_.freeTicketsCountByTypeId[_loc7_.ticketTypeId] + _loc7_.freeCount;
                    }
                    if (_loc7_.paidCount > 0) {
                        _loc5_ = _loc5_ + _loc7_.paidCount * _loc8_.price.goldMoney;
                    }
                }
                delete _loc3_.contributedTicketTypesCountByLotteryId[_loc6_];
            }
        }
        LotteryManager.deleteLotteriesByIds(this._expiredLotteriesIds);
        if (_loc5_ > 0) {
            UserManager.user.gameData.account.resources.add(new Resources(_loc5_));
        }
    }
}
}
