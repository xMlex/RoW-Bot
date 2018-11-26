package model.logic.filterSystem.filters {
import model.logic.filterSystem.interfaces.IContextDataFilter;
import model.logic.filterSystem.interfaces.IFilterContext;

public class DataFilterBase implements IContextDataFilter {


    protected var _context:IFilterContext;

    public function DataFilterBase() {
        super();
    }

    protected function filter_impl(param1:Array):Array {
        throw new Error("DataFilterBase.filter_impl() не был переопределён!");
    }

    public function getContext():IFilterContext {
        return this._context;
    }

    public final function setContext(param1:IFilterContext):void {
        if (!this._context.typeEquals(param1)) {
            throw new Error("Попытка засунуть в фильтр несоответствующий контекст!");
        }
        this._context = param1;
    }

    public final function filter(param1:Array):Array {
        if (!param1) {
            throw new Error("В фильтр пришли пустые данные. Скорее всего, ошибка в переменной _useFilter - она false. " + "Имеет смысл посмотреть контекст данного фильтра и выяснить, как работают методы typeEquals и equals.");
        }
        return this.filter_impl(param1);
    }
}
}
