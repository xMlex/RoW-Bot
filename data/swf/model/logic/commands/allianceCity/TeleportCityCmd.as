package model.logic.commands.allianceCity {
import model.data.map.MapPos;
import model.logic.AllianceManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class TeleportCityCmd extends BaseCmd {


    private var _requestDto;

    public function TeleportCityCmd(param1:MapPos) {
        super();
        this._requestDto = UserRefreshCmd.makeRequestDto({"p": param1});
    }

    override public function execute():void {
        new JsonCallCmd("TeleportCity", this._requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc6_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _requestDto)) {
                _loc2_ = StaticDataManager.blackMarketData.itemsById[param1.o.i] as BlackMarketItemRaw;
                _loc3_ = UserManager.user;
                _loc4_ = AllianceManager.currentAllianceCity;
                _loc5_ = _loc3_.gameData.blackMarketData.boughtItems;
                _loc6_ = _loc5_[_loc2_.id];
                if (_loc6_) {
                    if (_loc6_.freeCount + _loc6_.paidCount == 1) {
                        delete _loc5_[_loc2_.id];
                    }
                    else if (_loc6_.freeCount > 0) {
                        _loc6_.freeCount--;
                    }
                    else {
                        _loc6_.paidCount--;
                    }
                }
                _loc3_.gameData.blackMarketData.dirty = true;
                _loc3_.gameData.updateObjectsBuyStatus(true);
                _loc4_.gameData.mapPosDirty = true;
                _loc4_.gameData.dispatchEvents();
            }
            if (_onResult != null) {
                _onResult(param1.o);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
