package model.logic.filterSystem.interfaces {
public interface IDataFilterList extends IDataFilter {


    function addFilter(param1:IDataFilter):void;

    function addContext(param1:IFilterContext):void;

    function addContextFilter(param1:IContextDataFilter):void;
}
}
