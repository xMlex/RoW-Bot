package model.data.inventory {
public class InventoryItemTypeInfo {


    public var levelInfos:Vector.<InventoryItemLevelInfo>;

    public var inventoryItemRareness:int;

    public var inventoryItemGroup:int;

    public var affectedGroupIds:Vector.<int>;

    public var affectedTypeIds:Vector.<int>;

    public var requiredTier:Number;

    public var requiredRaidLocationMinLevel:Number;

    public var minBaseAttackBonus:Number;

    public var maxBaseAttackBonus:Number;

    public var minBaseDefenseBonus:Number;

    public var maxBaseDefenseBonus:Number;

    public function InventoryItemTypeInfo() {
        super();
    }

    public static function fromDto(param1:*):InventoryItemTypeInfo {
        var _loc6_:* = undefined;
        var _loc7_:* = undefined;
        if (param1 == null) {
            return null;
        }
        var _loc2_:InventoryItemTypeInfo = new InventoryItemTypeInfo();
        var _loc3_:Vector.<InventoryItemLevelInfo> = new Vector.<InventoryItemLevelInfo>(0);
        var _loc4_:Vector.<int> = new Vector.<int>(0);
        var _loc5_:Vector.<int> = new Vector.<int>(0);
        for each(_loc6_ in param1.f) {
            _loc5_.push(_loc6_);
        }
        for each(_loc7_ in param1.li) {
            _loc3_.push(InventoryItemLevelInfo.fromDto(_loc7_));
        }
        _loc2_.levelInfos = _loc3_;
        _loc2_.inventoryItemRareness = param1.r;
        _loc2_.inventoryItemGroup = param1.g;
        _loc2_.affectedTypeIds = _loc4_;
        _loc2_.affectedGroupIds = _loc5_;
        _loc2_.requiredTier = param1.rs;
        _loc2_.requiredRaidLocationMinLevel = param1.m;
        _loc2_.minBaseAttackBonus = param1.ma;
        _loc2_.maxBaseAttackBonus = param1.mx;
        _loc2_.minBaseDefenseBonus = param1.md;
        _loc2_.maxBaseDefenseBonus = param1.xd;
        return _loc2_;
    }

    public function getLevelInfo(param1:int):InventoryItemLevelInfo {
        return this.levelInfos[param1] as InventoryItemLevelInfo;
    }
}
}
