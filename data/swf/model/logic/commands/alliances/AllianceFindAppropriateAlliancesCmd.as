package model.logic.commands.alliances {
import common.ArrayCustom;

import model.data.alliances.AllianceNote;
import model.data.alliances.AllianceSearchItem;
import model.data.users.UserNote;
import model.logic.AllianceManager;
import model.logic.AllianceNoteManager;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class AllianceFindAppropriateAlliancesCmd extends BaseCmd {


    private var _dto;

    protected var _onDataLoaded:Function;

    public function AllianceFindAppropriateAlliancesCmd(param1:int, param2:int, param3:int, param4:int) {
        super();
        this._dto = {
            "l": param1,
            "a": param2,
            "f": param3,
            "c": param4
        };
    }

    public function onDataLoaded(param1:Function):AllianceFindAppropriateAlliancesCmd {
        this._onDataLoaded = param1;
        return this;
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.FindAppropriateAlliances", this._dto, "POST").ifResult(function (param1:*):void {
            if (param1 == null) {
                return;
            }
            var _loc2_:* = param1.u == null ? new ArrayCustom() : UserNote.fromDtos(param1.u);
            if (_loc2_ && _loc2_.length > 0) {
                UserNoteManager.update(_loc2_);
            }
            var _loc3_:* = param1.a == null ? [] : AllianceSearchItem.fromDtos(param1.a);
            AllianceManager.updateAppropriateAlliances(_loc3_);
            var _loc4_:* = param1.n == null ? new ArrayCustom() : AllianceNote.fromDtos(param1.n);
            AllianceNoteManager.update(_loc4_);
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
