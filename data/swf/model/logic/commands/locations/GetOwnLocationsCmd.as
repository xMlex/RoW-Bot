package model.logic.commands.locations {
import common.ArrayCustom;

import flash.events.Event;
import flash.utils.Dictionary;

import model.data.GeotopiaLogicExceptionCode;
import model.data.locations.Location;
import model.data.users.UserNote;
import model.logic.LocationNoteManager;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.FaultDto;
import model.logic.commands.server.JsonCallCmd;

public class GetOwnLocationsCmd extends BaseCmd {


    private var _ids:Array;

    private var _locations:ArrayCustom;

    private var _activeCalls:int;

    private var _faulted:Boolean = false;

    public function GetOwnLocationsCmd(param1:Array) {
        this._locations = new ArrayCustom();
        super();
        this._ids = param1;
    }

    private static function getLocationIdsBySegment(param1:Array):Dictionary {
        var _loc3_:Number = NaN;
        var _loc4_:int = 0;
        var _loc2_:Dictionary = new Dictionary();
        for each(_loc3_ in param1) {
            _loc4_ = LocationNoteManager.getMineById(_loc3_).segmentId;
            if (_loc2_[_loc4_] == null) {
                _loc2_[_loc4_] = new Array();
            }
            _loc2_[_loc4_].push(_loc3_);
        }
        return _loc2_;
    }

    override public function execute():void {
        var segmentId:* = undefined;
        var cmd:BaseCmd = null;
        var dto:Object = null;
        var command:BaseCmd = null;
        if (this._ids == null || this._ids.length == 0) {
            if (_onResult != null) {
                _onResult(this._locations);
            }
            if (_onFinally != null) {
                _onFinally();
            }
        }
        var commands:ArrayCustom = new ArrayCustom();
        var locationIdsBySegment:Dictionary = getLocationIdsBySegment(this._ids);
        for (segmentId in locationIdsBySegment) {
            dto = {"l": locationIdsBySegment[segmentId]};
            command = new JsonCallCmd("GetOwnLocations", dto, "POST").setSegment(segmentId).ifResult(function (param1:*):void {
                var _loc3_:* = undefined;
                var _loc2_:* = Location.fromDtos(param1.l);
                _locations.addAll(_loc2_);
                if (param1.u != null) {
                    _loc3_ = UserNote.fromDtos(param1.u);
                    UserNoteManager.update(_loc3_);
                }
                _activeCalls--;
                if (_activeCalls == 0 && _onResult != null) {
                    _onResult(_locations);
                }
            }).ifFault(function (param1:FaultDto):void {
                var _loc2_:* = undefined;
                _activeCalls--;
                if (!_faulted) {
                    _faulted = true;
                }
                else if (_onFault != null) {
                    _onFault(param1);
                }
                else {
                    _loc2_ = JsonCallCmd.getDefaultFaultHandler();
                    if (_loc2_ != null) {
                        _loc2_(param1);
                    }
                }
            }).ifIoFault(function (param1:Event):void {
                var _loc2_:* = undefined;
                var _loc3_:* = undefined;
                _activeCalls--;
                if (!_faulted) {
                    _faulted = true;
                }
                else if (_onIoFault != null) {
                    _onIoFault(param1);
                }
                else {
                    _loc2_ = new FaultDto(GeotopiaLogicExceptionCode.SERVER_UNAVAILABLE, "IO error");
                    if (_onFault != null) {
                        _onFault(_loc2_);
                    }
                    else {
                        _loc3_ = JsonCallCmd.getDefaultFaultHandler();
                        if (_loc3_ != null) {
                            _loc3_(_loc2_);
                        }
                    }
                }
            }).doFinally(function ():void {
                if (_onFinally != null && _activeCalls == 0) {
                    _onFinally();
                }
            });
            commands.addItem(command);
        }
        this._activeCalls = commands.length;
        for each(cmd in commands) {
            cmd.execute();
        }
    }
}
}
