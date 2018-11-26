package model.logic.commands.troopsTier {
import model.data.User;
import model.data.normalization.Normalizer;
import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.data.users.misc.UserBlackMarketData;
import model.data.users.troops.TroopsTierObjLevelInfo;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.applyBehaviours.contexts.DistributeUpgradePointsApplyContext;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class RedistributeUpgradePointsCmd extends BaseCmd {


    private var _tierId:int;

    private var _withBMItem:Boolean;

    private var _requestDto;

    public function RedistributeUpgradePointsCmd(param1:DistributeUpgradePointsApplyContext) {
        super();
        this._tierId = param1.tierId;
        this._withBMItem = param1.useBlackMarketItem;
        this._requestDto = UserRefreshCmd.makeRequestDto(param1.toDto());
    }

    override public function execute():void {
        new JsonCallCmd("Troops.RedistributeUpgradePoints", this._requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _requestDto)) {
                _loc2_ = UserManager.user;
                if (param1.o.o != null) {
                    _loc3_ = TroopsTierObjLevelInfo.fromDto(param1.o.o);
                    _loc2_.gameData.troopsData.updateTier(_tierId, _loc3_);
                }
                if (_withBMItem) {
                    subtractBMItem(_loc2_);
                }
                Normalizer.normalize(_loc2_);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }

    private function subtractBMItem(param1:User):void {
        var _loc2_:BlackMarketItemRaw = StaticDataManager.blackMarketData.itemsById[BlackMarketItemsTypeId.RedistributeTroopsTierUpgradePoints];
        var _loc3_:UserBlackMarketData = param1.gameData.blackMarketData;
        param1.gameData.blackMarketData.dirty = true;
        param1.gameData.updateObjectsBuyStatus(true);
        if (_loc2_ != null && _loc3_.boughtItems[_loc2_.id] != undefined) {
            _loc3_.boughtItems[_loc2_.id].paidCount--;
        }
    }
}
}
