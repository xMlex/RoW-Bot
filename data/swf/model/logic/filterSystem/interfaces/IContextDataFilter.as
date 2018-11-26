package model.logic.filterSystem.interfaces {
public interface IContextDataFilter extends IDataFilter {


    function getContext():IFilterContext;

    function setContext(param1:IFilterContext):void;
}
}
