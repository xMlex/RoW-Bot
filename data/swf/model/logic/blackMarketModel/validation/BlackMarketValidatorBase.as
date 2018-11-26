package model.logic.blackMarketModel.validation {
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.validation.interfaces.IBlackMarketValidator;

public class BlackMarketValidatorBase implements IBlackMarketValidator {


    private var _validators:Vector.<IBlackMarketValidator>;

    public function BlackMarketValidatorBase() {
        super();
        this._validators = new Vector.<IBlackMarketValidator>();
    }

    public function validate(param1:BlackMarketItemBase):Boolean {
        var _loc2_:Boolean = true;
        var _loc3_:int = 0;
        while (_loc3_ < this._validators.length) {
            if (!this._validators[_loc3_].validate(param1)) {
                return false;
            }
            _loc3_++;
        }
        return _loc2_;
    }

    public function concat(param1:IBlackMarketValidator):void {
        this._validators.push(param1);
    }
}
}
