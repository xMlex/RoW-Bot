package model.logic.effects {
import flash.utils.Dictionary;

import model.data.effects.EffectTypeId;

public class DependentEffectsBuilder {

    private static var _dependentEffects:Dictionary;

    {
        initialize();
    }

    public function DependentEffectsBuilder() {
        super();
    }

    private static function initialize():void {
        _dependentEffects = new Dictionary();
        _dependentEffects[EffectTypeId.UserFullProtection] = [EffectTypeId.UserProtectionIntelligence];
        _dependentEffects[EffectTypeId.UserProtectionIntelligence] = [EffectTypeId.UserFullProtection];
        _dependentEffects[EffectTypeId.UserAttackAndDefensePowerBonus] = [EffectTypeId.UserAttackPower, EffectTypeId.UserDefensePower];
        _dependentEffects[EffectTypeId.UserAttackPower] = [EffectTypeId.UserAttackAndDefensePowerBonus];
        _dependentEffects[EffectTypeId.UserDefensePower] = [EffectTypeId.UserAttackAndDefensePowerBonus];
    }

    public static function getList(param1:int):Array {
        return _dependentEffects[param1];
    }
}
}
