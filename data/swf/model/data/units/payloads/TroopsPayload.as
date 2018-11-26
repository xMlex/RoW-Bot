package model.data.units.payloads {
import common.ArrayCustom;

import model.data.Resources;
import model.data.users.troops.Troops;

public class TroopsPayload {


    public var order:int;

    public var slotId:int = -1;

    public var troops:Troops;

    public var supportTroops:ArrayCustom;

    public var resources:Resources;

    public var isFromAttackWindow:Boolean = false;

    public function TroopsPayload() {
        super();
    }

    public static function fromDto(param1:*):TroopsPayload {
        var _loc2_:TroopsPayload = new TroopsPayload();
        _loc2_.order = param1.o;
        _loc2_.troops = param1.t == null ? null : Troops.fromDto(param1.t);
        _loc2_.supportTroops = param1.s == null ? null : SupportTroops.fromDtos(param1.s);
        _loc2_.resources = param1.r == null ? null : Resources.fromDto(param1.r);
        return _loc2_;
    }

    public function get hasSupport():Boolean {
        return this.supportTroops != null;
    }

    public function isSupportedBy(param1:Number):Boolean {
        return this.getSupportTroops(param1) != null;
    }

    public function getSupportTroops(param1:Number):SupportTroops {
        var _loc2_:SupportTroops = null;
        if (!this.hasSupport) {
            return null;
        }
        for each(_loc2_ in this.supportTroops) {
            if (_loc2_.ownerUserId == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function toDto():* {
        var _loc1_:* = {
            "o": this.order,
            "t": (this.troops == null ? null : this.troops.toDto()),
            "s": (this.supportTroops == null || this.supportTroops.length == 0 ? null : SupportTroops.toDtos(this.supportTroops)),
            "r": (this.resources == null ? null : this.resources.toDto()),
            "w": this.isFromAttackWindow,
            "si": (this.slotId == -1 ? null : this.slotId)
        };
        return _loc1_;
    }
}
}
