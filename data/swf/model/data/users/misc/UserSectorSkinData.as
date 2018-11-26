package model.data.users.misc {
import common.ArrayCustom;
import common.DateUtil;

import gameObjects.observableObject.ObservableObject;

import model.data.SectorSkinType;
import model.data.temporarySkins.TemporarySectorSkinData;
import model.data.temporarySkins.TemporarySkin;
import model.data.temporarySkins.TemporarySkinBox;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;

public class UserSectorSkinData extends ObservableObject {

    public static const CLASS_NAME:String = "UserSectorSkinData";

    public static const PURCHASED_SKIN_TYPES_CHANGED:String = CLASS_NAME + "PURCHASED_SKIN_TYPES_CHANGED";

    public static const CURRENT_SKIN_TYPE_ID_CHANGED:String = CLASS_NAME + "CURRENT_SKIN_TYPE_ID_CHANGED";

    public static const CURRENT_TEMPORARY_SKIN_CHANGED:String = CLASS_NAME + "CURRENT_TEMPORARY_SKIN_CHANGED";


    public var purchasedSkinTypes:ArrayCustom;

    private var _currentSkinTypeId:int = -1;

    private var _temporarySectorSkinData:TemporarySectorSkinData;

    public var dirty:Boolean = false;

    public var temporarySkinDirty:Boolean = false;

    public function UserSectorSkinData() {
        this.purchasedSkinTypes = new ArrayCustom();
        super();
    }

    public static function fromDto(param1:*):UserSectorSkinData {
        var _loc3_:int = 0;
        var _loc4_:SectorSkinType = null;
        var _loc5_:SectorSkinType = null;
        var _loc2_:UserSectorSkinData = new UserSectorSkinData();
        for each(_loc3_ in param1.p) {
            _loc4_ = StaticDataManager.getSectorSkinType(_loc3_);
            if (_loc4_ != null) {
                _loc2_.purchasedSkinTypes.addItem(_loc4_);
            }
        }
        _loc2_.currentSkinTypeId = param1.c;
        if (_loc2_.currentSkinTypeId >= 0) {
            _loc5_ = StaticDataManager.getSectorSkinType(_loc2_.currentSkinTypeId);
            if (_loc5_ == null) {
                _loc2_.currentSkinTypeId = SectorSkinType.SectorSkinTypeId_Default;
            }
        }
        else {
            _loc2_.currentSkinTypeId = SectorSkinType.SectorSkinTypeId_Default;
        }
        _loc2_.temporarySectorSkinData = param1.t != null ? TemporarySectorSkinData.fromDto(param1.t) : null;
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public function get currentSkinTypeId():int {
        if (this.hasActiveTemporarySkin) {
            return this.temporarySectorSkinData.currentActiveSkin.skinTypeId;
        }
        return this._currentSkinTypeId;
    }

    public function set currentSkinTypeId(param1:int):void {
        this._currentSkinTypeId = param1;
        dispatchEvent(CURRENT_SKIN_TYPE_ID_CHANGED);
    }

    public function get temporarySectorSkinData():TemporarySectorSkinData {
        return this._temporarySectorSkinData;
    }

    public function set temporarySectorSkinData(param1:TemporarySectorSkinData):void {
        this._temporarySectorSkinData = param1;
    }

    public function checkSkinPurchased(param1:int):Boolean {
        var _loc2_:SectorSkinType = null;
        for each(_loc2_ in this.purchasedSkinTypes) {
            if (param1 == _loc2_.id) {
                return true;
            }
        }
        return false;
    }

    public function get hasActiveTemporarySkin():Boolean {
        var _loc2_:Date = null;
        var _loc1_:* = false;
        if (this.temporarySectorSkinData != null && this.temporarySectorSkinData.currentActiveSkin != null) {
            _loc2_ = this.temporarySectorSkinData.getCurrentSkinExpirationDate();
            _loc1_ = DateUtil.compare(ServerTimeManager.serverTimeNow, _loc2_) == DateUtil.FIRST_BEFORE;
        }
        return _loc1_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(PURCHASED_SKIN_TYPES_CHANGED);
            dispatchEvent(CURRENT_SKIN_TYPE_ID_CHANGED);
        }
        if (this.temporarySkinDirty) {
            this.temporarySkinDirty = false;
            dispatchEvent(CURRENT_TEMPORARY_SKIN_CHANGED);
        }
    }

    public function getCitySkinDefencePower():Number {
        if (this.currentSkinTypeId == SectorSkinType.SectorSkinTypeId_Default) {
            return 0;
        }
        return StaticDataManager.getSectorSkinType(this.currentSkinTypeId).defenceBonusPoints / 100;
    }

    public function setCurrentTemporarySkin(param1:int, param2:Date):void {
        if (this.temporarySectorSkinData == null) {
            return;
        }
        var _loc3_:TemporarySkinBox = this.temporarySectorSkinData.skinBoxes[param1];
        var _loc4_:TemporarySkin = _loc3_.skin;
        if (_loc4_ != null) {
            this.temporarySectorSkinData.prevActiveOrdinarySkinId = this._currentSkinTypeId;
            this.temporarySectorSkinData.currentActiveSkin = _loc4_;
            this.temporarySectorSkinData.lastActivationTime = param2;
            this.temporarySectorSkinData.deleteSkinFromUser(param1);
            this.temporarySkinDirty = true;
            this.dispatchEvents();
        }
    }

    public function updateCurrentSkin(param1:Date):void {
        var _loc2_:Date = null;
        if (this.temporarySectorSkinData == null) {
            return;
        }
        if (this.temporarySectorSkinData.currentActiveSkin != null) {
            _loc2_ = this.temporarySectorSkinData.getCurrentSkinExpirationDate();
            if (_loc2_.getTime() <= param1.getTime()) {
                this.temporarySectorSkinData.currentActiveSkin = null;
                this.currentSkinTypeId = this.temporarySectorSkinData.prevActiveOrdinarySkinId;
                this.temporarySkinDirty = true;
                this.dispatchEvents();
            }
        }
    }
}
}
