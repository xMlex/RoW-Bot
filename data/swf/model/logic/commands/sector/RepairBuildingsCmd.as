package model.logic.commands.sector {
import common.ArrayCustom;

import model.data.scenes.objects.GeoSceneObject;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class RepairBuildingsCmd extends BaseCmd {


    private var _buildings:Array;

    private var requestDto;

    public function RepairBuildingsCmd(param1:Array) {
        super();
        this._buildings = param1;
        var _loc2_:Array = [];
        var _loc3_:int = 0;
        while (_loc3_ < this._buildings.length) {
            _loc2_.push(this._buildings[_loc3_].id);
            _loc3_++;
        }
        this.requestDto = UserRefreshCmd.makeRequestDto({"i": _loc2_});
    }

    override public function execute():void {
        new JsonCallCmd("RepairBuildings", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = param1.o.l;
                _loc3_ = 0;
                while (_loc3_ < _buildings.length) {
                    (_buildings[_loc3_] as GeoSceneObject).constructionInfo.constructionStartTime = new Date(_loc2_[_loc3_].s);
                    (_buildings[_loc3_] as GeoSceneObject).constructionInfo.constructionFinishTime = new Date(_loc2_[_loc3_].f);
                    (_buildings[_loc3_] as GeoSceneObject).dirtyNormalized = true;
                    _loc3_++;
                }
                UserManager.user.gameData.sector.buildingRepairedForUserIds = new ArrayCustom(_loc2_);
                UserManager.user.gameData.sector.recalcBuildings();
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
