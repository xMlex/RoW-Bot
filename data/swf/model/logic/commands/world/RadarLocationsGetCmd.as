package model.logic.commands.world {
import common.ArrayCustom;

import model.data.locations.LocationNote;
import model.data.scenes.types.info.BuildingTypeId;
import model.data.users.UserNote;
import model.logic.LocationNoteManager;
import model.logic.UserManager;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class RadarLocationsGetCmd extends BaseCmd {

    private static var _radarLevel:int = 0;

    private static var _locationIds:ArrayCustom = new ArrayCustom();


    private var requestDto;

    private var _isMine:Boolean = false;

    public function RadarLocationsGetCmd(param1:Boolean = false) {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto();
        this._isMine = param1;
    }

    private static function getRadarLevel():int {
        var _loc1_:Array = UserManager.user.gameData.sector.getBuildings(BuildingTypeId.IndustrialRadar);
        if (_loc1_.length == 0) {
            return 0;
        }
        return _loc1_[0].getLevel();
    }

    override public function execute():void {
        var radarLevel:int = 0;
        var locationNotes:ArrayCustom = null;
        radarLevel = getRadarLevel();
        if (!this._isMine && _radarLevel == radarLevel) {
            locationNotes = LocationNoteManager.getByIds(_locationIds);
            if (_onResult != null) {
                _onResult(locationNotes);
            }
            if (_onFinally != null) {
                _onFinally();
            }
            return;
        }
        new JsonCallCmd("GetRadarLocations", this.requestDto).ifResult(function (param1:*):void {
            var _loc4_:* = undefined;
            UserRefreshCmd.updateUserByResultDto(param1, requestDto);
            var _loc2_:* = LocationNote.fromDtos(param1.o.l);
            var _loc3_:* = UserNote.fromDtos(param1.o.n);
            LocationNoteManager.update(_loc2_);
            UserNoteManager.update(_loc3_);
            _radarLevel = radarLevel;
            _locationIds = new ArrayCustom();
            for each(_loc4_ in _loc2_) {
                _locationIds.addItem(_loc4_.id);
            }
            if (_onResult != null) {
                _onResult(_loc2_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
