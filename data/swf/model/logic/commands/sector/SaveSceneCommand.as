package model.logic.commands.sector {
import gameObjects.sceneObject.SceneObject;

import model.data.Resources;
import model.data.scenes.GeoScene;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class SaveSceneCommand extends BaseCmd {

    public static var DeletedObjects:Array = [];

    public static var DeletedByUserTypeIds:Array = [];


    private var _scene:GeoScene;

    private var _isWarcamp:Boolean;

    private var _deletedObjectIds:Array;

    private var _deletedByUserTypeIds:Array;

    private var requestDto;

    public function SaveSceneCommand(param1:GeoScene, param2:Boolean = false) {
        var _loc3_:SceneObject = null;
        var _loc4_:int = 0;
        this._deletedObjectIds = [];
        this._deletedByUserTypeIds = [];
        super();
        this._scene = param1;
        this._isWarcamp = param2;
        if (!this._isWarcamp) {
            for each(_loc3_ in DeletedObjects) {
                this._deletedObjectIds.push(_loc3_.id);
            }
            for each(_loc4_ in DeletedByUserTypeIds) {
                this._deletedByUserTypeIds.push(_loc4_);
            }
        }
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "s": this._scene.toDto(),
            "d": this._deletedObjectIds,
            "w": this._isWarcamp
        });
    }

    override public function execute():void {
        if (!this._isWarcamp) {
            DeletedObjects = [];
            DeletedByUserTypeIds = [];
        }
        new JsonCallCmd("SaveScene", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc4_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc4_ = Resources.fromDto(param1.o);
                if (_loc4_) {
                    UserManager.user.gameData.account.resources.add(_loc4_);
                }
            }
            UserManager.user.gameData.updateObjectsBuyStatus(true, true);
            var _loc2_:* = UserManager.user.gameData.sector;
            var _loc3_:* = 0;
            while (_loc3_ < _deletedByUserTypeIds.length) {
                _loc2_.markBuildingDeletedByUser(_deletedByUserTypeIds[_loc3_]);
                _loc3_++;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
