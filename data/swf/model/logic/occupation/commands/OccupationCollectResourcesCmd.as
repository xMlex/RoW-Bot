package model.logic.occupation.commands {
import model.data.Resources;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class OccupationCollectResourcesCmd extends BaseCmd {


    private var _userId:Number;

    private var _resourceTypeId:int;

    private var requestDto;

    public function OccupationCollectResourcesCmd(param1:Number) {
        super();
        this._userId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto({"u": this._userId});
    }

    override public function execute():void {
        new JsonCallCmd("Occupation.CollectResources", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user;
                _loc3_ = _loc2_.gameData.occupationData.getUserInfo(_userId);
                _loc3_.lastCollectionTime = new Date(param1.o.d);
                _loc3_.collectionCoeff = param1.o.f;
                _loc3_.canBeCollected = false;
                _loc3_.dirtyNormalized = true;
                _loc2_.gameData.account.resources.add(Resources.fromDto(param1.o.r));
                _loc2_.gameData.occupationData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
