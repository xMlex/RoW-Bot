package model.data.scenes.types.info {
import common.ArrayCustom;

import model.data.scenes.types.info.troops.SupportParameters;

public class TroopsTypeInfo {


    private var _levelInfos:ArrayCustom;

    public var groupId:int;

    public var kindId:int;

    public var supportParameters:SupportParameters;

    public var diePriority:int;

    public var missileInfo:MissileInfo;

    public function TroopsTypeInfo() {
        super();
    }

    public static function fromDto(param1:*):TroopsTypeInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:TroopsTypeInfo = new TroopsTypeInfo();
        _loc2_._levelInfos = TroopsLevelInfo.fromDtos(param1.lc);
        _loc2_.groupId = param1.g;
        _loc2_.kindId = param1.k;
        _loc2_.supportParameters = param1.s == null ? null : SupportParameters.fromDto(param1.s);
        _loc2_.diePriority = param1.p;
        _loc2_.missileInfo = param1.m == null ? null : MissileInfo.fromDto(param1.m);
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

    public function get baseParameters():TroopsLevelInfo {
        return this._levelInfos[0];
    }

    public function get isAttacking():Boolean {
        return this.kindId == TroopsKindId.ATTACKING;
    }

    public function get isDefensive():Boolean {
        return this.kindId == TroopsKindId.DEFENSIVE;
    }

    public function get isRecon():Boolean {
        return this.kindId == TroopsKindId.RECON;
    }

    public function get isStrategy():Boolean {
        return this.supportParameters != null;
    }
}
}
