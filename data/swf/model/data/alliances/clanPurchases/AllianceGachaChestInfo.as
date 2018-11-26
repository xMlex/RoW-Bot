package model.data.alliances.clanPurchases {
import common.DateUtil;
import common.IEquatable;

public class AllianceGachaChestInfo implements IEquatable {


    public var index:int;

    public var chestId:int;

    public var issueTime:Date;

    public function AllianceGachaChestInfo() {
        super();
    }

    public static function fromDto(param1:*):AllianceGachaChestInfo {
        var _loc2_:AllianceGachaChestInfo = new AllianceGachaChestInfo();
        _loc2_.index = param1.i;
        _loc2_.chestId = param1.b;
        _loc2_.issueTime = new Date(param1.d);
        return _loc2_;
    }

    public function isEqual(param1:*):Boolean {
        var _loc2_:AllianceGachaChestInfo = param1 as AllianceGachaChestInfo;
        if (_loc2_ == null) {
            return false;
        }
        return this.index == _loc2_.index && this.chestId == _loc2_.chestId && DateUtil.compare(this.issueTime, _loc2_.issueTime) == DateUtil.DATES_EQUAL;
    }
}
}
