package model.logic.commands.locations {
import model.data.Resources;
import model.data.locations.Location;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class ContributeResourcesCmd extends BaseCmd {


    private var _towerId:Number;

    private var _resources:Resources;

    private var requestDto;

    public function ContributeResourcesCmd(param1:Number, param2:Resources) {
        super();
        this._towerId = param1;
        this._resources = param2;
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "t": this._towerId,
            "r": this._resources.toDto()
        });
    }

    public static function getResourcesUpgradePrice(param1:Location):Resources {
        return new Resources(0, StaticDataManager.towerData.upgradePrice[param1.gameData.towerData.level - 1].money / 100, StaticDataManager.towerData.upgradePrice[param1.gameData.towerData.level - 1].uranium / 100, StaticDataManager.towerData.upgradePrice[param1.gameData.towerData.level - 1].titanite / 100);
    }

    public static function getGoldUpgradePrice(param1:Location):Number {
        var _loc2_:Resources = param1.gameData.towerData.resources;
        var _loc3_:Resources = StaticDataManager.towerData.upgradePrice[param1.gameData.towerData.level - 1];
        var _loc4_:Number = _loc3_.goldMoney - _loc2_.capacity() / (_loc3_.capacity() - _loc3_.goldMoney) * _loc3_.goldMoney;
        if (_loc4_ < 5000) {
            return 5000;
        }
        return _loc4_;
    }

    override public function execute():void {
        new JsonCallCmd("ContributeResources", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = param1.o != null ? Resources.fromDto(param1.o) : _resources;
                UserManager.user.gameData.account.resources.substract(_loc2_);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
