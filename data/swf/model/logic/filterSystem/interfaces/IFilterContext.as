package model.logic.filterSystem.interfaces {
public interface IFilterContext {


    function get name():String;

    function typeEquals(param1:IFilterContext):Boolean;

    function equals(param1:IFilterContext):Boolean;
}
}
