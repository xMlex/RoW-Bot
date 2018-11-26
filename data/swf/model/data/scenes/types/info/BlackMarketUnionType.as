package model.data.scenes.types.info {
public class BlackMarketUnionType {


    private var _goldMoneyTypeId:int;

    private var _blackCrystalTypeId:int;

    public function BlackMarketUnionType(param1:int, param2:int) {
        super();
        this._goldMoneyTypeId = param1;
        this._blackCrystalTypeId = param2;
    }

    public function get goldMoneyTypeId():int {
        return this._goldMoneyTypeId;
    }

    public function get blackCrystalTypeId():int {
        return this._blackCrystalTypeId;
    }

    public function hasItemTypeId(param1:int):Boolean {
        return param1 == this._goldMoneyTypeId || param1 == this._blackCrystalTypeId;
    }
}
}
