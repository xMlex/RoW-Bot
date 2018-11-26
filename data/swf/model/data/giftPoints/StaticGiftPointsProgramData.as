package model.data.giftPoints {
import model.data.giftPoints.enums.GiftPointsProgramDepositorGroup;
import model.logic.UserManager;

public final class StaticGiftPointsProgramData {


    private var _bonuses:Array;

    private var _bonusesDepositors1to4:Array;

    private var _bonusesDepositors5to6:Array;

    private var _zeroBonus:GiftPointsProgramBonus;

    public function StaticGiftPointsProgramData(param1:Array) {
        var _loc2_:GiftPointsProgramBonus = null;
        this._zeroBonus = new GiftPointsProgramBonus();
        super();
        this._bonuses = param1;
        this._bonusesDepositors1to4 = [];
        this._bonusesDepositors5to6 = [];
        for each(_loc2_ in this._bonuses) {
            if (_loc2_.depositorGroupId == GiftPointsProgramDepositorGroup.Group1To4) {
                this._bonusesDepositors1to4.push(_loc2_);
            }
            else if (_loc2_.depositorGroupId == GiftPointsProgramDepositorGroup.Group5To6) {
                this._bonusesDepositors5to6.push(_loc2_);
            }
        }
        this._zeroBonus = new GiftPointsProgramBonus();
        this._bonusesDepositors1to4 = this.setClientData(this._bonusesDepositors1to4);
        this._bonusesDepositors5to6 = this.setClientData(this._bonusesDepositors5to6);
    }

    public static function fromDto(param1:*):StaticGiftPointsProgramData {
        var _loc2_:Array = GiftPointsProgramBonus.fromDtos(param1.b);
        var _loc3_:StaticGiftPointsProgramData = new StaticGiftPointsProgramData(_loc2_);
        return _loc3_;
    }

    public function get bonuses():Array {
        if (UserManager.user.gameData.giftPointsProgramData.depositorGroup == GiftPointsProgramDepositorGroup.Group1To4) {
            return this._bonusesDepositors1to4;
        }
        if (UserManager.user.gameData.giftPointsProgramData.depositorGroup == GiftPointsProgramDepositorGroup.Group5To6) {
            return this._bonusesDepositors5to6;
        }
        return this._bonuses;
    }

    public function get maxBonus():GiftPointsProgramBonus {
        if (this.bonuses.length > 0) {
            return this.bonuses[this.bonuses.length - 1];
        }
        return null;
    }

    public function getBonusByPoints(param1:int):GiftPointsProgramBonus {
        if (param1 >= this.bonuses[this.bonuses.length - 1].costInGiftPoints) {
            return this.bonuses[this.bonuses.length - 1];
        }
        if (param1 < this.bonuses[0].costInGiftPoints) {
            this._zeroBonus.nextBonus = this.bonuses[0];
            return this._zeroBonus;
        }
        var _loc2_:GiftPointsProgramBonus = this.bonuses[0];
        while (param1 >= _loc2_.nextBonus.costInGiftPoints) {
            _loc2_ = _loc2_.nextBonus;
        }
        return _loc2_;
    }

    private function setClientData(param1:Array):Array {
        var _loc2_:GiftPointsProgramBonus = null;
        var _loc3_:GiftPointsProgramBonus = null;
        var _loc4_:int = param1.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            _loc3_ = param1[_loc5_];
            _loc3_.level = _loc5_ + 1;
            if (_loc2_ != null) {
                _loc2_.nextBonus = _loc3_;
            }
            _loc2_ = _loc3_;
            _loc5_++;
        }
        return param1;
    }
}
}
