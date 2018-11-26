package model.data.promotionOffers {
import model.data.UserPrize;

public class UnitedPrize {


    private var _primaryPrize:UserPrize;

    private var _secondaryPrize:UserPrize;

    public function UnitedPrize() {
        super();
    }

    public static function createByPrimaryAndSecondary(param1:UserPrize, param2:UserPrize):UnitedPrize {
        var _loc3_:UnitedPrize = new UnitedPrize();
        _loc3_._primaryPrize = param1;
        _loc3_._secondaryPrize = param2;
        return _loc3_;
    }

    public static function fromDto(param1:*):UnitedPrize {
        var _loc2_:UnitedPrize = new UnitedPrize();
        _loc2_._primaryPrize = param1.p == null ? null : UserPrize.fromDto(param1.p);
        _loc2_._secondaryPrize = param1.s == null ? null : UserPrize.fromDto(param1.s);
        return _loc2_;
    }

    public function get primaryPrize():UserPrize {
        return this._primaryPrize;
    }

    public function get secondaryPrize():UserPrize {
        return this._secondaryPrize;
    }

    public function get unitedPrizes():UserPrize {
        return UserPrize.merge(this._primaryPrize, this._secondaryPrize);
    }

    public function clone():UnitedPrize {
        var _loc1_:UnitedPrize = new UnitedPrize();
        if (this._primaryPrize != null) {
            _loc1_._primaryPrize = this._primaryPrize.clone();
        }
        if (this._secondaryPrize != null) {
            _loc1_._secondaryPrize = this._secondaryPrize.clone();
        }
        return _loc1_;
    }

    public function hasBonusesExceptGoldMoney():Boolean {
        return this._primaryPrize && this._primaryPrize.hasBonusesExceptGoldMoney() || this._secondaryPrize && this._secondaryPrize.hasBonusesExceptGoldMoney();
    }

    public function hasBMI(param1:int):Boolean {
        var _loc2_:Boolean = false;
        if (this._primaryPrize != null && this._primaryPrize.hasBMI(param1)) {
            _loc2_ = true;
        }
        else if (this._secondaryPrize != null && this._secondaryPrize.hasBMI(param1)) {
            _loc2_ = true;
        }
        return _loc2_;
    }

    public function givePrizeToUser():void {
        if (this._primaryPrize != null) {
            this._primaryPrize.givePrizeToUser();
        }
        if (this._secondaryPrize != null) {
            this._secondaryPrize.givePrizeToUser();
        }
    }

    public function sourceMerge(param1:UnitedPrize):void {
        if (this._primaryPrize == null) {
            this._primaryPrize = new UserPrize();
        }
        if (this._secondaryPrize == null) {
            this._secondaryPrize = new UserPrize();
        }
        this._primaryPrize.sourceMerge(param1.primaryPrize);
        this._secondaryPrize.sourceMerge(param1.secondaryPrize);
    }
}
}
