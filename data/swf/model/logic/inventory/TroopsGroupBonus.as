package model.logic.inventory {
public class TroopsGroupBonus {


    private var _attack:Number;

    private var _defense:Number;

    public function TroopsGroupBonus(param1:Number, param2:Number) {
        super();
        this._attack = param1;
        this._defense = param2;
    }

    public function get attack():Number {
        return this._attack;
    }

    public function get defense():Number {
        return this._defense;
    }

    public function get isAttack():Boolean {
        return this._attack > 0;
    }

    public function get isDefense():Boolean {
        return this._defense > 0;
    }
}
}
