package model.logic.resourcesConversion.data {
import common.ArrayCustom;

import model.data.Resources;
import model.logic.UserManager;

public class ResourcesConversionJobType {


    public var id:int;

    public var inResources:Resources;

    public var outResources:Resources;

    public var durationHours:Number;

    public var outResourceTypeId:int;

    public function ResourcesConversionJobType() {
        super();
    }

    public static function fromDto(param1:*):ResourcesConversionJobType {
        var _loc2_:ResourcesConversionJobType = new ResourcesConversionJobType();
        _loc2_.id = param1.i;
        _loc2_.inResources = Resources.fromDto(param1.c);
        _loc2_.outResources = Resources.fromDto(param1.o);
        _loc2_.durationHours = param1.d == null ? Number(Number.NaN) : Number(param1.d);
        _loc2_.outResourceTypeId = param1.t;
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

    public function get canBeStarted():ResourcesConversionError {
        var _loc5_:Resources = null;
        var _loc1_:int = this.outResources.biochips;
        var _loc2_:int = UserManager.user.gameData.account.resources.biochips;
        var _loc3_:int = UserManager.user.gameData.account.resourcesLimit.biochips;
        if (_loc2_ + _loc1_ > _loc3_) {
            return new ResourcesConversionError(ResourcesConversionErrorEnum.MAX_LIMIT);
        }
        var _loc4_:Resources = UserManager.user.gameData.account.resources;
        if (this.inResources.uranium > _loc4_.uranium || this.inResources.titanite > _loc4_.titanite || this.inResources.money > _loc4_.money) {
            _loc5_ = new Resources();
            if (this.inResources.uranium > _loc4_.uranium) {
                _loc5_.uranium = this.inResources.uranium - _loc4_.uranium;
            }
            if (this.inResources.titanite > _loc4_.titanite) {
                _loc5_.titanite = this.inResources.titanite - _loc4_.titanite;
            }
            if (this.inResources.money > _loc4_.money) {
                _loc5_.money = this.inResources.money - _loc4_.money;
            }
            return new ResourcesConversionError(ResourcesConversionErrorEnum.NOT_ENOUGH_RESOURCES, _loc5_);
        }
        return new ResourcesConversionError(ResourcesConversionErrorEnum.OK);
    }
}
}
