package model.logic.commands.sector {
import model.data.scenes.objects.GeoSceneObject;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class RepairBuildingCmd extends BaseCmd {


    private var _building:GeoSceneObject;

    private var requestDto;

    public function RepairBuildingCmd(param1:GeoSceneObject) {
        super();
        this._building = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto({"i": this._building.id});
    }

    override public function execute():void {
        new JsonCallCmd("RepairBuilding", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = new Date(param1.o.s);
                _loc3_ = new Date(param1.o.f);
                _building.constructionInfo.constructionStartTime = _loc2_;
                _building.constructionInfo.constructionFinishTime = _loc3_;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
