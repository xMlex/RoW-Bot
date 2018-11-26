package model.logic.filterSystem.dataProviders {
public interface IUnitDataProvider extends IIDProvider {


    function get isStrategy():Boolean;

    function get attackBonus():int;

    function get defenceBonus():Number;

    function get intelligenceBonus():Number;
}
}
