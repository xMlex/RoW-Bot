package model.logic.commands.artifacts {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class RemoveArtifactCmd extends BaseCmd {


    private var _artifactId:Number;

    private var requestDto;

    public function RemoveArtifactCmd(param1:Number) {
        super();
        this._artifactId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto(this._artifactId);
    }

    override public function execute():void {
        new JsonCallCmd("RemoveArtifact", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user.gameData.artifactData;
                if (_loc2_.artifacts[_artifactId] != null) {
                    delete _loc2_.artifacts[_artifactId];
                }
                _loc3_ = _loc2_.artifactsLayout;
                _loc4_ = 0;
                while (_loc4_ < _loc3_.length) {
                    if (_loc3_[_loc4_] == _artifactId) {
                        _loc3_[_loc4_] = 0;
                        break;
                    }
                    _loc4_++;
                }
                _loc5_ = UserManager.user;
                _loc2_.artifactsDirty = true;
                _loc5_.gameData.constructionData.updateAcceleration(_loc5_.gameData, _loc5_.gameData.normalizationTime);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
