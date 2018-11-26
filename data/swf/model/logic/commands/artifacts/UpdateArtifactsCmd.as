package model.logic.commands.artifacts {
import flash.utils.Dictionary;

import model.data.normalization.Normalizer;
import model.data.scenes.objects.GeoSceneObject;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class UpdateArtifactsCmd extends BaseCmd {


    private var _ids:Array;

    private var _removeIds:Array;

    private var requestDto;

    public function UpdateArtifactsCmd(param1:Array, param2:Array) {
        super();
        this._ids = param1;
        this._removeIds = param2;
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "i": this._ids,
            "r": this._removeIds
        });
    }

    override public function execute():void {
        new JsonCallCmd("UpdateArtifacts", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user;
                _loc3_ = _loc2_.gameData.artifactData;
                _loc3_.artifactsLayout = _ids;
                _loc3_.artifacts = new Dictionary();
                _loc4_ = GeoSceneObject.fromDtos(param1.o.a);
                for each(_loc5_ in _loc4_) {
                    _loc3_.artifacts[_loc5_.id] = _loc5_;
                }
                Normalizer.normalize(UserManager.user);
                _loc2_.gameData.artifactData.artifactsDirty = true;
                _loc2_.gameData.constructionData.updateAcceleration(_loc2_.gameData, _loc2_.gameData.normalizationTime);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
