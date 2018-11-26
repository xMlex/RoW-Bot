package model.data.normalization {
import model.data.User;
import model.data.scenes.objects.GeoSceneObject;
import model.logic.UserManager;
import model.modules.allianceHelp.data.user.UserAllianceHelpData;
import model.modules.allianceHelp.data.user.UserAllianceHelpRequest;

public class NEventConstruction extends NEventUser {


    private var _obj:INConstructible;

    public function NEventConstruction(param1:GeoSceneObject, param2:Date) {
        super(param2);
        this._obj = param1;
    }

    override protected function postProcess(param1:User, param2:Date):void {
        var _loc3_:UserAllianceHelpData = null;
        var _loc4_:int = 0;
        var _loc5_:UserAllianceHelpRequest = null;
        this._obj.constructionObjInfo.level++;
        this._obj.constructionObjInfo.constructionStartTime = null;
        this._obj.constructionObjInfo.constructionFinishTime = null;
        this._obj.constructionObjInfo.progressPercentage = 0;
        param1.gameData.sector.recalcBuildings();
        if (this._obj is GeoSceneObject && (this._obj as GeoSceneObject).buildingInfo) {
            _loc3_ = UserManager.user.gameData.allianceData.allianceHelpData;
            if (_loc3_ != null) {
                _loc4_ = 0;
                while (_loc4_ < _loc3_.requests.length) {
                    _loc5_ = _loc3_.requests[_loc4_];
                    if (_loc5_.buildingInfo != null && _loc5_.buildingInfo.buildingId == (this._obj as GeoSceneObject).id && _loc5_.buildingInfo.buildingTypeId == (this._obj as GeoSceneObject).type.id) {
                        _loc3_.requests.splice(_loc4_, 1);
                        break;
                    }
                    _loc4_++;
                }
            }
        }
    }
}
}
