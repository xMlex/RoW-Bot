package model.logic.commands.world {
import common.ArrayCustom;

import flash.utils.getTimer;

import model.data.locations.LocationNote;
import model.data.map.MapPos;
import model.data.map.MapRect;
import model.data.users.UserNote;
import model.logic.AllianceNoteManager;
import model.logic.LocationNoteManager;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.alliances.AllianceGetNotesCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class MapGetCmd extends BaseCmd {

    public static const BLOCK_SIZE:int = 20;

    private static var _knownBlocksWithTime:ArrayCustom = new ArrayCustom();


    private var _rect:MapRect;

    public function MapGetCmd(param1:MapRect) {
        super();
        this._rect = param1;
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

    public static function removeUnknownBloke(param1:MapRect):void {
        var _loc4_:MapPos = null;
        var _loc5_:int = 0;
        var _loc6_:* = undefined;
        var _loc7_:int = 0;
        var _loc8_:MapPos = null;
        var _loc9_:int = 0;
        removeExpiredKnownBlocks();
        var _loc2_:ArrayCustom = getBlocks(param1);
        var _loc3_:Vector.<Object> = new Vector.<Object>();
        for each(_loc4_ in _loc2_) {
            _loc7_ = 0;
            while (_loc7_ < _knownBlocksWithTime.length) {
                _loc6_ = _knownBlocksWithTime[_loc7_];
                _loc8_ = _loc6_.m;
                if (_loc8_.isEqual(_loc4_)) {
                    _loc3_.push(_loc6_);
                }
                _loc7_++;
            }
        }
        _loc5_ = 0;
        while (_loc5_ < _loc3_.length) {
            _loc9_ = _knownBlocksWithTime.getItemIndex(_loc3_[_loc5_]);
            _knownBlocksWithTime.removeItemAt(_loc9_);
            _loc5_++;
        }
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
        var userNotes:ArrayCustom = null;
        var locationNotes:ArrayCustom = null;
        var unknownAlliances:ArrayCustom = null;
        var userNote:UserNote = null;
        var res:Function = null;
        unknownBlocks = getUnknownBlocks(this._rect);
        if (unknownBlocks.length == 0) {
            if (_onResult != null) {
                userNotes = UserNoteManager.getByMapRect(this._rect);
                locationNotes = LocationNoteManager.getByMapRect(this._rect);
                unknownAlliances = new ArrayCustom();
                for each(userNote in userNotes) {
                    if (!isNaN(userNote.allianceId) && !AllianceNoteManager.hasNote(userNote.allianceId)) {
                        unknownAlliances.addItem(userNote.allianceId);
                    }
                }
                if (unknownAlliances.length > 0) {
                    res = _onResult;
                    new AllianceGetNotesCmd(unknownAlliances).ifResult(function ():void {
                        if (res != null) {
                            res(userNotes, locationNotes);
                        }
                    }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
                    return;
                }
                _onResult(userNotes, locationNotes);
            }
            if (_onFinally != null) {
                _onFinally();
            }
            return;
        }
        var getMapDto:* = {"b": MapPos.toDtos(unknownBlocks)};
        new JsonCallCmd("GetMap", getMapDto).ifResult(function (param1:*):void {
            var newUserNotes:* = undefined;
            var newLocationNotes:* = undefined;
            var userNote:* = undefined;
            var locationNote:* = undefined;
            var res:* = undefined;
            var userNotes:* = undefined;
            var locationNotes:* = undefined;
            var dto:* = param1;
            newUserNotes = UserNote.fromDtos(dto.n);
            newLocationNotes = dto.l == null ? new ArrayCustom() : LocationNote.fromDtos(dto.l);
            var unknownAlliances:* = new ArrayCustom();
            for each(userNote in newUserNotes) {
                if (!isNaN(userNote.allianceId) && !AllianceNoteManager.hasNote(userNote.allianceId)) {
                    unknownAlliances.addItem(userNote.allianceId);
                }
            }
            for each(locationNote in newLocationNotes) {
                if (!isNaN(locationNote.occupantAllianceId) && !AllianceNoteManager.hasNote(locationNote.occupantAllianceId)) {
                    unknownAlliances.addItem(locationNote.occupantAllianceId);
                }
            }
            if (unknownAlliances.length > 0) {
                res = _onResult;
                new AllianceGetNotesCmd(unknownAlliances).ifResult(function ():void {
                    var _loc1_:* = undefined;
                    var _loc2_:* = undefined;
                    if (res != null) {
                        addKnownBlocks(unknownBlocks);
                        UserNoteManager.update(newUserNotes);
                        LocationNoteManager.update(newLocationNotes);
                        _loc1_ = UserNoteManager.getByMapRect(_rect);
                        _loc2_ = LocationNoteManager.getByMapRect(_rect);
                        if (res != null) {
                            res(_loc1_, _loc2_);
                        }
                    }
                }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
                return;
            }
            addKnownBlocks(unknownBlocks);
            UserNoteManager.update(newUserNotes);
            LocationNoteManager.update(newLocationNotes);
            if (_onResult != null) {
                userNotes = UserNoteManager.getByMapRect(_rect);
                locationNotes = LocationNoteManager.getByMapRect(_rect);
                _onResult(userNotes, locationNotes);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
