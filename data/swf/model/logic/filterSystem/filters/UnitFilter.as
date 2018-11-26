package model.logic.filterSystem.filters {
import model.data.scenes.types.info.TroopsKindId;
import model.logic.filterSystem.contexts.blackMarket.UnitFilterContext;
import model.logic.filterSystem.dataProviders.IUnitDataProvider;

public class UnitFilter extends DataFilterBase {


    public function UnitFilter() {
        super();
        _context = new UnitFilterContext();
    }

    override protected function filter_impl(param1:Array):Array {
        var _loc5_:IUnitDataProvider = null;
        var _loc6_:int = 0;
        var _loc2_:UnitFilterContext = _context as UnitFilterContext;
        if (!_loc2_.typeIds || _loc2_.typeIds.length == 0) {
            return param1;
        }
        var _loc3_:Array = [];
        var _loc4_:int = 0;
        while (_loc4_ < param1.length) {
            _loc5_ = param1[_loc4_] as IUnitDataProvider;
            if (!_loc5_) {
                throw new Error("В UnitFilter попал массив с неправильными предметами.");
            }
            _loc6_ = _loc5_.attackBonus > 0 ? int(TroopsKindId.ATTACKING) : _loc5_.defenceBonus > 0 ? int(TroopsKindId.DEFENSIVE) : int(TroopsKindId.RECON);
            if (_loc2_.typeIds.indexOf(_loc6_) != -1 && !_loc5_.isStrategy) {
                _loc3_.push(_loc5_);
            }
            _loc4_++;
        }
        return _loc3_;
    }
}
}
