package model.logic.commands.user {
import common.ArrayCustom;

import model.data.alliances.AllianceNote;
import model.data.users.UserNote;
import model.data.users.UserThreat;
import model.logic.AllianceNoteManager;
import model.logic.ServerManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class GetMyThreatCmd extends BaseCmd {

    public static var threats:ArrayCustom = new ArrayCustom();


    private const ThreatsCount:int = 12;

    private var _onComplete:Function;

    private var callCount:int = 0;

    public function GetMyThreatCmd() {
        super();
    }

    public static function getThreatsById(param1:Number):UserThreat {
        var _loc2_:UserThreat = null;
        for each(_loc2_ in threats) {
            if (_loc2_.userId == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    private function decreaseCallCount():void {
        this.callCount--;
        if (this.callCount == 0) {
            if (!threats) {
                return;
            }
            threats.sortOn("strength", Array.NUMERIC);
            if (threats.length > this.ThreatsCount) {
                threats.splice(this.ThreatsCount);
            }
            if (this._onComplete != null) {
                this._onComplete(threats);
            }
        }
    }

    public function onComplete(param1:Function):GetMyThreatCmd {
        this._onComplete = param1;
        return this;
    }

    override public function execute():void {
        this.callCount++;
        if (UserManager.user.gameData.account.level < StaticDataManager.skilledUserLevel) {
            this.decreaseCallCount();
            return;
        }
        new JsonCallCmd("GetMyThreat", null, "POST").ifResult(function (param1:*):void {
            var dto:* = param1;
            if (dto == null) {
                return;
            }
            var requestDto:* = dto.d;
            threats = new ArrayCustom();
            parseThreats(threats, dto.r);
            var segmentId:* = 0;
            while (segmentId < ServerManager.SegmentServerAddresses.length) {
                if (segmentId != UserManager.segmentId) {
                    callCount++;
                    new JsonCallCmd("GetThreat", requestDto, "POST").setSegment(segmentId).ifResult(function (param1:*):void {
                        if (param1 == null) {
                            return;
                        }
                        parseThreats(threats, param1);
                    }).ifFault(_onFault).doFinally(function ():void {
                        decreaseCallCount();
                    }).execute();
                }
                segmentId++;
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(function ():void {
            decreaseCallCount();
        }).execute();
    }

    private function parseThreats(param1:ArrayCustom, param2:*):void {
        var _loc3_:ArrayCustom = UserNote.fromDtos(param2.n);
        var _loc4_:ArrayCustom = AllianceNote.fromDtos(param2.a);
        var _loc5_:ArrayCustom = UserThreat.fromDtos(param2.t);
        if (_loc5_.length > 0) {
            param1.addAll(_loc5_);
        }
        AllianceNoteManager.update(_loc4_);
        UserNoteManager.update(_loc3_);
    }
}
}
