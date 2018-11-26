package model.logic.commands.gems {
import common.ArrayCustom;

import model.data.Resources;
import model.data.scenes.objects.GeoSceneObject;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class UpgradeAllGemsCmd extends BaseCmd {


    private var _dto;

    public function UpgradeAllGemsCmd() {
        super();
        this._dto = UserRefreshCmd.makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("UpgradeAllGems", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _dto)) {
                if (param1.o != null) {
                    _loc2_ = param1.o.g == null ? new ArrayCustom() : GeoSceneObject.fromDtos2(param1.o.g);
                    UserManager.user.gameData.gemData.gems = _loc2_;
                    _loc3_ = param1.o.p == null ? null : Resources.fromDto(param1.o.p);
                    if (_loc3_ != null) {
                        UserManager.user.gameData.account.resources.substract(_loc3_);
                    }
                }
            }
            UserManager.user.gameData.gemData.dirty = true;
            if (_onResult != null) {
                _onResult(param1);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
