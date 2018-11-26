package model.logic.commands.artifacts {
import model.data.Resources;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class BuyActiveSlotCmd extends BaseCmd {


    private var requestDto;

    private var _slotIndex:int;

    private var _forFriends:Boolean;

    public function BuyActiveSlotCmd(param1:int, param2:Boolean) {
        super();
        this._slotIndex = param1;
        this._forFriends = param2;
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "i": this._slotIndex,
            "f": this._forFriends
        });
    }

    override public function execute():void {
        new JsonCallCmd("BuyActiveSlot", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user;
                _loc3_ = _loc2_.gameData.artifactData;
                if (_forFriends) {
                    _loc4_ = StaticDataManager.artifactData.friendsNumberPerActiveSlot[_loc3_.activeSlotsOpenedForFriends];
                    _loc3_.activeSlotsOpenedForFriends++;
                }
                else {
                    _loc5_ = Resources.fromGoldMoney(StaticDataManager.artifactData.activeSlotGoldMoneyPrice);
                    if (!_loc2_.gameData.account.resources.canSubstract(_loc5_)) {
                        return;
                    }
                    _loc3_.activeSlotsBought++;
                    _loc2_.gameData.account.resources.substract(_loc5_);
                }
                _loc3_.artifactsLayout[_slotIndex] = 0;
                _loc3_.artifactsDirty = true;
                _loc3_.activeSlotsChanged = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
