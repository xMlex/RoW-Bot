package model.logic.commands.world {
import model.data.effects.EffectTypeId;
import model.data.units.MapObjectTypeId;
import model.data.units.Unit;
import model.data.users.troops.TroopsOrderId;
import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.FaultDto;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.units.UnitUtility;

public class UnitCancelCmd extends BaseCmd {


    private var _unit:Unit;

    private var _itemId:int;

    private var requestDto;

    public function UnitCancelCmd(param1:Unit, param2:int = 0) {
        super();
        this._unit = param1;
        this._itemId = param2;
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "i": this._unit.UnitId,
            "b": (this._itemId == 0 ? null : param2)
        });
    }

    public static function getCancelTimeLeftSeconds(param1:Unit):Number {
        if (param1.OwnerUserId != UserManager.user.id || param1.StateMovingForward == null || param1.StateMovingForward.canceling == true || param1.tradingPayload != null && param1.tradingOfferPayload != null) {
            return -1;
        }
        var _loc2_:Number = (ServerTimeManager.serverTimeNow.time - param1.StateMovingForward.departureTime.time) / 1000;
        return _loc2_ < 51 ? Number(_loc2_) : Number(-1);
    }

    override public function execute():void {
        new JsonCallCmd("CancelUnit", this.requestDto).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                if (_itemId != 0) {
                    _loc3_ = UserManager.user.gameData.blackMarketData.boughtItems;
                    _loc4_ = _loc3_[_itemId];
                    if (_loc4_) {
                        if (_loc4_.freeCount + _loc4_.paidCount == 1) {
                            delete _loc3_[_itemId];
                        }
                        else if (_loc4_.freeCount > 0) {
                            _loc4_.freeCount--;
                        }
                        else {
                            _loc4_.paidCount--;
                        }
                    }
                }
                _loc2_ = _unit.troopsPayload != null && _unit.troopsPayload.order == TroopsOrderId.Bunker;
                if (_unit.TargetTypeId == MapObjectTypeId.RAID_LOCATION || _loc2_) {
                    if (UserManager.user.gameData.effectData.isActiveEffect(EffectTypeId.UserAutoMoveTroopsBunker) && !_loc2_) {
                        UnitUtility.UnloadUnitToBunker(UserManager.user, _unit);
                    }
                    else {
                        UnitUtility.UnloadUnit(UserManager.user, _unit);
                    }
                    UnitUtility.RemoveUnit(UserManager.user, _unit);
                    UserManager.user.gameData.worldData.dirtyUnitListChanged = true;
                }
                else {
                    _unit.StateMovingForward.canceling = true;
                    UserManager.user.gameData.worldData.dirtyUnitsMoved = true;
                }
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(function (param1:FaultDto):void {
            if (_onFault != null) {
                _onFault(param1);
            }
        }).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
