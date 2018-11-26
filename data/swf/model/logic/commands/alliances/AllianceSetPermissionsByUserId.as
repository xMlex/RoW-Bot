package model.logic.commands.alliances {
import flash.utils.Dictionary;

import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class AllianceSetPermissionsByUserId extends BaseAllianceCmd {


    public var permissionByUserId:Dictionary;

    private var _dto;

    public function AllianceSetPermissionsByUserId(param1:Dictionary) {
        var _loc3_:* = undefined;
        super();
        this.permissionByUserId = param1;
        var _loc2_:Object = new Object();
        for (_loc3_ in param1) {
            _loc2_[_loc3_] = param1[_loc3_];
        }
        this._dto = makeRequestDto({"u": _loc2_});
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.SetPermissionsByUserId", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            if (!updateAllianceByResultDto(param1)) {
                AllianceManager.currentAlliance.gameData.permissionData.permissionByUserId = permissionByUserId;
                AllianceManager.currentAlliance.gameData.permissionData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
