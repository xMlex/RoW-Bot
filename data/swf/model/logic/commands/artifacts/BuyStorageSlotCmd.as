package model.logic.commands.artifacts {
import model.data.Resources;
import model.logic.ArtifactManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class BuyStorageSlotCmd extends BaseCmd {


    private var requestDto;

    public function BuyStorageSlotCmd() {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("BuyStorageSlot", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user;
                _loc3_ = _loc2_.gameData.artifactData;
                if (_loc3_.storageSlotsAvailable >= StaticDataManager.artifactData.maxStorageSize) {
                    return;
                }
                _loc4_ = Resources.fromGoldMoney(ArtifactManager.GetGoldMoneyPriceForSlot(_loc2_));
                if (!_loc2_.gameData.account.resources.canSubstract(_loc4_)) {
                    return;
                }
                _loc2_.gameData.account.resources.substract(_loc4_);
                _loc3_.storageSlotsAvailable++;
                _loc3_.storageSlotsBought++;
                _loc3_.artifactsLayout.push(0);
                _loc3_.artifactsDirty = true;
                _loc3_.availableSlotsChanged = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
