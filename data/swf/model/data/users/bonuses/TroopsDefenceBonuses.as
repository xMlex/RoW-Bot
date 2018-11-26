package model.data.users.bonuses {
import common.GameType;

public class TroopsDefenceBonuses {


    public var defenceInfantryBonus:Number;

    public var defenceArmouredBonus:Number;

    public var defenceArtilleryBonus:Number;

    public var defenceAerospaceBonus:Number;

    public var defenceAvpBonus:Number;

    public function TroopsDefenceBonuses() {
        super();
        this.defenceInfantryBonus = 0;
        this.defenceArmouredBonus = 0;
        this.defenceArtilleryBonus = 0;
        this.defenceAerospaceBonus = 0;
        this.defenceAvpBonus = 0;
    }

    public function getAverage():Number {
        var _loc1_:Number = this.defenceInfantryBonus + this.defenceArmouredBonus + this.defenceArtilleryBonus + this.defenceAerospaceBonus;
        if (GameType.isMilitary) {
            return (_loc1_ + this.defenceAvpBonus) / 5;
        }
        return _loc1_ / 4;
    }
}
}
