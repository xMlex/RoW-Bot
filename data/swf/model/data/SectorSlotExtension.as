package model.data {
import common.ArrayCustom;

public class SectorSlotExtension {


    public var slotIds:ArrayCustom;

    public var isForFriends:Boolean;

    public function SectorSlotExtension() {
        super();
    }

    public function toDto():* {
        var _loc1_:* = {
            "f": this.isForFriends,
            "s": (!!this.slotIds ? this.slotIds : null)
        };
        return _loc1_;
    }
}
}
