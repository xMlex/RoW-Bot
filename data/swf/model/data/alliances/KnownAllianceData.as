package model.data.alliances {
import common.ArrayCustom;

import gameObjects.observableObject.ObservableObject;

public class KnownAllianceData extends ObservableObject {

    public static const CLASS_NAME:String = "KnownAllianceData";

    public static const KNOWN_ALLIANCES_CHANGED:String = CLASS_NAME + "KnownAlliancesChanged";


    public var knownAlliances:ArrayCustom;

    public var knownAlliancesRequests:ArrayCustom;

    public var proposal:KnownAllianceProposal;

    public var dirty:Boolean = false;

    public function KnownAllianceData() {
        super();
    }

    public static function fromDto(param1:*):KnownAllianceData {
        var _loc2_:KnownAllianceData = new KnownAllianceData();
        _loc2_.knownAlliances = param1.k == null ? new ArrayCustom() : KnownAlliance.fromDtos(param1.k);
        _loc2_.knownAlliancesRequests = param1.r == null ? new ArrayCustom() : KnownAllianceRequest.fromDtos(param1.r);
        _loc2_.proposal = param1.p == null ? null : KnownAllianceProposal.fromDto(param1.p);
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(KNOWN_ALLIANCES_CHANGED);
        }
    }

    public function getKnownAllianceIds():Array {
        var _loc2_:KnownAlliance = null;
        var _loc1_:Array = new Array();
        if (!this.knownAlliances) {
            return _loc1_;
        }
        for each(_loc2_ in this.knownAlliances) {
            _loc1_.push(_loc2_.allianceId);
        }
        return _loc1_;
    }

    public function getKnownAllianceById(param1:Number):KnownAlliance {
        var _loc2_:KnownAlliance = null;
        for each(_loc2_ in this.knownAlliances) {
            if (_loc2_.allianceId == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function getKnownAllianceRequestById(param1:Number):KnownAllianceRequest {
        var _loc2_:KnownAllianceRequest = null;
        for each(_loc2_ in this.knownAlliancesRequests) {
            if (_loc2_.allianceId == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function removeKnownAllianceById(param1:Number):Boolean {
        var _loc4_:KnownAlliance = null;
        var _loc2_:ArrayCustom = new ArrayCustom();
        var _loc3_:KnownAlliance = this.getKnownAllianceById(param1);
        if (!_loc3_) {
            return false;
        }
        for each(_loc4_ in this.knownAlliances) {
            if (_loc4_.allianceId != _loc3_.allianceId) {
                _loc2_.addItem(_loc4_);
            }
        }
        this.knownAlliances = _loc2_;
        this.dirty = true;
        return true;
    }

    public function removeKnownAllianceRequestById(param1:Number):Boolean {
        var _loc4_:KnownAllianceRequest = null;
        var _loc2_:ArrayCustom = new ArrayCustom();
        var _loc3_:KnownAllianceRequest = this.getKnownAllianceRequestById(param1);
        if (!_loc3_) {
            return false;
        }
        for each(_loc4_ in this.knownAlliancesRequests) {
            if (_loc4_.allianceId != _loc3_.allianceId) {
                _loc2_.addItem(_loc4_);
            }
        }
        this.knownAlliancesRequests = _loc2_;
        this.dirty = true;
        return true;
    }
}
}
