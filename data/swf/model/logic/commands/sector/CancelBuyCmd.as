package model.logic.commands.sector {
import model.data.Resources;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.users.drawings.DrawingPart;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.modules.allianceHelp.data.user.UserAllianceHelpData;
import model.modules.allianceHelp.data.user.UserAllianceHelpRequest;

public class CancelBuyCmd extends BaseCmd {


    private var requestDto;

    private var _object:GeoSceneObject;

    public function CancelBuyCmd(param1:GeoSceneObject) {
        super();
        this._object = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "t": this._object.objectType.id,
            "i": this._object.id
        });
    }

    public static function getCompensation(param1:GeoSceneObject):Resources {
        if (param1.objectType.buildingInfo == null && param1.technologyInfo == null) {
            return null;
        }
        var _loc2_:Resources = UserManager.user.gameData.getPrice(UserManager.user, param1.objectType, param1.getLevel() + 1, param1).clone();
        _loc2_.scale(0.8);
        return _loc2_;
    }

    public static function getCancelTimeLeftSeconds(param1:GeoSceneObject):Number {
        if (!param1) {
            return -1;
        }
        if (param1.objectType.buildingInfo == null && param1.technologyInfo == null || !param1.buildingInProgress) {
            return -1;
        }
        if (param1.constructionInfo.canceling == true) {
            return -1;
        }
        var _loc2_:Number = (ServerTimeManager.serverTimeNow.time - param1.constructionInfo.constructionStartTime.time) / 1000;
        return _loc2_ < 51 ? Number(_loc2_) : Number(-1);
    }

    override public function execute():void {
        this._object.constructionInfo.canceling = true;
        this._object.dirtyNormalized = true;
        new JsonCallCmd("CancelBuy", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = !!param1.o.b ? param1.o.b : 0;
                cancelObject(Resources.fromDto(param1.o.c), _loc2_);
                UserManager.user.gameData.recalcData();
                UserManager.user.gameData.constructionData.workersUsed = -1;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(function ():void {
            _object.constructionInfo.canceling = false;
            if (_onFinally != null) {
                _onFinally();
            }
        }).execute();
    }

    private function cancelObject(param1:Resources, param2:int = 0):void {
        var _loc3_:GeoSceneObjectType = null;
        var _loc4_:int = 0;
        var _loc5_:DrawingPart = null;
        var _loc6_:UserAllianceHelpData = null;
        var _loc7_:int = 0;
        var _loc8_:UserAllianceHelpRequest = null;
        this._object.constructionInfo.constructionStartTime = null;
        this._object.constructionInfo.constructionFinishTime = null;
        this._object.dirtyNormalized = true;
        if (this._object.getLevel() == 0) {
            if (this._object.objectType.buildingInfo != null) {
                UserManager.user.gameData.sector.sectorScene.sceneObjectRemove(this._object);
                UserManager.user.gameData.updateObjectsBuyStatus(false, true);
            }
            if (this._object.objectType.technologyInfo != null) {
                _loc3_ = StaticDataManager.getObjectType(this._object.objectType.id + 100);
                if (_loc3_ != null) {
                    _loc4_ = 0;
                    while (_loc4_ < _loc3_.drawingInfo.partsCount) {
                        _loc5_ = new DrawingPart();
                        _loc5_.typeId = _loc3_.id;
                        _loc5_.part = _loc4_;
                        UserManager.user.gameData.drawingArchive.addDrawingPart(_loc5_);
                        _loc4_++;
                    }
                }
            }
        }
        if (this._object.objectType.buildingInfo != null) {
            _loc6_ = UserManager.user.gameData.allianceData.allianceHelpData;
            if (_loc6_) {
                _loc7_ = 0;
                while (_loc7_ < _loc6_.requests.length) {
                    _loc8_ = _loc6_.requests[_loc7_];
                    if (_loc8_.buildingInfo && _loc8_.buildingInfo.buildingId == this._object.id) {
                        _loc6_.requests.splice(_loc7_, 1);
                        break;
                    }
                    _loc7_++;
                }
            }
        }
        UserManager.user.gameData.account.resources.add(param1);
        UserManager.user.gameData.invitationData.constructionBlockCount = UserManager.user.gameData.invitationData.constructionBlockCount + param2;
    }
}
}
