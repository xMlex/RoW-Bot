package model.logic.commands.allianceCity {
import model.logic.AllianceManager;
import model.logic.commands.alliances.BaseAllianceCmd;
import model.logic.commands.server.JsonCallCmd;

public class UpdateAllianceCityPermissions extends BaseAllianceCmd {


    private var _dto;

    private var _userId:Number;

    private var _canPerform:Boolean;

    public function UpdateAllianceCityPermissions(param1:Number, param2:Boolean) {
        super();
        this._dto = makeRequestDto({
            "a": AllianceManager.currentAlliance.id,
            "u": param1,
            "p": param2
        });
        this._userId = param1;
        this._canPerform = param2;
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.UpdateCityPermissions", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData.cityData.permittedUserIds;
                if (_loc2_ == null) {
                    _loc2_ = AllianceManager.currentAlliance.gameData.cityData.permittedUserIds = [];
                }
                if (_canPerform) {
                    if (_loc2_.indexOf(_userId) < 0) {
                        _loc2_.push(_userId);
                    }
                }
                else {
                    _loc3_ = _loc2_.indexOf(_userId);
                    if (_loc3_ >= 0) {
                        _loc2_.splice(_loc3_, 1);
                    }
                }
                AllianceManager.currentAlliance.gameData.cityData.dirty = true;
            }
            if (_onResult != null) {
                _onResult(param1);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
