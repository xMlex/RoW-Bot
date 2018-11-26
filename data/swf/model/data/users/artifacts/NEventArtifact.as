package model.data.users.artifacts {
import model.data.User;
import model.data.normalization.NEventUser;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.objects.info.ArtifactStorageId;

public class NEventArtifact extends NEventUser {


    private var _artifact:GeoSceneObject;

    public function NEventArtifact(param1:GeoSceneObject, param2:Date) {
        super(param2);
        this._artifact = param1;
    }

    override protected function postProcess(param1:User, param2:Date):void {
        var _loc3_:UserArtifactData = param1.gameData.artifactData;
        delete _loc3_.artifacts[this._artifact.id];
        var _loc4_:Array = _loc3_.artifactsLayout;
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_.length) {
            if (_loc4_[_loc5_] == this._artifact.id) {
                _loc4_[_loc5_] = 0;
                break;
            }
            _loc5_++;
        }
        if (this._artifact.artifactInfo.storageId == ArtifactStorageId.ACTIVE) {
            param1.gameData.constructionData.updateAcceleration(param1.gameData, time);
            param1.gameData.artifactData.activeArtifactExpired = true;
        }
        if (this._artifact.artifactInfo.storageId == ArtifactStorageId.TEMPORARY_STORAGE) {
            param1.gameData.artifactData.temporarySlotsChanged = true;
        }
        param1.gameData.artifactData.artifactsDirty = true;
    }
}
}
