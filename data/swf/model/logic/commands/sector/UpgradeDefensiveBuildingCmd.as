package model.logic.commands.sector {
import model.data.scenes.objects.GeoSceneObject;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class UpgradeDefensiveBuildingCmd extends BaseCmd {


    private var _defensiveObjecs:Array;

    private var _buyTypeId:int;

    private var requestDto;

    public function UpgradeDefensiveBuildingCmd(param1:Array, param2:int) {
        var _loc4_:GeoSceneObject = null;
        super();
        this._defensiveObjecs = param1;
        this._buyTypeId = param2;
        var _loc3_:Array = new Array();
        for each(_loc4_ in this._defensiveObjecs) {
            _loc3_.push(_loc4_.id);
        }
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "o": _loc3_,
            "t": param2
        });
    }

    override public function execute():void {
        new JsonCallCmd("UpgradeDefensiveObject", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = UserRefreshCmd.updateUserByResultDto(param1, requestDto);
            if (!_loc2_) {
                UserManager.user.gameData.dispatchEvents();
            }
            UserManager.user.gameData.constructionData.availableWorkersChanged = true;
            if (_onResult != null) {
                _onResult(_loc2_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
