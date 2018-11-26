package model.logic.commands.artifacts {
import model.data.scenes.objects.info.ArtifactStorageId;
import model.logic.ArtifactManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class MoveArtifactToStorageCmd extends BaseCmd {


    private var _artifactId:Number;

    private var requestDto;

    public function MoveArtifactToStorageCmd(param1:Number) {
        super();
        this._artifactId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto(this._artifactId);
    }

    override public function execute():void {
        new JsonCallCmd("MoveArtifactToStorage", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc6_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user.gameData.artifactData;
                _loc3_ = _loc2_.artifacts[_artifactId];
                _loc4_ = _loc2_.artifactsLayout.indexOf(_artifactId);
                _loc5_ = ArtifactManager.GetStorageAddIndex(_loc2_);
                _loc2_.artifactsLayout[_loc4_] = 0;
                _loc2_.artifactsLayout[_loc5_] = _artifactId;
                _loc3_.artifactInfo.storageId = ArtifactStorageId.STORAGE;
                _loc3_.constructionInfo.constructionStartTime = null;
                _loc3_.constructionInfo.constructionFinishTime = null;
                _loc6_ = UserManager.user;
                _loc6_.gameData.constructionData.updateAcceleration(_loc6_.gameData, _loc6_.gameData.normalizationTime);
                _loc2_.artifactsDirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
