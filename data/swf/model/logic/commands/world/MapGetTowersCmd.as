package model.logic.commands.world {
import common.ArrayCustom;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.Dictionary;
import flash.utils.getTimer;

import model.data.alliances.AllianceNote;
import model.data.locations.LocationNote;
import model.data.map.MapPos;
import model.data.map.MapRect;
import model.data.users.UserNote;
import model.logic.AllianceNoteManager;
import model.logic.LocationNoteManager;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class MapGetTowersCmd extends BaseCmd {

    public static var isBusy:Boolean;

    public static var EVENT_COMMAND_FREE:String = "MapGetTowersCmd" + "CommandFree";

    public static var events:EventDispatcher = new EventDispatcher();

    private static const BLOCK_SIZE:int = 2000;

    private static var _knownBlocksWithTime:ArrayCustom = new ArrayCustom();


    private var _rect:MapRect;

    private var _locationType:int;

    public function MapGetTowersCmd(param1:MapRect, param2:int) {
        super();
        this._rect = param1;
        this._locationType = param2;
    }

    public static function reset():void {
        _knownBlocksWithTime = new ArrayCustom();
    }

    private static function addKnownBlocks(param1:ArrayCustom):void {
        var _loc3_:MapPos = null;
        var _loc4_:* = undefined;
        var _loc2_:Number = getTimer();
        for each(_loc3_ in param1) {
            _loc4_ = {
                "m": _loc3_,
                "t": _loc2_
            };
            _knownBlocksWithTime.addItem(_loc4_);
        }
    }

    private static function removeExpiredKnownBlocks():void {
        var _loc3_:* = undefined;
        var _loc4_:Number = NaN;
        var _loc1_:Number = getTimer();
        var _loc2_:int = 0;
        while (_loc2_ < _knownBlocksWithTime.length) {
            _loc3_ = _knownBlocksWithTime[_loc2_];
            _loc4_ = _loc3_.t;
            if (_loc1_ - _loc4_ > UserRefreshCmd.RefreshUserNoteTimeoutMs) {
                _knownBlocksWithTime.removeItemAt(_loc2_);
            }
            else {
                _loc2_++;
            }
        }
    }

    private static function getUnknownBlocks(param1:MapRect):ArrayCustom {
        var _loc4_:MapPos = null;
        var _loc5_:Boolean = false;
        var _loc6_:* = undefined;
        var _loc7_:MapPos = null;
        removeExpiredKnownBlocks();
        var _loc2_:ArrayCustom = getBlocks(param1);
        var _loc3_:ArrayCustom = new ArrayCustom();
        for each(_loc4_ in _loc2_) {
            _loc5_ = false;
            for each(_loc6_ in _knownBlocksWithTime) {
                _loc7_ = _loc6_.m;
                if (_loc7_.isEqual(_loc4_)) {
                    _loc5_ = true;
                    break;
                }
            }
            if (!_loc5_) {
                _loc3_.addItem(_loc4_);
            }
        }
        return _loc3_;
    }

    private static function getBlocks(param1:MapRect):ArrayCustom {
        var _loc4_:int = 0;
        var _loc2_:ArrayCustom = new ArrayCustom();
        param1 = convertRectToBlockRect(param1);
        var _loc3_:int = param1.x1;
        while (_loc3_ <= param1.x2) {
            _loc4_ = param1.y1;
            while (_loc4_ <= param1.y2) {
                _loc2_.addItem(new MapPos(_loc3_, _loc4_));
                _loc4_++;
            }
            _loc3_++;
        }
        return _loc2_;
    }

    private static function convertRectToBlockRect(param1:MapRect):MapRect {
        return new MapRect(convertPosToBlockPos(param1.x1), convertPosToBlockPos(param1.y1), convertPosToBlockPos(param1.x2), convertPosToBlockPos(param1.y2));
    }

    private static function convertPosToBlockPos(param1:int):int {
        return param1 >= 0 ? int(param1 / BLOCK_SIZE) : int((param1 - BLOCK_SIZE + 1) / BLOCK_SIZE);
    }

    override public function execute():void {
        var unknownBlocks:ArrayCustom = null;
        var locationNotes:Vector.<LocationNote> = null;
        var locationNotesDictionary:Dictionary = null;
        unknownBlocks = getUnknownBlocks(this._rect);
        if (unknownBlocks.length == 0) {
            if (_onResult != null) {
                locationNotes = LocationNoteManager.getLocationTypeByMapRect(this._locationType, this._rect);
                locationNotesDictionary = LocationNoteManager.getLocationDictionaryByType(this._locationType, locationNotes);
                _onResult(locationNotes, locationNotesDictionary);
            }
            if (_onFinally != null) {
                _onFinally();
            }
            return;
        }
        isBusy = true;
        var getMapDto:* = {"b": MapPos.toDtos(unknownBlocks)};
        new JsonCallCmd("GetTowersMap", getMapDto).ifResult(function (param1:*):void {
            var _loc5_:* = undefined;
            var _loc6_:* = undefined;
            var _loc2_:* = param1.n == null ? new ArrayCustom() : UserNote.fromDtos(param1.n);
            var _loc3_:* = param1.l == null ? new ArrayCustom() : LocationNote.fromDtos(param1.l);
            var _loc4_:* = param1.a == null ? new ArrayCustom() : AllianceNote.fromDtos(param1.a);
            addKnownBlocks(unknownBlocks);
            UserNoteManager.update(_loc2_);
            LocationNoteManager.update(_loc3_);
            AllianceNoteManager.update(_loc4_);
            if (_onResult != null) {
                _loc5_ = LocationNoteManager.getLocationTypeByMapRect(_locationType, _rect);
                _loc6_ = LocationNoteManager.getLocationDictionaryByType(_locationType, _loc5_);
                _onResult(_loc5_, _loc6_);
            }
        }).ifFault(function ():void {
            isBusy = false;
            events.dispatchEvent(new Event(EVENT_COMMAND_FREE));
            if (_onFault != null) {
                _onFault();
            }
        }).ifIoFault(_onIoFault).doFinally(function ():void {
            isBusy = false;
            events.dispatchEvent(new Event(EVENT_COMMAND_FREE));
            if (_onFinally != null) {
                _onFinally();
            }
        }).execute();
    }
}
}
